<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<c:set var="pageContent">
	<main class="layout">
		<div class="left-col">
			<!-- search section :: s -->
			<section class="card" aria-label="Search / Filter">
				<div class="card-h">
					<strong>Search</strong>
				</div>
				<div class="card-b">
					<div class="form">
						<label>
							Unified Search (Word / Meaning / Example / Source)
							<input id="q" type="text" placeholder="e.g. based on / excited / TED" />
						</label>
			
						<div class="advanced-wrap" id="advancedWrap">
							<div class="advanced-head">
								<div class="left">
									<div class="t">Advanced Filters</div>
								</div>
								<button
									class="toggle"
									id="btnToggleAdvanced"
									type="button"
									aria-expanded="false"
									aria-controls="advancedBody"
								>
									<span id="advancedBtnText">Show</span>
									<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
										<path
											d="M6 9l6 6 6-6"
											stroke="currentColor"
											stroke-width="2"
											stroke-linecap="round"
											stroke-linejoin="round"
										/>
									</svg>
								</button>
							</div>
			
							<div class="advanced-body" id="advancedBody">
								<div class="row">
									<label>
										Source Filter
										<select id="filter-source">
											<option value="">All</option>
										</select>
									</label>
									<label>
										Sort
										<select id="sort">
											<option value="recent">Most Recent</option>
											<option value="asc">Word A → Z</option>
											<option value="desc">Word Z → A</option>
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
			<section class="card" aria-label="Word List">
				<div class="card-h">
					<div class="toolbar">
						<strong>Word List</strong>
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
		<aside class="card" id="addPanel" aria-label="Add New Word">
			<div class="card-h">
				<strong>Add New Word</strong>
			</div>
			<div class="card-b">
				<div class="form">
					<label>
						English Word
						<input id="english" type="text" placeholder="based on" />
					</label>
					<label>
						Meaning (Korean)
						<input id="korean" type="text" placeholder="based on; grounded in; derived from" />
					</label>
					<label>
						Example Sentence
						<textarea id="example" placeholder="Based on the data, we should revise the plan."></textarea>
					</label>
					<label>
						Source
						<input id="source" type="text" placeholder="News / Movie / Meeting / YouTube, etc." />
					</label>
					<div class="actions">
						<button
							class="btn primary"
							id="btn-save-new-word"
							type="button"
							style="width: 100%; margin-top: 5px;"
						>
							Add
						</button>
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
	<div class="modal" id="modal" role="dialog" aria-modal="true" aria-label="Word Details">
		<div class="modal-card">
			<div class="modal-h">
				<div class="title">
					<strong id="mEnglish">word</strong>
					<span id="mRegistrationDate">meta</span>
				</div>
			</div>
	
			<div class="modal-b">
				<div id="detailView" style="display: flex; flex-direction: column; gap: 10px;">
					<div class="kv">
						<div class="k">Meaning (Korean)</div>
						<div class="v" id="mKorean"></div>
					</div>
					<div class="kv">
						<div class="k">Example Sentence</div>
						<div class="v" id="mExample"></div>
					</div>
					<div class="kv">
						<div class="k">Source</div>
						<div class="v" id="mSource"></div>
					</div>
	
					<div class="modal-actions">
						<button class="btn" id="btn-open-edit" type="button">Edit</button>
						<button class="btn" id="btn-delete" type="button">Delete</button>
						<button class="close" id="btn-close-edit" type="button">Close</button>
					</div>
				</div>
	
				<div id="detailEdit" style="display: none;">
					<div class="edit-grid">
						<div class="kv edit">
							<div class="k">English Word</div>
							<div class="v">
								<input type="text" id="eEnglish" placeholder="e.g. based on" />
							</div>
						</div>
	
						<div class="kv edit">
							<div class="k">Meaning (Korean)</div>
							<div class="v">
								<input
									type="text"
									id="eKorean"
									placeholder="e.g. based on; grounded in; derived from"
								/>
							</div>
						</div>
	
						<div class="kv edit">
							<div class="k">Example Sentence</div>
							<div class="v">
								<textarea
									id="eExample"
									placeholder="e.g. Based on the data, we should revise the plan."
								></textarea>
							</div>
						</div>
	
						<div class="kv edit">
							<div class="k">Source</div>
							<div class="v">
								<input
									type="text"
									id="eSource"
									placeholder="e.g. News / Movie / Meeting / YouTube"
								/>
							</div>
						</div>
	
						<div class="modal-actions">
							<button class="btn primary" id="btn-edit" type="button">Save</button>
							<button class="btn" id="btnEditCancel" type="button">Cancel</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Add word modal (mobile flow) -->
	<div
		class="modal"
		id="modal-new-word"
		role="dialog"
		aria-modal="true"
		aria-label="Add New Word"
	>
		<div class="modal-card">
			<div class="modal-h">
				<div class="title">
					<strong>Add New Word</strong>
				</div>
			</div>
			<div class="modal-b">
				<div class="form">
					<label>
						English Word
						<input id="english-m" type="text" placeholder="based on" />
					</label>
					<label>
						Meaning (Korean)
						<input
							id="korean-m"
							type="text"
							placeholder="based on; grounded in; derived from"
						/>
					</label>
					<label>
						Example Sentence
						<textarea
							id="example-m"
							placeholder="Based on the data, we should revise the plan."
						></textarea>
					</label>
					<label>
						Source
						<input
							id="source-m"
							type="text"
							placeholder="News / Movie / Meeting / YouTube"
						/>
					</label>
					<div class="actions">
						<button
							class="btn primary"
							id="btn-save-new-word-m"
							type="button"
						>
							Add
						</button>
						<button
							class="close"
							id="btn-close-new-word-m"
							type="button"
						>
							Close
						</button>
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
	    	if (isEmpty(data.english)) {
	    	    alert('Please enter an English word.');
	    	    return;
	    	}

	    	if (isEmpty(data.korean)) {
	    	    alert('Please enter the meaning in Korean.');
	    	    return;
	    	}
	    	
	    	// existence check
	        let flagExistence = words.some(function(word){
				return String(word.english || '').toLowerCase() === String(data.english).toLowerCase();
			});
	        if (flagExistence) {
	            let ok = confirm('This word already exists. Do you want to add it anyway?');
	            if (!ok) return false;
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
							, registrationDate	: formatDateFromNow()
				        });
						render();
						fnRefreshSourceOption();
						fnResetNewWordForm();
						
						if(!IS_DESKTOP){
							fnCloseNewWordModal()
						}
					}else{
						alert(response.resultMessage);
					}
				}
			});
		}
	    
	    function formatDateFromNow() {
	    	  var d = new Date(Date.now());

	    	  var yyyy = d.getFullYear();
	    	  var mm = ('0' + (d.getMonth() + 1)).slice(-2);
	    	  var dd = ('0' + d.getDate()).slice(-2);

	    	  return yyyy + '. ' + mm + '. ' + dd;
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
				$("#list").html(
					    '<div class="hint">No results match your criteria. Please adjust your search or filters.</div>'
					);
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
		              	+       	'<span class="chip">' + fnEscapeHtml(w.registrationDate) + '</span>';
	              	if(isNotEmpty(fnEscapeHtml(w.source))){
	              		html += '<span class="chip">' + fnEscapeHtml(w.source) + '</span>';
	              	}
	              	html += ''
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
  			$("#advancedBtnText").text(state.advancedOpen ? "Hide" : "Show");
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
						let html		= '<option value="">All</option>';
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
	  		$("#mRegistrationDate").text("Added on: " + w.registrationDate);
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
	    	$('body').toggleClass('modal-open');
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
			if (isEmpty(data.english)) {
			    alert('Please enter an English word.');
			    return;
			}
			
			if (isEmpty(data.korean)) {
			    alert('Please enter the meaning in Korean.');
			    return;
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
  	        		let ok = confirm('This word already exists. Do you want to save it anyway?');
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
			if(confirm('Are you sure you want to delete this word?')){
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
	})
 </script>	
</c:set>

<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
