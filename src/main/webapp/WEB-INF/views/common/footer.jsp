<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


<footer>
	<p class="footer_p" align="center">
		&lt;Copyright 2024. <strong>Safe Market</strong>. All rights
		reserved.&gt;
	</p>
</footer>

<button id="top_btn">
	▲ <br> TOP
</button>

<div class="sidebar">
	<div class="remoteControl">
		<ul class="list-group">
			<li class="list-group-item"><a href="${path}/">메인으로</a></li>
			<li class="list-group-item"><a href="${path}/account/my_info.do">마이페이지</a></li>
			<li class="list-group-item"><a href="${path}/item/itemList.do">조회하기</a></li>
			<li class="list-group-item"><a href="${path}/item/itemEnroll.do">등록하기</a></li>
			<li class="list-group-item"><a href="${path}/item/interest.do">찜 목록</a></li>
			<li class="list-group-item"><a href="${path}/chat/chat.do">채팅하기</a></li>
			<li class="list-group-item"><a href="${path}/blacklist/complain.do">신고하기</a></li>
		</ul>
	</div>
</div>

</div>
<script>
	$(document).ready(function() {
		// Top 버튼 클릭시 페이지 상단으로 이동
		$('#top_btn').click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 50);
			return false;
		});

	});
</script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

</body>
</html>