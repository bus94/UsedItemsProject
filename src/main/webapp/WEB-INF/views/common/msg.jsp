<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Message</title>
</head>
<body>
<script type="text/javascript">
	// 알림메시지
	alert("${msg}")
		
	// 페이지 이동
	location.replace("${pageContext.request.contextPath}${location}");
</script>

</body>
</html>