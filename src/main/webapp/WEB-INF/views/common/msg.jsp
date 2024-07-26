<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메세지</title>
</head>
<body>
	<script>
		// 알림메시지
		alert("${msg}")
		
		// 페이지 이동
		location.replace("${pageContext.request.contextPath}${location}");
	</script>
</body>
</html>