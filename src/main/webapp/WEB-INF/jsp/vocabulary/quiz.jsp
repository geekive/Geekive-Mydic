<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<c:set var="pageContent">
    <main class="quiz-center" aria-label="뜻 맞추기">
      <section class="quiz-shell" aria-label="단어 카드 슬라이더">
        <div class="quiz-inner">

          <div class="quiz-head">
            <div class="quiz-title">
              <h2 style="padding-bottom: 10px;">Quiz</h2>
            </div>

            <div style="display:flex; align-items:center; gap:10px; flex-wrap:wrap; justify-content:flex-end;">
              <button type="button" class="btn" id="btnSwap" aria-label="Switch quiz direction" style="border-radius:999px; padding:10px 12px;">
                KR → EN
              </button>

              <!-- NEW: Shuffle button (randomize only when clicked) -->
              <button type="button" class="btn" id="btnShuffle" aria-label="Shuffle words" style="border-radius:999px; padding:10px 12px;">
                Shuffle
              </button>

              <div class="quiz-stat" id="quizStat">
                <span class="dot" aria-hidden="true"></span>
                <span id="statText">1 / 1</span>
              </div>
            </div>
          </div>

          <div class="quiz-frame" id="quizFrame" aria-label="스와이프 영역">
            <div class="track" id="track" aria-live="polite"></div>
          </div>

          <div class="controls" aria-label="이전/다음 컨트롤">
			<button type="button" class="btn control-btn" id="btnPrev" aria-label="Previous word">
			  <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
			    <path d="M15 18l-6-6 6-6" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
			  </svg>
			  Previous
			</button>

			<button type="button" class="btn primary control-btn" id="btnToggleAnswer" aria-label="Show answer">
			  Show Answer
			</button>

			<button type="button" class="btn control-btn" id="btnNext" aria-label="Next word">
			  Next
			  <svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
			    <path d="M9 6l6 6-6 6" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
			  </svg>
			</button>
          </div>
        </div>
      </section>
    </main>

  <script>
    $(function () {

      /* =========================
         Words (AJAX로 채움)
         - 최초 로드는 서버 응답 순서 그대로 표시
         - Shuffle 버튼을 눌렀을 때만 랜덤 섞기
      ========================= */
      var words = [];
      var originalWords = []; // NEW: server order preserved

      function normalizeWordsFromResponse(vocaList) {
        var out = [];
        $.each(vocaList || [], function (index, item) {
          out.push({
            vocabularyUid: item.vocabularyUid,
            english: item.english,
            korean: item.korean,
            example: item.example,
            source: item.source,
            registrationDate: item.registrationDate
          });
        });
        return out;
      }

      function fetchWords() {
        return $.ajax({
          type: "post",
          url: getFullPath("/vocabulary/list"),
          contentType: "application/json"
        }).then(function (response) {
          if (response && response.resultCode == 1) {
            return normalizeWordsFromResponse(response.vocaList);
          }
          var msg = (response && response.resultMessage) ? response.resultMessage : "단어 목록을 불러오지 못했습니다.";
          return $.Deferred().reject(msg).promise();
        });
      }

      /* =========================
         UI helpers
      ========================= */
      function escapeHtml(str) {
        return String(str == null ? "" : str)
          .replaceAll("&", "&amp;")
          .replaceAll("<", "&lt;")
          .replaceAll(">", "&gt;")
          .replaceAll('"', "&quot;")
          .replaceAll("'", "&#039;");
      }

      /* =========================
         Quiz logic (words 로드 이후 초기화)
      ========================= */
      var state = {
        idx: 0,
        revealed: false,
        mode: "EN_TO_KR" // EN_TO_KR: 영어 보여주고 한글 맞추기 / KR_TO_EN: 한글 보여주고 영어 맞추기
      };

      var $track = $("#track");
      var $frame = $("#quizFrame");
      var $statText = $("#statText");
      var $btnSwap = $("#btnSwap");
      var $btnShuffle = $("#btnShuffle"); // NEW
      var $btnToggleAnswer = $("#btnToggleAnswer");

      function clamp(n, min, max) { return Math.max(min, Math.min(max, n)); }

      function slideWidth() {
        return Math.round($frame[0].clientWidth || 1);
      }

      function currentBaseX() {
        return -state.idx * slideWidth();
      }

      function setTrackX(px, withAnim) {
        if (withAnim) $track.removeClass("dragging bouncing");
        else $track.addClass("dragging");
        $track.css("transform", "translate3d(" + px + "px,0,0)");
      }

      function getPromptText(w) {
        if (state.mode === "KR_TO_EN") return escapeHtml(w.korean);
        return escapeHtml(w.english);
      }

      function getAnswerText(w) {
        if (state.mode === "KR_TO_EN") return escapeHtml(w.english);
        return escapeHtml(w.korean);
      }

      function getExampleText(w) {
        return escapeHtml(w.example || "");
      }

      function getAnswerLabel() {
        return state.mode === "KR_TO_EN" ? "Answer (English)" : "Answer (Korean Meaning)";
      }

      function getSwapButtonText() {
        return state.mode === "KR_TO_EN" ? "EN → KR" : "KR → EN";
      }

      function getToggleButtonText() {
        return state.revealed ? "Hide Answer" : "Show Answer";
      }

      function renderSlides() {
        if (!words.length) {
          $track.html(
            '<div class="slide" data-idx="0">' +
              '<div class="card" role="group" aria-label="No Data">' +
                '<div class="word-box">' +
                  '<p class="word-eng">No Words</p>' +
                  '<p class="word-sub">There are no registered words. Please add a word and try again.</p>' +
                '</div>' +
              '</div>' +
            '</div>'
          );
          return;
        }

        var html = "";
        for (var i = 0; i < words.length; i++) {
          var w = words[i];

          html += ''
            + '<div class="slide" data-idx="' + i + '">'
            + '  <div class="card" role="group" aria-label="단어 카드 ' + (i + 1) + '">'
            + '    <div class="card-top">'
            + '      <div class="chips">';

          if (typeof isNotEmpty === "function" && isNotEmpty(escapeHtml(w.source))) {
            html += '<span class="chip">' + escapeHtml(w.source) + '</span>';
          } else if (escapeHtml(w.source)) {
            html += '<span class="chip">' + escapeHtml(w.source) + '</span>';
          }

          html += ''
            + '        <span class="chip">Added : ' + escapeHtml(w.registrationDate) + '</span>'
            + '      </div>'
            + '    </div>'
            + '    <div class="word-box" aria-label="문제">'
            + '      <p class="word-eng" data-role="prompt">' + getPromptText(w) + '</p>'
            + '    </div>'
            + '    <div class="answer-area" aria-label="정답 영역">'
            + '      <div class="answer-row">'
            + '        <div class="answer-label">'
            + '          <strong data-role="answerLabel">' + escapeHtml(getAnswerLabel()) + '</strong>'
            + '        </div>'
            + '      </div>'
            + '      <div class="answer hidden" data-role="answer">' + getAnswerText(w) + '</div>'
            + '      <div class="answer-example hidden" data-role="example">' + getExampleText(w) + '</div>'
            + '    </div>'
            + '  </div>'
            + '</div>';
        }
        $track.html(html);
      }

      function updateButtons() {
        var maxIdx = Math.max(0, words.length - 1);

        $("#btnPrev").prop("disabled", !words.length || state.idx <= 0);
        $("#btnNext").prop("disabled", !words.length || state.idx >= maxIdx);
        $btnToggleAnswer.prop("disabled", !words.length);
        $btnSwap.prop("disabled", !words.length);
        $btnShuffle.prop("disabled", !words.length); // NEW

        $statText.text(words.length ? ((state.idx + 1) + " / " + words.length) : "0 / 0");
        $btnSwap.text(getSwapButtonText());
        $btnToggleAnswer.text(getToggleButtonText());
      }

      function updateView() {
        $track.find('[data-role="answer"]').addClass("hidden");
        $track.find('[data-role="example"]').addClass("hidden");

        if (!words.length) {
          $btnToggleAnswer.text("Show Answer");
          $btnSwap.text(getSwapButtonText());
          return;
        }

        var $currentSlide = $track.find('.slide[data-idx="' + state.idx + '"]');
        if (!$currentSlide.length) return;

        var w = words[state.idx];

        $currentSlide.find('[data-role="prompt"]').html(getPromptText(w));
        $currentSlide.find('[data-role="answerLabel"]').text(getAnswerLabel());
        $currentSlide.find('[data-role="answer"]').html(getAnswerText(w));
        $currentSlide.find('[data-role="example"]').html(getExampleText(w));

        if (state.revealed) {
          $currentSlide.find('[data-role="answer"]').removeClass("hidden");
          $currentSlide.find('[data-role="example"]').removeClass("hidden");
        }

        updateButtons();
      }

      function setIndex(nextIdx, opts) {
        opts = opts || {};
        var maxIdx = Math.max(0, words.length - 1);

        state.idx = clamp(nextIdx, 0, maxIdx);
        if (!opts.keepAnswer) state.revealed = false;

        updateView();
        setTrackX(currentBaseX(), true);
      }

      /* =========================
         Shuffle (only on button click)
      ========================= */
      function shuffleWords(list) {
        var a = (list || []).slice();
        for (var i = a.length - 1; i > 0; i--) {
          var j = Math.floor(Math.random() * (i + 1));
          var tmp = a[i];
          a[i] = a[j];
          a[j] = tmp;
        }
        return a;
      }

      function applyWordsAndRebuild(nextWords) {
        words = nextWords || [];
        state.idx = 0;
        state.revealed = false;

        renderSlides();

        requestAnimationFrame(function () {
          setIndex(0);
          updateView();
          setTrackX(currentBaseX(), true);
        });
      }

      /* =========================
         Swipe / Drag (경계 이동 금지 + 덜 민감)
      ========================= */
      var drag = {
        active: false,
        startX: 0,
        startY: 0,
        baseX: 0,
        lockedDir: 0,
        moved: false
      };

      function getXY(ev) {
        if (ev.originalEvent && ev.originalEvent.touches && ev.originalEvent.touches.length) {
          return { x: ev.originalEvent.touches[0].clientX, y: ev.originalEvent.touches[0].clientY };
        }
        if (ev.originalEvent && ev.originalEvent.changedTouches && ev.originalEvent.changedTouches.length) {
          return { x: ev.originalEvent.changedTouches[0].clientX, y: ev.originalEvent.changedTouches[0].clientY };
        }
        return { x: ev.clientX, y: ev.clientY };
      }

      function thresholdPx() { return Math.max(110, Math.floor(slideWidth() * 0.26)); }
      function deadzonePx() { return 14; }

      function startDrag(ev) {
        if (!words.length) return;
        if ($("#drawer").hasClass("open") || $("#drawer").hasClass("closing")) return;

        var t = ev.target;
        if (t && (t.closest && (t.closest("button") || t.closest("a")))) return;

        var p = getXY(ev);
        drag.active = true;
        drag.startX = p.x;
        drag.startY = p.y;
        drag.baseX = currentBaseX();
        drag.lockedDir = 0;
        drag.moved = false;

        $track.addClass("dragging").removeClass("bouncing");
      }

      function moveDrag(ev) {
        if (!drag.active) return;

        var p = getXY(ev);
        var dx = p.x - drag.startX;
        var dy = p.y - drag.startY;

        if (!drag.moved) {
          var adx = Math.abs(dx), ady = Math.abs(dy);
          if (ady > adx && ady > deadzonePx()) {
            drag.active = false;
            $track.removeClass("dragging");
            setTrackX(currentBaseX(), true);
            return;
          }
        }

        if (!drag.moved && Math.abs(dx) < deadzonePx()) return;
        drag.moved = true;

        if (drag.lockedDir === 0) {
          drag.lockedDir = dx < 0 ? -1 : 1;
        } else {
          if ((drag.lockedDir === -1 && dx > 0) || (drag.lockedDir === 1 && dx < 0)) {
            dx = dx * 0.15;
          }
        }

        if (state.idx === 0 && dx > 0) dx = 0;
        if (state.idx === words.length - 1 && dx < 0) dx = 0;

        setTrackX(drag.baseX + dx, false);
        ev.preventDefault && ev.preventDefault();
      }

      function endDrag(ev) {
        if (!drag.active && !drag.moved) return;

        var p = getXY(ev);
        var dx = p.x - drag.startX;

        if (state.idx === 0 && dx > 0) dx = 0;
        if (state.idx === words.length - 1 && dx < 0) dx = 0;

        $track.removeClass("dragging");

        if (Math.abs(dx) < deadzonePx()) {
          setTrackX(currentBaseX(), true);
          drag.active = false;
          drag.moved = false;
          drag.lockedDir = 0;
          return;
        }

        var absDx = Math.abs(dx);
        var th = thresholdPx();

        if (absDx >= th) {
          if (dx < 0 && state.idx < words.length - 1) setIndex(state.idx + 1);
          else if (dx > 0 && state.idx > 0) setIndex(state.idx - 1);
          else setTrackX(currentBaseX(), true);
        } else {
          $track.addClass("bouncing");
          setTrackX(currentBaseX(), true);
          window.setTimeout(function () { $track.removeClass("bouncing"); }, 150);
        }

        drag.active = false;
        drag.moved = false;
        drag.lockedDir = 0;
      }

      /* =========================
         이벤트 바인딩 (퀴즈 init 시 1회만)
      ========================= */
      function bindQuizEventsOnce() {
        $("#btnPrev").off("click.quiz").on("click.quiz", function () {
          if (state.idx <= 0) return;
          setIndex(state.idx - 1);
        });

        $("#btnNext").off("click.quiz").on("click.quiz", function () {
          if (state.idx >= words.length - 1) return;
          setIndex(state.idx + 1);
        });

        $btnToggleAnswer.off("click.quiz").on("click.quiz", function () {
          if (!words.length) return;
          state.revealed = !state.revealed;
          updateView();
        });

        $btnSwap.off("click.quiz").on("click.quiz", function () {
          if (!words.length) return;
          state.mode = (state.mode === "EN_TO_KR") ? "KR_TO_EN" : "EN_TO_KR";
          state.revealed = false;
          updateView();
        });

        // NEW: Shuffle button
        $btnShuffle.off("click.quiz").on("click.quiz", function () {
          if (!words.length) return;

          // shuffle only when clicked; keep originalWords as source-of-truth in server order
          var shuffled = shuffleWords(originalWords);

          // apply shuffled list to quiz (rebuild slides safely)
          applyWordsAndRebuild(shuffled);
        });

        $frame.off(".quizSwipe");
        $frame.on("pointerdown.quizSwipe", function (ev) {
          if (ev.pointerType === "mouse" && ev.button !== 0) return;
          startDrag(ev);
        });
        $frame.on("pointermove.quizSwipe", function (ev) {
          if (!drag.active && !drag.moved) return;
          moveDrag(ev);
        });
        $frame.on("pointerup.quizSwipe pointercancel.quizSwipe", function (ev) {
          endDrag(ev);
        });

        $(window).off("resize.quiz").on("resize.quiz", function () {
          setIndex(state.idx, { keepAnswer: true });
          updateView();
          setTrackX(currentBaseX(), true);
        });
      }

      /* =========================
         Drawer (기존 유지)
      ========================= */
      var $d = $("#drawer");
      function openDrawer() {
        $d.removeClass("closing").addClass("open").attr("aria-hidden", "false");
        $("body").toggleClass("modal-open", true);
        setTimeout(function () { $("#btnDrawerClose").trigger("focus"); }, 0);
      }
      function finalizeDrawerClose() {
        $d.removeClass("closing").attr("aria-hidden", "true");
        $("body").toggleClass("modal-open", false);
        setTimeout(function () { $("#btnMenu").trigger("focus"); }, 0);
      }
      function closeDrawer() {
        if (!$d.hasClass("open")) return;
        $d.removeClass("open").addClass("closing").attr("aria-hidden", "true");
        $("body").toggleClass("modal-open", false);

        var root = document.documentElement;
        var dur1 = parseInt(getComputedStyle(root).getPropertyValue("--drawer-dur")) || 260;
        var dur2 = parseInt(getComputedStyle(root).getPropertyValue("--fade-dur")) || 220;
        var fallbackMs = Math.max(dur1, dur2) + 80;

        window.clearTimeout(closeDrawer._t);
        closeDrawer._t = window.setTimeout(function () {
          if ($("#drawer").hasClass("closing")) finalizeDrawerClose();
        }, fallbackMs);
      }

      $("#drawer").find(".drawer-panel").off("transitionend.drawer").on("transitionend.drawer", function (e) {
        if (e.originalEvent && e.originalEvent.propertyName !== "transform") return;
        if ($("#drawer").hasClass("closing")) finalizeDrawerClose();
      });

      $("#btnMenu").off("click.drawer").on("click.drawer", openDrawer);
      $("#btnDrawerClose").off("click.drawer").on("click.drawer", closeDrawer);
      $("#drawerBackdrop").off("click.drawer").on("click.drawer", function () { /* no-op */ });

      $("#menuGoHome").off("click.drawer").on("click.drawer", function () { closeDrawer(); alert("데모: 실제 환경에서는 홈으로 이동시키면 됩니다."); });
      $("#menuResetQuiz").off("click.drawer").on("click.drawer", function () { closeDrawer(); state.revealed = false; updateView(); });

      /* =========================
         init flow: AJAX -> init quiz
         - 최초 로드: 서버 응답 순서 그대로
      ========================= */
      function initQuizWithWords(list) {
        originalWords = (list || []).slice(); // NEW: preserve server order
        words = originalWords.slice();        // initial display = server order

        state.idx = 0;
        state.revealed = false;

        renderSlides();
        bindQuizEventsOnce();

        requestAnimationFrame(function(){
          setIndex(0);
          updateView();
          setTrackX(currentBaseX(), true);
        });
      }

      fetchWords()
        .then(function (list) {
          // IMPORTANT: no shuffle on initial load
          initQuizWithWords(list);
        })
        .fail(function (msg) {
          alert(msg);
          initQuizWithWords([]);
        });

    });
  </script>
</c:set>

<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
