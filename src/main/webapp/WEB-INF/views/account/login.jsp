<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container login_container" style="padding-top: 100px;">
	<c:if test="${loginMember == null}">
		<form id="loginForm" action="${path}/account/loginOK.do" method="post">
			<div class="login_containerIn">
				<div class="loginTitle">
					<img class="loginLogo" alt="로고" src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<input type="text" class="form-control login_inputStyle mt-1"
						name="acc_id" id="acc_id" placeholder="아이디"
						required="requeired" /> <input type="password"
						class="form-control login_inputStyle" name="acc_password"
						id="acc_password" placeholder="비밀번호" required="required" />
				</div>
				<div class="loginButton">
					<input type="submit" class="btn login_btnStyle mb-1 mt-1"
						value="로그인" />
					<input type="button" class="btn login_btnStyle"
						value="회원가입" onclick="location.href='${path}/account/signup.do';" />
				</div>
			</div>
		</form>
	</c:if>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>