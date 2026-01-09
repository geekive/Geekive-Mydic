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
										<select id="filter-source">
											<option value="">전체</option>
										</select>
									</label> 
									<label> 
										정렬 
										<select id="sort">
											<option value="recent">최근 추가 순</option>
											<option value="asc">단어 A→Z</option>
											<option value="desc">단어 Z→A</option>
										</select>
									</label>
								</div>
							</div>
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
	<button class="fab" id="btn-floating" type="button" aria-label="단어 추가 열기" title="단어 추가">
		<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
			<path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" />
    	</svg>
	</button>

	<!-- Word detail modal -->
	<div class="modal" id="modal" role="dialog" aria-modal="true" aria-label="단어 상세">
		<div class="modal-card">
			<div class="modal-h">
				<div class="title">
					<strong id="mEnglish">word</strong> <span id="mRegistrationDate">meta</span>
				</div>
			</div>

			<div class="modal-b">
				<div id="detailView" style="display: flex; flex-direction: column; gap: 10px;">
					<div class="kv">
						<div class="k">한글 뜻</div>
						<div class="v" id="mKorean"></div>
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
						<button class="btn" id="btn-open-edit" type="button">수정하기</button>
						<button class="btn" id="btn-delete" type="button">삭제</button>
						<button class="close" id="btn-close-edit" type="button">닫기</button>
					</div>
				</div>

				<div id="detailEdit" style="display: none;">
					<div class="edit-grid">
						<div class="kv edit">
							<div class="k">영어 단어</div>
							<div class="v">
								<input type="text" id="eEnglish" placeholder="예: based on" />
							</div>
						</div>

						<div class="kv edit">
							<div class="k">한글 뜻</div>
							<div class="v">
								<input type="text" id="eKorean"
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
							<button class="btn primary" id="btn-edit" type="button">저장</button>
							<button class="btn" id="btnEditCancel" type="button">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Add word modal (mobile flow) -->
	<div class="modal" id="modal-new-word" role="dialog" aria-modal="true"
		aria-label="신규 단어 등록">
		<div class="modal-card">
			<div class="modal-h">
				<div class="title">
					<strong>단어 등록</strong>
				</div>
			</div>
			<div class="modal-b">
				<div class="form">
					<label>
						영어 단어 
						<input id="english-m" type="text" placeholder="based on" />
					</label> 
					<label> 
						한글 뜻 
						<input id="korean-m" type="text" placeholder="…에 근거하여, …을 바탕으로" />
					</label> 
					<label> 
						예문 
						<textarea id="example-m" placeholder="Based on the data, we should revise the plan."></textarea>
					</label> 
					<label> 
						출처 
						<input id="source-m" type="text" placeholder="뉴스 / 영화 / 회의 / 유튜브 등" />
					</label>
					<div class="actions">
						<button class="btn primary" id="btn-save-new-word-m" type="button">추가</button>
						<button class="close" id="btn-close-new-word-m" type="button">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<script>
	let words = [];
	let state = {
		q				: ""
		, source		: ""
		, sort			: "recent"
		, page			: 1
		, pageSize		: 5
		, advancedOpen	: false
	};

	$(function(){
		/* init list */
		$.ajax({
            type			: 'post'
            , url			: getFullPath('/vocabulary/list')
            , contentType	: 'application/json'
			, success		: function(response){
				if(response.resultCode == 1){
					let vocaList = response.vocaList;
					$.each(vocaList, function(index, item){
						let data = {
							vocabularyUid 		: item.vocabularyUid
							, english 			: item.english
							, korean			: item.korean
							, example			: item.example
							, source			: item.source
							, registrationDate	: item.registrationDate
						}
						words.push(data);
					})
					render();
				}else{
					alert(response.resultMessage);
				}
			}
        });
		
		/* add new word */
	  	$("#btn-save-new-word").on("click", () => {
	  		fnSaveNewWord(true);
	  	});
	  	
	    function fnSaveNewWord(IS_DESKTOP){
	    	let data = {
	    			english 	: $.trim(IS_DESKTOP ? $('#english').val() : $('#english-m').val())
	    			, korean 	: $.trim(IS_DESKTOP ? $('#korean').val() : $('#korean-m').val())
	    			, example	: $.trim(IS_DESKTOP ? $('#example').val() : $('#example-m').val())
	    			, source	: $.trim(IS_DESKTOP ? $('#source').val() : $('#source-m').val())
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
				return String(word.english || '').toLowerCase() === String(data.english).toLowerCase();
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
						fnRefreshSourceOption();
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
		
		/* floating button + add new word in modal */
		$("#btn-floating").on("click", fnOpenNewWordModal);
	  	$("#btn-save-new-word-m").on("click", () => {fnSaveNewWord(false);});
	  	$("#btn-close-new-word-m").on("click", function(){fnCloseNewWordModal();});
		
	    function fnOpenNewWordModal(){
	    	fnResetNewWordModal();
	    	$("#modal-new-word").addClass("open");
	    	$('body').toggleClass('modal-open');
	        setTimeout(function(){ $("#english-m").trigger("focus"); }, 0);
		}
	    
		function fnResetNewWordModal(){
			$("#english-m, #korean-m, #example-m, #source-m").val('');
		}
		
	    function fnCloseNewWordModal(){
	        $("#modal-new-word").removeClass("open");
	        $('body').toggleClass('modal-open');
		}
	    
	    /* search + filter */
		$("#q").on("input", fnApplyFilters);
		$("#filter-source").on("change", fnApplyFilters);
		$("#sort").on("change", fnApplyFilters);
		
	    function fnApplyFilters(){
	        state.q 			= $("#q").val();
	        state.source 		= $("#filter-source").val();
	        state.sort 			= $("#sort").val();
	        state.page 			= 1;
	        render();
		}
	    
	    function render(){
	    	let filtered 	= fnFiltering();
	    	let total 		= filtered.length;

	    	let totalPages 	= Math.max(1, Math.ceil(total / state.pageSize));
	        state.page 		= Math.min(state.page, totalPages);

	        let start 		= (state.page - 1) * state.pageSize;
	        let pageItems 	= filtered.slice(start, start + state.pageSize);

	        $("#statText").text(total + " items · page " + state.page + "/" + totalPages);

			if(pageItems.length === 0){
				$("#list").html('<div class="hint">조건에 맞는 결과가 없습니다. 검색어/필터를 조정하세요.</div>');
			}else{
	        	let html = '';
				for(let i = 0; i < pageItems.length; i++){
					let w = pageItems[i];
		            html += ''
						+ '<div class="item" data-id="' + w.vocabularyUid + '" tabindex="0" role="button" aria-label="단어 상세 열기">'
		              	+ 	'<div class="badge">WORD</div>'
		              	+   '<div class="meta">'
		              	+     	'<div class="topline">'
		              	+       	'<div class="word">' + fnEscapeHtml(w.english) + '</div>'
		             	+       	'<div class="meaning">' + fnEscapeHtml(w.korean) + '</div>'
		             	+     	'</div>'
		            	+     	'<div class="example">' + fnEscapeHtml(w.example) + '</div>'
		              	+     	'<div class="source">'
		              	+       	'<span class="chip">' + fnEscapeHtml(w.registrationDate) + '</span>'
		              	+       	'<span class="chip">' + fnEscapeHtml(w.source) + '</span>'
		              	+     	'</div>'
		              	+   '</div>'
		              	+ '</div>';
	          	}
	          $("#list").html(html);
	        }

			$("#pager").html(
				'<button type="button" ' + (state.page <= 1 ? "disabled" : "") + ' data-act="prev">이전</button>'
				+ '<span>' + state.page + " / " + totalPages + '</span>'
				+ '<button type="button" ' + (state.page >= totalPages ? "disabled" : "") + ' data-act="next">다음</button>'
			);
		}
	    
	    function fnFiltering(){
	        let q 	= String(state.q || "").trim();
	        let out = words.slice();

	        // filtered by source
	        if(state.source){
				out = out.filter(function(w){ return w.source === state.source; });
	        }

	        // filtered by search
	        if(q){
				out = out.filter(function(w){
				return includesCI(w.english, q) ||
	                   includesCI(w.korean, q) ||
	                   includesCI(w.example, q) ||
	                   includesCI(w.source, q);
				});
	        }

			// filtered by order
	        if(state.sort === "recent"){
				out.sort(function(a,b){ return b.registrationDate - a.registrationDate; });
	        }else if(state.sort === "asc"){
				out.sort(function(a,b){ return String(a.english).localeCompare(String(b.english)); });
	        }else if(state.sort === "desc"){
				out.sort(function(a,b){ return String(b.english).localeCompare(String(a.english)); });
	        }
	        return out;
	      }
	    
		function includesCI(target, q){
			if(!q) return true;
	        return String(target || "").toLowerCase().indexOf(String(q).toLowerCase()) >= 0;
		}
		
		/* open filter area */
		$("#btnToggleAdvanced").on("click", function(){ fnOpenFilterArea(!state.advancedOpen); });
		
	    function fnOpenFilterArea(open){
  			state.advancedOpen = !!open;
  			$("#advancedWrap").toggleClass("open", state.advancedOpen);
  			$("#btnToggleAdvanced").attr("aria-expanded", String(state.advancedOpen));
  			$("#advancedBtnText").text(state.advancedOpen ? "접기" : "펼치기");
  	    }
	    
		/* filter - source */
		fnRefreshSourceOption();
		function fnRefreshSourceOption(){
			const $filterSource = $('#filter-source');
			const selectedValue = $filterSource.val();
			$.ajax({
	            type			: 'post'
	            , url			: getFullPath('/vocabulary/source')
	            , contentType	: 'application/json'
				, success		: function(response){
					if(response.resultCode == 1){
						let html		= '<option value="">전체</option>';
						let sourceList 	= response.sourceList;
						$.each(sourceList, function(index, item){
							html += '<option value="' + fnEscapeHtml(item.source) + '">' + fnEscapeHtml(item.source) + '</option>';
						})
						$filterSource.html(html);
						
						// select previous option
		                if(selectedValue && $filterSource.find('option[value="' + selectedValue + '"]').length > 0){
		                	$filterSource.val(selectedValue);
		                }
					}else{
						alert(response.resultMessage);
					}
				}
	        });
		}
		
		/* paging */
    	$("#pager").on("click", "button", function(){
  			let act = $(this).data("act");
  	        if(act === "prev" && state.page > 1) state.page--;
  	        if(act === "next") state.page++;
  	        render();
  		});
		
		/* each item + detail modal + edit modal */
		let detailState = {
	    		currentId	: null
	    		, editing	: false
	    };
		
		$("#list").on("click", ".item", function(){ fnOpenDetailModalById($(this).data("id")); });
		
		// find a word data by id
		function fnFindWordById(id){
  			for(let i = 0; i < words.length; i++){
  	    		if(words[i].vocabularyUid == id) return words[i];
  			}
  			return null;
  	    }
		
		// open detail modal
	    function fnOpenDetailModalById(id){
  	    	let w = fnFindWordById(id);
  	      	if(!w) return;

  			detailState.currentId = id;
  	      	fnSetWordDataIntoDetailAndEditModal(w);
  	      	fnSetDetailMode(false);

  	      	$("#modal").addClass("open");
  	      	syncBodyModalState();
  	    }
		
	    function fnSetWordDataIntoDetailAndEditModal(w){
  	      	$("#mEnglish").text(w.english);
  	      	$("#mRegistrationDate").text("추가일 : " + w.registrationDate);
  	      	$("#mKorean").text(w.korean);
  	      	$("#mExample").text(w.example);
  	      	$("#mSource").text(w.source);
  	      
  	      	$("#eEnglish").val(w.english);
  	      	$("#eKorean").val(w.korean);
  	      	$("#eExample").val(w.example);
  	      	$("#eSource").val(w.source);
  	    }

	    /* edit modal */
		$("#btn-open-edit").on("click", function(){
  			let w = detailState.currentId ? fnFindWordById(detailState.currentId) : null;
  	        if(!w) return;
  	        fnSetDetailMode(true);
  		});
		
	    function fnSetDetailMode(editing){
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
	    
	    $("#btn-close-edit").on("click", closeDetailModal);
	    
	    function closeDetailModal(){
  			$("#modal").removeClass("open");
  	      	detailState.currentId = null;
  	      	fnSetDetailMode(false);
  	      	syncBodyModalState();
  	    }
	    
	    $("#btn-edit").on("click", fnEditWord);
	    
	    function fnEditWord(){
  			if(!detailState.currentId) return;
  	      	var w = fnFindWordById(detailState.currentId);
  	      	if(!w) return;

	    	let data = {
	    			vocabularyUid	: detailState.currentId
	    			, english 		: $.trim($('#eEnglish').val())
	    			, korean 		: $.trim($('#eKorean').val())
	    			, example		: $.trim($('#eExample').val())
	    			, source		: $.trim($('#eSource').val())
	    	}
	    	
	    	// validation
	    	if(isEmpty(data.english)){
	    		alert('영어 단어를 입력하세요.'); return
	    	}
	    	if(isEmpty(data.korean)){
	    		alert('한글 뜻을 입력하세요.'); return
	    	}

  	      	let newWordLower = data.english.toLowerCase();
  	      	let oldWordLower = String(w.english || "").toLowerCase();
  	      	let changed = newWordLower !== oldWordLower;

  			if(changed){
  				let exists = words.some(function(x){
  	          		if(x.vocabularyUid === w.vocabularyUid) return false;
  	          			return String(x.english || "").toLowerCase() === newWordLower;
  	        		});
  	        	if(exists){
  	          		let ok = confirm("같은 단어가 이미 존재합니다. 그래도 저장할까요?");
  	          		if(!ok) return;
  	        	}
  	      	}
  			
			// send data 
			$.ajax({
	            type			: 'post'
	            , url			: getFullPath('/vocabulary/edit')
	            , contentType	: 'application/json'
	            , data			: JSON.stringify(data)
				, success		: function(response){
					if(response.resultCode != 1){
						alert(response.resultMessage);
					}else{
			  	     	w.english 	= data.english;
			  	      	w.korean 	= data.korean;
			  	      	w.example 	= data.example;
			  	      	w.source 	= data.source;

			  	      	render();

			  	      	fnSetWordDataIntoDetailAndEditModal(w);
						fnSetDetailMode(false);		
					}
				}
			});
  	    }
	    
	    /* delete word */
		$('#btn-delete').on("click", () => {
			if(confirm('단어를 삭제하시겠습니까?')){
				// send data 
				$.ajax({
		            type			: 'post'
		            , url			: getFullPath('/vocabulary/delete')
		            , contentType	: 'application/json'
		            , data			: JSON.stringify({vocabularyUid : detailState.currentId})
					, success		: function(response){
						if(response.resultCode != 1){
							alert(response.resultMessage);
						}else{
				          	words = words.filter(function(w){
								return w.vocabularyUid !== detailState.currentId;
				            });
				  	      	render();
				  	      	closeDetailModal();
						}
					}
				});
			}
		});
		//---------------------------------------------------


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

	    	    function setAddFormMobile(values){
	    	      $("#mAddWord").val(values && values.word ? values.word : "");
	    	      $("#mAddMeaning").val(values && values.meaning ? values.meaning : "");
	    	      $("#mAddExample").val(values && values.example ? values.example : "");
	    	      $("#mAddSource").val(values && values.source ? values.source : "");
	    	    }



	    	    function isDrawerVisible(){
	    	      return $("#drawer").hasClass("open") || $("#drawer").hasClass("closing");
	    	    }

	    	    function updateFabVisibility(){
	    	      var isMobile = mq.matches;
	    	      var anyOverlayOpen =
	    	        $("#modal").hasClass("open") ||
	    	        $("#modal-new-word").hasClass("open") ||
	    	        isDrawerVisible();

	    	      if(!isMobile){
	    	        $("#btn-floating").prop("hidden", true);
	    	        return;
	    	      }
	    	      $("#btn-floating").prop("hidden", anyOverlayOpen);
	    	    }

	    	    function syncBodyModalState(){
	    	      var anyOpen =
	    	        $("#modal").hasClass("open") ||
	    	        $("#modal-new-word").hasClass("open") ||
	    	        isDrawerVisible();
	    	      $("body").toggleClass("modal-open", anyOpen);
	    	      //updateFabVisibility();
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



	    	    
	    	//----------
	    	
	    	      render();
	    	      syncBodyModalState();

	    	      // background click disabled intentionally
	    	      $("#drawerBackdrop").on("click", function(){ /* no-op */ });


	    	      $("#menuToggleFilters").on("click", function(){ setAdvancedOpen(!state.advancedOpen); });
	    	      $("#menuOpenAdd").on("click", function(){
	    	        setTimeout(function(){
	    	          if(mq.matches) fnOpenNewWordModal();
	    	          else{
	    	            $("#english").trigger("focus");
	    	            $("html, body").animate({ scrollTop: $("#addPanel").offset().top - 16 }, 180);
	    	          }
	    	        }, 0);
	    	      });

	    	     




	    	      $("#btnEditCancel").on("click", function(){
	    	        var w2 = detailState.currentId ? fnFindWordById(detailState.currentId) : null;
	    	        fnSetDetailMode(false);
	    	      });
	    	      

	    	      
	    	      $("#btnClearAdd").on("click", function(){
	    	        setAddFormDesktop({});
	    	        $("#englsih").trigger("focus");
	    	      });


		
	})
 </script>	
</c:set>

<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
