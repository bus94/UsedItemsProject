<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- CSS: timeline.css -->
<!-- JS: acc_info.js -->
<aside id="timeline">
	
	<div id="offcanvas_timeline" class="offcanvas offcanvas-start" 
			data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" 
			aria-labelledby="offcanvas_timeline_label">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvas_timeline_label">나의 타임라인</h5>
			<button type="button" id="btn_close_timeline" class="btn-close" 
				data-bs-dismiss="offcanvas"	aria-label="Close"></button>
		</div>
		<div id="offcanvas_timeline_body" class="offcanvas-body">
							
			<div class="event_box event_acc">
				<p class="event_message">&middot; Safe Market 회원가입</p>
				<p class="event_time">24/09/20 08:47</p>
			</div>
				
			<div class="event_box event_item">
				<p class="event_message">&middot; 물품 등록</p>
				<p class="event_time">24/09/22 08:47</p>
			</div>
				
			<div class="event_box event_black">
				<p class="event_message">&middot; 신고 등록</p>
				<p class="event_time">24/09/23 08:47</p>
			</div>
			
			<div class="event_box event_repl">
				<p class="event_message">&middot; 댓글 등록</p>
				<p class="event_time">24/09/24 08:47</p>
			</div>
			
			<div class="event_box event_chat">
				<p class="event_message">&middot; 채팅방 생성</p>
				<p class="event_time">24/09/24 08:47</p>
			</div>
			
			<div class="event_box event_item">
				<p class="event_message">&middot; 판매 완료</p>
				<p class="event_time">24/09/25 08:47</p>
			</div>

				
		</div>
	</div>

</aside>
