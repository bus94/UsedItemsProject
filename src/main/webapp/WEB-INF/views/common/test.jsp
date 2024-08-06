<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${path}/resources/css/test.css?v=${systemProperties['timestamp']}">
<script defer src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script defer src="${path}/resources/js/test.js"></script>

</head>
<body>
	<header class="qz_hd">
		<h1>My Website</h1>
		<nav>
			<ul>
				<li><a href="#">Home</a></li>
				<li><a href="#">About</a></li>
				<li><a href="#">Services</a></li>
				<li><a href="#">Contact</a></li>
			</ul>
		</nav>
	</header>
	<main>
		<section style="height: 2000px;">
			<h2>Content Goes Here</h2>
			<p>Scroll down to see the header become fixed.</p>
		</section>
	</main>

</body>
</html>
