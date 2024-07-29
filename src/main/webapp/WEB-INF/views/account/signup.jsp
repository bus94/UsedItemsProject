<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container login_container mt-5">
	<c:if test="${loginMember == null}">
		<form id="loginForm" action="${path}/login" method="post">
			<div class="login_containerIn">
				<div class="loginTitle">
					<img class="loginLogo" alt="로고" src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<input type="text" class="form-control login_inputStyle mt-1"
						name="id" id="id" placeholder="아이디"
						required="requeired" /> 
					<input type="password"
						class="form-control login_inputStyle" name="password"
						id="password" placeholder="비밀번호" required="required" />
					<input type="text"
						class="form-control login_inputStyle" name="birthDate"
						id="birthDate" placeholder="생년월일(8자리) ex.20010203" required="required" />
					<input type="text"
						class="form-control login_inputStyle" name="phone"
						id="phone" placeholder="핸드폰번호('-' 없이 11자리) ex.01012345678" required="required" />
					<input type="email"
						class="form-control login_inputStyle" name="email"
						id="email" placeholder="이메일 주소" required="required" />
					<input type="text"
						class="form-control login_inputStyle" name="name"
						id="name" placeholder="이름" required="required" />
					<input type="text"
						class="form-control login_inputStyle" name="address"
						id="address" placeholder="주소" required="required" />
					<input type="text"
						class="form-control login_inputStyle" name="nickname"
						id="nickname" placeholder="닉네임" required="required" />
					<div style="text-align: center;">
						<button class="profile mt-1" id="profile">프로필
							사진첨부</button>
					</div>
				</div>
				<div class="loginButton">
					<input type="button" class="btn btn-success login_inputStyle mb-1 mt-1"
						value="회원가입 완료" onclick="location.href='${path}/account/login.do';" />
					<input type="button" class="btn btn-success login_inputStyle"
						value="로그인 하러 가기" onclick="location.href='${path}/account/login.do';" />
				</div>
			</div>
		</form>
	</c:if>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>