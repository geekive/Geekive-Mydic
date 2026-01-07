<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<c:set var="pageContent">
	<!-- center :: s -->
	<main class="home-center" aria-label="Mydic 메인">
		<section class="hero" aria-label="Mydic 소개 및 오늘의 단어">
			<div class="hero-badge">
				<span class="dot" aria-hidden="true"></span> 
				<span>Geekive Mydic</span>
			</div>

			<h2 class="hero-title">Mydic</h2>

			<p class="hero-sub">
				단어 · 뜻 · 예문 · 출처를 한 번에 기록하는 가장 간단한 개인 단어장.
				필요한 순간에 바로 꺼내 쓸 수 있도록 “문장” 중심으로 정리합니다.
			</p>

			<div class="divider" aria-hidden="true"></div>

			<div class="today" aria-label="오늘의 영어단어">
				<div class="today-top">
					<div class="today-label">
						<strong>오늘의 단어</strong> <span id="todayDate">2026.01.07</span>
					</div>

					<div class="today-chips">
						<span class="chip" id="chipSource">영어 학습 노트</span> <span
							class="chip" id="chipAdded">추가: 2026-01-04 22:09</span>
					</div>
				</div>

				<div class="today-word" id="todayWord">substitute A for B</div>
				<p class="today-meaning" id="todayMeaning">B 대신 A를 쓰다/대체하다</p>
				<p class="today-example" id="todayExample">You can substitute almond milk for regular milk.</p>
			</div>
		</section>
	</main>
	<!-- center :: e -->
</c:set>
<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
