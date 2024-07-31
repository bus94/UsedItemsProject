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
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<!-- 슬릭 css-->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" />	
<!-- 슬릭js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- css, js 포함 -->
<link rel="stylesheet"
	href="${path}/resources/css/main.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/login/login.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/item/itemList.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/item/itemView.css?v=${systemProperties['timestamp']}">
<<<<<<< HEAD
<link rel="stylesheet"
	href="${path}/resources/css/item/interest.css?v=${systemProperties['timestamp']}">
	
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css?v=${systemProperties['timestamp']}" />
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css?v=${systemProperties['timestamp']}" />
=======
>>>>>>> e5bd4dd247e28abc8519951230377342ee24f7ea
<link rel="stylesheet"
	href="${path}/resources/css/acc/acc_info.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/acc/acc_alter.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/blacklist/list.css?v=${systemProperties['timestamp']}">	
<link rel="stylesheet"
	href="${path}/resources/css/blacklist/complain.css?v=${systemProperties['timestamp']}">	
<script src="${path}/resources/js/item/itemView.js"></script>


</head>
<body>

	<header>
		<div class="login-container">
			<div class="logo">
				<a href="${path}/"><img alt="로고"
					src="${path}/resources/img/logo.png"></a>
			</div>
			<div class="input-group">
				<input type="text" class="form-control" placeholder="매물을 검색해보세요!"
					aria-label="Recipient's username" aria-describedby="basic-addon2" />
				<img alt="검색" src="${path}/resources/img/search.png">
			</div>

			<c:if test="${loginMember == null}">
				<div class="login">
					<div class="login_btn" style="margin-right: 20px;">
						<a class="login_img" href="${path}/account/login.do"><img
							alt="로그인" src="${path}/resources/img/login.png"></a> <a
							class="login_text" href="${path}/account/login.do">로그인</a>
					</div>
					<div class="login_btn">
						<a class="login_img" href="${path}/account/signup.do"><img
							alt="회원가입" src="${path}/resources/img/login2.png"></a> <a
							class="login_text" href="${path}/account/signup.do">회원가입</a>
					</div>
				</div>
			</c:if>

			<c:if test="${loginMember != null}">
				<div class="login_profile">
					<div class="login_profileIn">
						<a class="login_img" href="${path}/account/my_info.do"><img
							alt="${path}/resources/img/login.png"
							src="${path}/resources/img/login.png"></a> <a
							class="login_profile_text" href="${path}/account/my_info.do">${loginMember.acc_nickname}</a>
					</div>
				</div>
			</c:if>
		</div>
	</header>