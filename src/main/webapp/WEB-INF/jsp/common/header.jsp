<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<!-- header :: s -->
<div class="topbar" role="banner" aria-label="상단 메뉴">
	<div class="topbar-left">
		<button class="icon-btn" id="btnMenu" type="button" aria-label="메뉴 열기" title="메뉴">
			<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
          			<path d="M4 7h16M4 12h16M4 17h16" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" />
          		</svg>
		</button>
		<div class="brand">
			<!-- <h1>내 단어 리스트</h1> -->
		</div>
	</div>
	
	<div>	
		<c:choose>
			<c:when test="${sessionScope.isSignedIn}">
				<div class="pill">
					<span class="dot"></span>
					<span id="pillText">${sessionScope.userMap.name}</span>
				</div>
				<div class="pill" id="btn-signout">
					로그아웃
				</div>
			</c:when>
			<c:otherwise>
				<div class="pill" id="btn-signin-open" role="button" tabindex="0" aria-label="로그인 열기">
					로그인
				</div>
				<div class="pill" id="btn-signup-open" role="button" tabindex="0" aria-label="회원가입 열기">
					회원가입
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<!-- Drawer: smooth animation version -->
<div class="drawer" id="drawer" aria-hidden="true">
	<div class="drawer-backdrop" id="drawerBackdrop"></div>
	<aside class="drawer-panel" role="dialog" aria-label="메뉴">
		<div class="drawer-h">
			<div class="title">
				<strong>Mydic, The best note ever.</strong>
			</div>
			<button class="icon-btn" id="btnDrawerClose" type="button" aria-label="메뉴 닫기" title="닫기">
				<svg viewBox="0 0 24 24" fill="none" aria-hidden="true">
           			<path d="M6 6l12 12M18 6L6 18" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" />
         		</svg>
			</button>
		</div>

		<div class="drawer-b">
			<div class="menu" role="navigation" aria-label="메뉴 항목">
				<c:choose>
					<c:when test="${sessionScope.isSignedIn}">
						<button type="button" onclick="goToPage('/vocabulary')">
							<div class="k">
								<div class="t">My vocabulary list</div>
							</div>
						</button>
		
						<button type="button" id="">
							<div class="k">
								<div class="t">My info (Under construction)</div>
							</div>
						</button>
					</c:when>
					<c:otherwise>
						Please sign in to access the menu.
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</aside>
</div>

<!-- signin modal -->
<div class="modal" id="modal-signin" role="dialog" aria-modal="true" aria-label="로그인">
	<div class="modal-card sign-card">
		<div class="modal-b">
			<form id="loginForm" class="auth-form" autocomplete="on">
				<label> 이메일 <input id="signin-email" type="text" inputmode="email" autocomplete="off"  placeholder="example@domain.com"></label>
				<label> 패스워드 <input id="signin-password" type="password" autocomplete="off" placeholder="********"></label>
				<div class="modal-actions">
					<button class="btn primary" id="btn-signin-save" type="submit">로그인</button>
					<button class="close" id="btn-signin-close" type="button">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Signup modal -->
