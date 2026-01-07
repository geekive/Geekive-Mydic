<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<c:set var="pageContent">
	<main class="layout">
		<div class="left-col">
			<!-- search section :: s -->
			<section class="card" aria-label="검색/필터">
				<div class="card-h">
					<strong>검색</strong>
				</div>
				<div class="card-b">
					<div class="form">
						<label>
							통합 검색 (단어/뜻/예문/출처) 
							<input id="q" type="text" placeholder="예: based on / 설레다 / TED" />
						</label>

						<div class="advanced-wrap" id="advancedWrap">
							<div class="advanced-head">
								<div class="left">
									<div class="t">상세 필터</div>
								</div>
								<button class="toggle" id="btnToggleAdvanced" type="button" aria-expanded="false" aria-controls="advancedBody">
									<span id="advancedBtnText">펼치기</span>
									<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
                     					<path d="M6 9l6 6 6-6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                   					</svg>
								</button>
							</div>

							<div class="advanced-body" id="advancedBody">
								<div class="row">
									<label>
										출처 필터 
										<select id="sourceFilter">
											<option value="">전체</option>
										</select>
									</label> 
									<label> 
										정렬 
										<select id="sort">
											<option value="recent">최근 추가 순</option>
											<option value="wordAsc">단어 A→Z</option>
											<option value="wordDesc">단어 Z→A</option>
										</select>
									</label>
								</div>
							</div>
						</div>

						<div class="actions">
							<button class="btn primary" id="btnApply" type="button">적용</button>
						</div>
					</div>
				</div>
			</section>
			<!-- search section :: e -->

			<!-- list section :: s -->
			<section class="card" aria-label="단어 리스트">
				<div class="card-h">
					<div class="toolbar">
						<strong>단어 리스트</strong>
						<span class="stat" id="statText">0 items</span>
					</div>
				</div>
				<div class="card-b">
					<div class="list" id="list"></div>
					<div class="pager" id="pager"></div>
				</div>
			</section>
			<!-- list section :: e -->
		</div>

		<!-- add new word :: s -->
		<aside class="card" id="addPanel" aria-label="신규 단어 등록">
			<div class="card-h">
				<strong>단어 등록</strong>
				<button class="btn" id="btnClearAdd" type="button" title="입력값 비우기">비우기</button>
			</div>
			<div class="card-b">
				<div class="form">
					<label> 
						영어 단어 
						<input id="english" type="text" placeholder="based on" />
					</label> 
					<label> 
						한글 뜻 
						<input id="korean" type="text" placeholder="…에 근거하여, …을 바탕으로" />
					</label> 
					<label> 
						예문 
						<textarea id="example" placeholder="Based on the data, we should revise the plan."></textarea>
					</label> 
					<label> 
						출처 
						<input id="source" type="text" placeholder="뉴스 / 영화 / 회의 / 유튜브 등" />
					</label>
					<div class="actions">
						<button class="btn primary" id="btn-save-new-word" type="button" style="width: 100%; margin-top: 5px;">추가</button>
					</div>
				</div>
			</div>
		</aside>
		<!-- add new word :: e -->
	</main>

	<!-- Floating Action Button -->
	<button class="fab" id="fabAdd" type="button" aria-label="단어 추가 열기" title="단어 추가">
		<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
			<path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" />
    	</svg>
	</button>

	<!-- Word detail modal -->
	<div class="modal" id="modal" role="dialog" aria-modal="true" aria-label="단어 상세">
		<div class="modal-card">
			<div class="modal-h">
				<div class="title">
					<strong id="mWord">word</strong> <span id="mMeta">meta</span>
				</div>
				<button class="close" id="mClose" type="button">닫기</button>
			</div>

			<div class="modal-b">
				<div id="detailView" style="display: flex; flex-direction: column; gap: 10px;">
					<div class="kv">
						<div class="k">한글 뜻</div>
						<div class="v" id="mMeaning"></div>
					</div>
					<div class="kv">
						<div class="k">예문</div>
						<div class="v" id="mExample"></div>
					</div>
					<div class="kv">
						<div class="k">출처</div>
						<div class="v" id="mSource"></div>
					</div>

					<div class="modal-actions">
						<button class="btn" id="btnEdit" type="button">수정하기</button>
					</div>
				</div>

				<div id="detailEdit" style="display: none;">
					<div class="edit-grid">
						<div class="kv edit">
							<div class="k">영어 단어</div>
							<div class="v">
								<input type="text" id="eWord" placeholder="예: based on" />
							</div>
						</div>

						<div class="kv edit">
							<div class="k">한글 뜻</div>
							<div class="v">
								<input type="text" id="eMeaning"
									placeholder="예: …에 근거하여, …을 바탕으로" />
							</div>
						</div>

						<div class="kv edit">
							<div class="k">예문</div>
							<div class="v">
								<textarea id="eExample"
									placeholder="예: Based on the data, we should revise the plan."></textarea>
							</div>
						</div>

						<div class="kv edit">
							<div class="k">출처</div>
							<div class="v">
								<input type="text" id="eSource"
									placeholder="예: 뉴스 / 영화 / 회의 / 유튜브 등" />
							</div>
						</div>

						<div class="modal-actions">
							<button class="btn" id="btnEditCancel" type="button">취소</button>
							<button class="btn primary" id="btnEditSave" type="button">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Add word modal (mobile flow) -->
	<div class="modal" id="addModal" role="dialog" aria-modal="true"
		aria-label="신규 단어 등록">
		<div class="modal-card">
			<div class="modal-h">
				<div class="title">
					<strong>단어 등록</strong>
				</div>
				<button class="close" id="addClose" type="button">닫기</button>
			</div>
			<div class="modal-b">
				<div class="form">
					<label>
						영어 단어 
						<input id="mAddWord" type="text" placeholder="based on" />
					</label> 
					<label> 
						한글 뜻 
						<input id="mAddMeaning" type="text" placeholder="…에 근거하여, …을 바탕으로" />
					</label> 
					<label> 
						예문 
						<textarea id="mAddExample" placeholder="Based on the data, we should revise the plan."></textarea>
					</label> 
					<label> 
						출처 
						<input id="mAddSource" type="text" placeholder="뉴스 / 영화 / 회의 / 유튜브 등" />
					</label>
					<div class="actions">
						<button class="btn" id="mAddClear" type="button">비우기</button>
						<button class="btn primary" id="mAddSubmit" type="button">추가</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>

    var words = [
      { vocabularyUid: '111', english: "based on", korean: "…에 근거하여, …을 바탕으로", example: "Based on the data, we should revise the plan.", source: "업무 이메일", registrationDate: Date.now() - 1000 * 60 * 60 * 2 },
      { vocabularyUid: '222', english: "thrilled", korean: "매우 기쁜, 설레는", example: "I was thrilled to hear the news.", source: "Netflix 자막", registrationDate: Date.now() - 1000 * 60 * 60 * 22 },
      { vocabularyUid: '333', english: "counterpart", korean: "상대방(의 대응물), 대응자", example: "Please contact your counterpart on the client side.", source: "회의 메모", registrationDate: Date.now() - 1000 * 60 * 60 * 30 },
      { vocabularyUid: '444', english: "substitute A for B", korean: "B 대신 A를 쓰다/대체하다", example: "You can substitute almond milk for regular milk.", source: "영어 학습 노트", registrationDate: Date.now() - 1000 * 60 * 60 * 60 },
      { vocabularyUid: '555', english: "scope", korean: "범위, (프로젝트) 스코프", example: "We need to clarify the scope before implementation.", source: "기술 문서", registrationDate: Date.now() - 1000 * 60 * 60 * 80 },
      { vocabularyUid: '666', english: "takeaway", korean: "핵심 요점, 얻은 점", example: "My main takeaway is that we should simplify the flow.", source: "TED", registrationDate: Date.now() - 1000 * 60 * 60 * 120 }
    ];

    var state = {
      q: "",
      source: "",
      sort: "recent",
      exampleOnly: "",
      page: 1,
      pageSize: 6,
      advancedOpen: false
    };

    var detailState = {
      currentId: null,
      editing: false
    };

    var MOBILE_BREAKPOINT = 980;
    var mq = window.matchMedia("(max-width: " + MOBILE_BREAKPOINT + "px)");

    function uniq(arr){
      var set = {};
      var out = [];
      for (var i=0;i<arr.length;i++){
        var v = arr[i];
        if(!v) continue;
        if(!set[v]){
          set[v] = true;
          out.push(v);
        }
      }
      return out;
    }

    function formatDate(ts){
      var d = new Date(ts);
      var yyyy = d.getFullYear();
      var mm = String(d.getMonth()+1).padStart(2,"0");
      var dd = String(d.getDate()).padStart(2,"0");
      var hh = String(d.getHours()).padStart(2,"0");
      var mi = String(d.getMinutes()).padStart(2,"0");
      return yyyy + "-" + mm + "-" + dd + " " + hh + ":" + mi;
    }

    function includesCI(hay, needle){
      if(!needle) return true;
      return String(hay || "").toLowerCase().indexOf(String(needle).toLowerCase()) >= 0;
    }

    function escapeHtml(str){
      return String(str)
        .replaceAll("&","&amp;")
        .replaceAll("<","&lt;")
        .replaceAll(">","&gt;")
        .replaceAll('"',"&quot;")
        .replaceAll("'","&#039;");
    }



    function setAddFormMobile(values){
      $("#mAddWord").val(values && values.word ? values.word : "");
      $("#mAddMeaning").val(values && values.meaning ? values.meaning : "");
      $("#mAddExample").val(values && values.example ? values.example : "");
      $("#mAddSource").val(values && values.source ? values.source : "");
    }

    function resetAddModalForm(){
      setAddFormMobile({});
    }

    function findWordById(id){
      for (var i=0;i<words.length;i++){
    	  if(words[i].vocabularyUid == id) return words[i];
      }
      return null;
    }

    function isDrawerVisible(){
      return $("#drawer").hasClass("open") || $("#drawer").hasClass("closing");
    }

    function updateFabVisibility(){
      var isMobile = mq.matches;
      var anyOverlayOpen =
        $("#modal").hasClass("open") ||
        $("#addModal").hasClass("open") ||
        isDrawerVisible();

      if(!isMobile){
        $("#fabAdd").prop("hidden", true);
        return;
      }
      $("#fabAdd").prop("hidden", anyOverlayOpen);
    }

    function syncBodyModalState(){
      var anyOpen =
        $("#modal").hasClass("open") ||
        $("#addModal").hasClass("open") ||
        isDrawerVisible();
      $("body").toggleClass("modal-open", anyOpen);
      //updateFabVisibility();
    }

    function setAdvancedOpen(open){
      state.advancedOpen = !!open;
      $("#advancedWrap").toggleClass("open", state.advancedOpen);
      $("#btnToggleAdvanced").attr("aria-expanded", String(state.advancedOpen));
      $("#advancedBtnText").text(state.advancedOpen ? "접기" : "펼치기");
    }

    /* =========================
       Drawer open/close with close animation
       - close 시 open을 즉시 제거하면 visibility가 숨겨지며 "뚝" 사라지는 문제가 발생
       - open -> closing 전환하여 애니메이션 진행 후, transition 종료 시 완전 hidden 처리
    ========================= */
    function openDrawer(){
      var $d = $("#drawer");
      // 닫히는 중이라도 즉시 다시 열 수 있도록 상태 정리
      $d.removeClass("closing").addClass("open").attr("aria-hidden", "false");
      syncBodyModalState();
      setTimeout(function(){ $("#btnDrawerClose").trigger("focus"); }, 0);
    }

    function finalizeDrawerClose(){
      var $d = $("#drawer");
      $d.removeClass("closing").attr("aria-hidden", "true");
      syncBodyModalState();
      setTimeout(function(){ $("#btnMenu").trigger("focus"); }, 0);
    }

    function closeDrawer(){
      var $d = $("#drawer");
      if(!$d.hasClass("open")) return;

      // 애니메이션을 위해 closing 상태로 전환
      $d.removeClass("open").addClass("closing").attr("aria-hidden", "true");
      syncBodyModalState();

      // transitionend를 놓치거나 브라우저 이슈 대비: fallback 타이머
      var fallbackMs = Math.max(parseInt(getComputedStyle(document.documentElement).getPropertyValue("--drawer-dur")) || 260,
                                parseInt(getComputedStyle(document.documentElement).getPropertyValue("--fade-dur")) || 220) + 80;

      window.clearTimeout(closeDrawer._t);
      closeDrawer._t = window.setTimeout(function(){
        if($("#drawer").hasClass("closing")) finalizeDrawerClose();
      }, fallbackMs);
    }

    function applyResponsive(){
      var isMobile = mq.matches;
      $("#addPanel").css("display", isMobile ? "none" : "");
      syncBodyModalState();

      if(!isMobile && $("#addModal").hasClass("open")){
        closeAddModal();
      }
    }

    function getFiltered(){
      var q = String(state.q || "").trim();
      var exampleOnly = String(state.exampleOnly || "").trim();

      var out = words.slice();

      if(state.source){
        out = out.filter(function(w){ return w.source === state.source; });
      }

      if(q){
        out = out.filter(function(w){
          return includesCI(w.word, q) ||
                 includesCI(w.meaning, q) ||
                 includesCI(w.example, q) ||
                 includesCI(w.source, q);
        });
      }

      if(exampleOnly){
        out = out.filter(function(w){ return includesCI(w.example, exampleOnly); });
      }

      if(state.sort === "recent"){
        out.sort(function(a,b){ return b.createdAt - a.createdAt; });
      }else if(state.sort === "wordAsc"){
        out.sort(function(a,b){ return String(a.word).localeCompare(String(b.word)); });
      }else if(state.sort === "wordDesc"){
        out.sort(function(a,b){ return String(b.word).localeCompare(String(a.word)); });
      }

      return out;
    }



    function render(){
      var filtered = getFiltered();
      var total = filtered.length;

      var totalPages = Math.max(1, Math.ceil(total / state.pageSize));
      state.page = Math.min(state.page, totalPages);

      var start = (state.page - 1) * state.pageSize;
      var pageItems = filtered.slice(start, start + state.pageSize);

      $("#statText").text(total + " items · page " + state.page + "/" + totalPages);

      if(pageItems.length === 0){
        $("#list").html('<div class="hint">조건에 맞는 결과가 없습니다. 검색어/필터를 조정하세요.</div>');
      }else{
        var listHtml = "";
        for (var i=0;i<pageItems.length;i++){
          var w = pageItems[i];
          listHtml += ''
            + '<div class="item" data-id="' + w.vocabularyUid + '" tabindex="0" role="button" aria-label="단어 상세 열기">'
            +   '<div class="badge">WORD</div>'
            +   '<div class="meta">'
            +     '<div class="topline">'
            +       '<div class="word">' + escapeHtml(w.english) + '</div>'
            +       '<div class="meaning">' + escapeHtml(w.korean) + '</div>'
            +     '</div>'
            +     '<div class="example">' + escapeHtml(w.example) + '</div>'
            +     '<div class="source">'
            +       '<span class="chip">' + escapeHtml(w.source) + '</span>'
            +       '<span class="chip">추가: ' + escapeHtml(formatDate(w.registrationDate)) + '</span>'
            +     '</div>'
            +   '</div>'
            + '</div>';
        }
        $("#list").html(listHtml);
      }

      $("#pager").html(
        '<button type="button" ' + (state.page <= 1 ? "disabled" : "") + ' data-act="prev">이전</button>'
        + '<span>' + state.page + " / " + totalPages + '</span>'
        + '<button type="button" ' + (state.page >= totalPages ? "disabled" : "") + ' data-act="next">다음</button>'
      );
    }

    function setDetailMode(editing){
      detailState.editing = !!editing;
      if(detailState.editing){
        $("#detailView").hide();
        $("#detailEdit").show();
        setTimeout(function(){ $("#eWord").trigger("focus"); }, 0);
      }else{
        $("#detailEdit").hide();
        $("#detailView").show();
      }
    }

    function hydrateDetailView(w){
      $("#mWord").text(w.word);
      $("#mMeta").text("추가일: " + formatDate(w.createdAt));
      $("#mMeaning").text(w.meaning);
      $("#mExample").text(w.example);
      $("#mSource").text(w.source);
    }

    function hydrateDetailEdit(w){
      $("#eWord").val(w.word);
      $("#eMeaning").val(w.meaning);
      $("#eExample").val(w.example);
      $("#eSource").val(w.source);
    }

    function openModalById(id){
      console.log(id);
    	var w = findWordById(id);
      console.log(w);
      if(!w) return;

      detailState.currentId = id;
      hydrateDetailView(w);
      hydrateDetailEdit(w);
      setDetailMode(false);

      $("#modal").addClass("open");
      syncBodyModalState();
    }

    function closeDetailModal(){
      $("#modal").removeClass("open");
      detailState.currentId = null;
      setDetailMode(false);
      syncBodyModalState();
    }

    function validateEditPayload(payload){
      var word = $.trim(payload.word || "");
      var meaning = $.trim(payload.meaning || "");
      var example = $.trim(payload.example || "");
      var source = $.trim(payload.source || "");

      var missing = [];
      if(!word) missing.push("영어 단어");
      if(!meaning) missing.push("한글 뜻");
      if(!example) missing.push("예문");
      if(!source) missing.push("출처");

      if(missing.length){
        alert("다음 항목을 입력해 주세요: " + missing.join(", "));
        return null;
      }
      return { word: word, meaning: meaning, example: example, source: source };
    }

    function saveDetailEdits(){
      if(!detailState.currentId) return;
      var w = findWordById(detailState.currentId);
      if(!w) return;

      var v = validateEditPayload({
        word: $("#eWord").val(),
        meaning: $("#eMeaning").val(),
        example: $("#eExample").val(),
        source: $("#eSource").val()
      });
      if(!v) return;

      var newWordLower = v.word.toLowerCase();
      var oldWordLower = String(w.word || "").toLowerCase();
      var changed = newWordLower !== oldWordLower;

      if(changed){
        var exists = words.some(function(x){
          if(x.id === w.id) return false;
          return String(x.word || "").toLowerCase() === newWordLower;
        });
        if(exists){
          var ok = confirm("같은 단어가 이미 존재합니다. 그래도 저장할까요?");
          if(!ok) return;
        }
      }

      w.word = v.word;
      w.meaning = v.meaning;
      w.example = v.example;
      w.source = v.source;

      setSourceOptions();
      render();

      hydrateDetailView(w);
      hydrateDetailEdit(w);

      $("#pillText").text("1 item updated (demo)");
      setDetailMode(false);
    }

    function openAddModal(){
      if($.trim($("#english").val())){
        setAddFormMobile({
          word: $("#english").val(),
          meaning: $("#korean").val(),
          example: $("#example").val(),
          source: $("#source").val()
        });
      }
      $("#addModal").addClass("open");
      syncBodyModalState();
      setTimeout(function(){ $("#mAddWord").trigger("focus"); }, 0);
    }

    function closeAddModal(){
      resetAddModalForm();
      $("#addModal").removeClass("open");
      syncBodyModalState();
    }

    function applyFilters(){
      state.q = $("#q").val();
      state.source = $("#sourceFilter").val();
      state.sort = $("#sort").val();
      state.exampleOnly = $("#exampleOnly").val();
      state.page = 1;
      render();
    }

    function validateWordPayload(payload){
      var word = $.trim(payload.word || "");
      var meaning = $.trim(payload.meaning || "");
      var example = $.trim(payload.example || "");
      var source = $.trim(payload.source || "");

      var missing = [];
      if(!word) missing.push("영어 단어");
      if(!meaning) missing.push("한글 뜻");
      if(!example) missing.push("예문");
      if(!source) missing.push("출처");

      if(missing.length){
        alert("다음 항목을 입력해 주세요: " + missing.join(", "));
        return null;
      }
      return { word: word, meaning: meaning, example: example, source: source };
    }

    function submitAddFromMobile(){
      var ok = addWordToList({
        word: $("#mAddWord").val(),
        meaning: $("#mAddMeaning").val(),
        example: $("#mAddExample").val(),
        source: $("#mAddSource").val()
      });
      if(ok){
        setAddFormMobile({});
        closeAddModal();
      }
    }

    $(function(){
      setSourceOptions();
      render();
      setAdvancedOpen(false);
      applyResponsive();
      syncBodyModalState();

      $("#btnMenu").on("click", openDrawer);
      $("#btnDrawerClose").on("click", closeDrawer);

      // background click disabled intentionally
      $("#drawerBackdrop").on("click", function(){ /* no-op */ });

      // 닫힘 애니메이션 종료 시점에 완전 hidden 처리 (panel transform transition 기준)
      $("#drawer").find(".drawer-panel").on("transitionend", function(e){
        // transform transition이 끝났고, closing 상태라면 finalize
        if(e.originalEvent && e.originalEvent.propertyName !== "transform") return;
        if($("#drawer").hasClass("closing")) finalizeDrawerClose();
      });

      $("#menuFocusSearch").on("click", function(){
        closeDrawer();
        setTimeout(function(){ $("#q").trigger("focus"); }, 0);
      });
      $("#menuToggleFilters").on("click", function(){ setAdvancedOpen(!state.advancedOpen); });
      $("#menuOpenAdd").on("click", function(){
        closeDrawer();
        setTimeout(function(){
          if(mq.matches) openAddModal();
          else{
            $("#english").trigger("focus");
            $("html, body").animate({ scrollTop: $("#addPanel").offset().top - 16 }, 180);
          }
        }, 0);
      });

      $("#btnApply").on("click", applyFilters);
      $("#btnToggleAdvanced").on("click", function(){ setAdvancedOpen(!state.advancedOpen); });

      $("#q, #exampleOnly").on("keydown", function(e){
        if(e.key === "Enter"){ e.preventDefault(); applyFilters(); }
      });

      $("#sourceFilter").on("change", applyFilters);
      $("#sort").on("change", applyFilters);

      $("#list")
        .on("click", ".item", function(){ openModalById($(this).data("id")); })
        .on("keydown", ".item", function(e){
          if(e.key === "Enter" || e.key === " "){
            e.preventDefault();
            openModalById($(this).data("id"));
          }
        });

      $("#pager").on("click", "button", function(){
        var act = $(this).data("act");
        if(act === "prev" && state.page > 1) state.page--;
        if(act === "next") state.page++;
        render();
      });

      $("#mClose").on("click", closeDetailModal);
      $("#modal").on("click", function(e){
        if(e.target === this) closeDetailModal();
      });

      $("#btnEdit").on("click", function(){
        var w = detailState.currentId ? findWordById(detailState.currentId) : null;
        if(!w) return;
        hydrateDetailEdit(w);
        setDetailMode(true);
      });
      $("#btnEditCancel").on("click", function(){
        var w2 = detailState.currentId ? findWordById(detailState.currentId) : null;
        if(w2) hydrateDetailEdit(w2);
        setDetailMode(false);
      });
      $("#btnEditSave").on("click", saveDetailEdits);

      
      $("#btnClearAdd").on("click", function(){
        setAddFormDesktop({});
        $("#englsih").trigger("focus");
      });

      $("#fabAdd").on("click", openAddModal);

      $("#addClose").on("click", function(){ closeAddModal(); });
      $("#addModal").on("click", function(e){
        if(e.target === this){
          // no-op (background click disabled)
        }
      });

      $("#mAddClear").on("click", function(){
        setAddFormMobile({});
        $("#mAddWord").trigger("focus");
      });
      $("#mAddSubmit").on("click", submitAddFromMobile);

      // Responsive
      if(typeof mq.addEventListener === "function"){
        mq.addEventListener("change", applyResponsive);
      }else{
        mq.addListener(applyResponsive);
      }
      $(window).on("resize", applyResponsive);
    });
  </script>
  <script>
  	$("#btn-save-new-word").on("click", () => {
  		fnSaveNewWord(true);
  	});
  	
    function fnSaveNewWord(IS_DESKTOP){
    	let data = {
    			english 	: $('#english').val()
    			, korean 	: $('#korean').val()
    			, example	: $('#example').val()
    			, source	: $('#source').val()
    	}
    	
    	// validation
    	if(isEmpty(data.english)){
    		alert('영어 단어를 입력하세요.'); return
    	}
    	if(isEmpty(data.korean)){
    		alert('한글 뜻을 입력하세요.'); return
    	}
    	
    	// existence check
        let flagExistence = words.some(function(word){
			return String(word.word || '').toLowerCase() === String(data.english).toLowerCase();
		});
		if(flagExistence){
			let ok = confirm('같은 단어가 이미 존재합니다. 그래도 추가할까요?');
			if(!ok) return false;
		}
		
		// send data 
		$.ajax({
            type			: 'post'
            , url			: getFullPath('/vocabulary/save')
            , contentType	: 'application/json'
            , data			: JSON.stringify(data)
			, success		: function(response){
				if(response.resultCode == 1){
					words.unshift({
						vocabularyUid		: response.vocabularyUid
						, english			: response.english
						, korean			: response.korean
						, example			: response.example
						, source			: response.source
						, registrationDate	: Date.now()
			        });
					render();
					setSourceOptions();
					fnResetNewWordForm();
				}else{
					alert(response.resultMessage);
				}
			}
        });
      }
    
	function fnResetNewWordForm(){
		$("#english, #korean, #example, #source").val('');
	}
	
    function setSourceOptions(){
        var sources = uniq(words.map(function(w){ return w.source; })).sort(function(a,b){ return String(a).localeCompare(String(b)); });
        var current = state.source;

        var html = '<option value="">전체</option>';
        for (var i=0;i<sources.length;i++){
          var s = sources[i];
          html += '<option value="' + escapeHtml(s) + '">' + escapeHtml(s) + '</option>';
        }
        $("#sourceFilter").html(html);

        if(sources.indexOf(current) >= 0){
          $("#sourceFilter").val(current);
        }else{
          $("#sourceFilter").val("");
        }
      }
  </script>
</c:set>

<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
