<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세잎마켓</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- css, js 포함 -->
<link rel="stylesheet" href="${path}/resources/css/main.css">
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>

</head>
<body>

	<header>
		<div class="login-container">
			<div class="logo">
				<a href="#"><img alt="로고" src="${path}/resources/img/logo.png"></a>
			</div>
			<div class="input-group">
				<input type="text" class="form-control" placeholder="매물을 검색해보세요!"
					aria-label="Recipient's username" aria-describedby="basic-addon2" />
				<a href="#"><img alt="검색" src="${path}/resources/img/search.png"></a>
			</div>
			<div class="login"
				style="width: 200px; justify-content: space-between;">
				<div class="login_btn" style="margin-right: 20px;">
					<img alt="로그인" src="${path}/resources/img/login.png"> <a
						href="${path}/account/login.do">로그인</a>
				</div>
				<div class="login_btn">
					<img alt="회원가입" src="${path}/resources/img/login2.png"> <a
						href="#">회원가입</a>
				</div>
			</div>
		</div>
	</header>