<div class="modal" id="modal-signup" role="dialog" aria-modal="true" aria-label="로그인">
	<div class="modal-card sign-card">
		<div class="modal-b">
			<label> 이름 <input id="signup-name" type="text" placeholder="Robin" autocomplete="off" oninput="this.value = this.value.trim();" maxlength="10"></label>
			<label> 이메일 
				<div style="display: flex; flex-direction: row; justify-content: space-between;">
					<input id="signup-email" type="text" inputmode="email" autocomplete="off" placeholder="example@domain.com" style="width: 80%;" oninput="this.value = this.value.trim();" maxlength="30">
					<button class="btn primary" id="btn-code" type="button">인증 발송</button>
				</div>
			</label>
			<label> 인증번호
				<div style="display: flex; flex-direction: row; justify-content: space-between;">
					<input id="signup-code" type="text" placeholder="123456" style="width: 80%;" disabled="disabled" maxlength="6" oninput="this.value = this.value.trim();">
					<button class="btn primary" id="btn-code-check" type="button" disabled="disabled">인증 확인</button>
				</div>
			</label>
			<label> 패스워드 <input id="signup-password" type="password" autocomplete="current-password" placeholder="********" disabled="disabled" oninput="this.value = this.value.trim();"></label>
			<label> 패스워드 확인 <input id="signup-password-check" type="password" autocomplete="current-password" placeholder="********" disabled="disabled" oninput="this.value = this.value.trim();"></label>
			
			<div class="modal-actions">
				<button class="btn primary" id="btn-signup-save" type="button" disabled="disabled">회원가입</button>
				<button class="close" id="btn-singup-close" type="button">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
	/* Menu */
	$(function() {
		let $d 	= $('#drawer');
		let $m 	= $('#btnMenu');
		let $dc = $('#btnDrawerClose');

		$m.on('click', fnOpenDrawer);
		$dc.on('click', fnCloseDrawer);

		function fnOpenDrawer() {
			$d.removeClass('closing')
			  .addClass('open')
			  .attr('aria-hidden', 'false');

			$('body').toggleClass('modal-open', true);

			setTimeout(function () {
				$dc.trigger('focus');
			}, 0);
		}

		function fnCloseDrawer() {
			if (!$d.hasClass('open')) {
				return;
			}

			$d.removeClass('open')
			  .addClass('closing')
			  .attr('aria-hidden', 'true');

			$('body').toggleClass('modal-open', false);
		}
	})

	/* Signin */
	$(function() {
		let $modalSignin 	= $("#modal-signin");
		let $btnSigninOpen 	= $("#btn-signin-open");
		let $btnSigninClose	= $("#btn-signin-close");
		let $btnSigninSave	= $("#btn-signin-save");
		
		let $signinEmail	= $("#signin-email");
		let $signinPassword	= $("#signin-password");
		
		$btnSigninOpen.on('click', fnOpenSigninModal);
		$btnSigninClose.on("click", fnCloseSigninModal);
		$btnSigninSave.on("click", fnSingin);

		function fnOpenSigninModal() {
			$signinEmail.val('');
			$signinPassword.val('');
			
			$modalSignin.addClass("open");
			$("body").addClass("modal-open");
			setTimeout(function(){
				$btnSigninEmail.trigger("focus");
			}, 0);
		}

		function fnCloseSigninModal() {
			$modalSignin.removeClass("open");
			$("body").removeClass("modal-open");
		}
		
		function fnSingin(){
			let email = $signinEmail.val();
			if(isEmpty(email)){
				alert('이메일을 입력하세요.'); return
			}
			if(!isEmailFormat(email)){
				alert('이메일 형식이 아닙니다.'); return
			}
			
			let password = $signinPassword.val();
			if(isEmpty(password)){
				alert('패스워드를 입력하세요.'); return
			}

			let data = {
					email 		: email
					, password 	: password
			}
			
			$.ajax({
	            type			: 'post'
	            , url			: getFullPath('/sign/signin')
	            , contentType	: 'application/json'
	            , data			: JSON.stringify(data)
	            , beforeSend	: function(){
	            	$btnSigninSave.prop('disabled', true);
	            }
				, success		: function(response){
					if(response.resultCode == 1){
						location.reload();
					}else{
						$btnSigninSave.prop('disabled', false);
					}
				}
	        });
		}
	});
	
	/* Signup */
	$(function() {
		let $modalSignup 			= $('#modal-signup');
		let $btnSignupOpen 			= $('#btn-signup-open');
		let $btnSignupClose			= $('#btn-singup-close');
		let $btnCode				= $('#btn-code');
		let $btnCodeCheck			= $('#btn-code-check');
		let $btnSignupSave			= $('#btn-signup-save')
		
		let $singupName				= $('#signup-name');
		let $signupEmail			= $('#signup-email');
		let $signupCode				= $('#signup-code');
		let $signupPassword			= $('#signup-password');
		let $signupPasswordCheck	= $('#signup-password-check');
		
		$btnSignupOpen.on('click', fnOpenSignupModal);
		$btnSignupClose.on('click', fnCloseSignupModal);
		$btnCode.on('click', fnSendCode);
		$btnSignupSave.on('click', fnSignup);
		
		function fnOpenSignupModal() {
			$singupName.val('');
			$signupEmail.val('');
			$signupCode.val('');
			$signupPassword.val('');
			$signupPasswordCheck.val('');
			
			$modalSignup.addClass('open');
			$('body').addClass('modal-open');
			setTimeout(function(){
				$singupName.trigger('focus');
			}, 0);
		}

		function fnCloseSignupModal() {
			$modalSignup.removeClass('open');
			$('body').removeClass('modal-open');
		}
		
		function fnSendCode(){
			let email = $signupEmail.val();
			if(isEmpty(email)){
				alert('이메일을 입력하세요.'); return
			}
			if(!isEmailFormat(email)){
				alert('이메일 형식이 아닙니다.'); return
			}
			
			$.ajax({
	            type			: 'post'
	            , url			: getFullPath('/sign/checkEmailExistence')
	            , contentType	: 'application/json'
	            , data			: JSON.stringify({email : email})
				, success		: function(response){
					if(response.resultCode != 1){
						alert(response.resultMessage);
					}else{
						$.ajax({
				            type			: 'post'
				            , url			: getFullPath('/email')
				            , contentType	: 'application/json'
				            , data			: JSON.stringify({purpose : 'signup', email : email})
				            , beforeSend	: function(){
				            	$signupEmail.prop('disabled', true);
				            	$btnCode.prop('disabled', true);
				            }
							, success		: function(response){
								if(response.resultCode == 1){
									alert(response.resultMessage);
									$signupCode.prop('disabled', false);
									$btnCodeCheck.prop('disabled', false);
									
									$btnCodeCheck.on('click', function(){
										if(response.code == $signupCode.val()){
											$signupCode.prop('disabled', true);
											$btnCodeCheck.prop('disabled', true);
											$signupPassword.prop('disabled', false);	
											$signupPasswordCheck.prop('disabled', false);
											$btnSignupSave.prop('disabled', false);
										}else{
											alert('인증번호가 일치하지 않습니다.');
										}
									})
								}else{
									alert(response.resultMessage);
									$signupEmail.prop('disabled', false);
									$btnCode.prop('disabled', false);
								}
							}
				        });
					}
				}
	        });
		}
		
		function fnSignup(){
			let name = $singupName.val();
			if(isEmpty(name)){
				alert('이름을 입력하세요.'); return
			}
			let flagName = /^.{3,}$/.test(name);
			if(!flagName){
				alert('이름은 최소 3자 이상입니다.'); return
			}
			
			let email = $signupEmail.val();
			if(isEmpty(email)){
				alert('이메일 데이터가 손상됐습니다. 회원가입을 다시 진행하세요.'); return
			}
			
			let password = $signupPassword.val();
			if(isEmpty(password)){
				alert('패스워드를 입력하세요.'); return
			}
			
			let flagPassword = /^.{8,}$/.test(password);
			if(!flagPassword){
				alert('패스워드는 최소 8자 이상입니다.'); return
			}
			if(password != $signupPasswordCheck.val()){
				alert('패스워드 확인이 일치하지 않습니다.'); return
			}
			
			let data = {
					name 		: name
					, email 	: email
					, password 	: password
			}
			
			$.ajax({
	            type			: 'post'
	            , url			: getFullPath('/sign/signup')
	            , contentType	: 'application/json'
	            , data			: JSON.stringify(data)
	            , beforeSend	: function(){
	            	$btnSignupSave.prop('disabled', true);
	            }
				, success		: function(response){
					alert(response.resultMessage);
					if(response.resultCode == 1){
						location.reload();
					}else{
						$btnSignupSave.prop('disabled', false);
					}
				}
	        });
		}
	});
	
	/* Singout */
	$(function(){
		let $btnSingout = $('#btn-signout');
		$btnSingout.on('click', () => {
			goToPage('/sign/signout');
		})
	})
</script>
<!-- header :: e -->