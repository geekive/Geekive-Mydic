<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<c:set var="pageContent">
	<!-- center :: s -->
	<main class="home-center" aria-label="Mydic 메인">
		<section class="hero" aria-label="Mydic 소개 및 오늘의 단어">
			<div class="hero-badge">
				<span class="dot" aria-hidden="true"></span> 
				<span>In service</span>
			</div>

			<h2 class="hero-title">Mydic</h2>

			<p class="hero-sub">
				Build your own dictionary, one word at a time.
			</p>

			<div class="divider" aria-hidden="true"></div>

			<div class="today" aria-label="오늘의 영어단어">
				<div class="today-top">
					<div class="today-label">
						<strong>Word of The Day</strong>
					</div>
				</div>

				<div class="today-word" id="todayWord">${wordMap.english}</div>
				<p class="today-meaning" id="todayMeaning">${wordMap.korean}</p>
				<p class="today-example" id="todayExample">${wordMap.example}</p>
			</div>
		</section>
	</main>
	<!-- center :: e -->
</c:set>
<%@ include file="/WEB-INF/jsp/common/layout.jsp"%>
