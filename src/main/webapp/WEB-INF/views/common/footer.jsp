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
	<button onclick="location.href ='${path}/map/maptest1'">map</button>
</footer>

</div> <!-- 전체 페이지 wrapper -->


<!-- 부트스트랩 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
	
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/ae370a3256.js"
		crossorigin="anonymous"></script>

</body>
</html>