<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container">
	<c:if test="${loginMember == null}">
		<form id="loginForm" action="${path}/login" method="post">
			<div class="login-container">
				<div class="loginTitle">
					<img alt="로고" src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<input type="text" class="form-control" name="accountId"
						id="accountId" placeholder="아이디" required="requeired" /> <input
						type="password" class="form-control" name="accountPassword"
						id="accountPassword" placeholder="비밀번호" required="required" /> <input
						type="button" class="btn btn-success" value="회원가입"
						onclick="location.href='${path}/account/signup.do';" /> <input
						type="button" class="btn btn-success" value="로그인"
						onclick="location.href='${path}/';" />
				</div>
			</div>
		</form>
	</c:if>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>