<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container login_container"
	style="padding-top: 100px;">
	<c:if test="${loginMember == null}">
		<form id="loginForm" action="${path}/login" method="post">
			<div class="login_containerIn">
				<div class="loginTitle">
					<img class="loginLogo" alt="로고"
						src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<input type="text" class="form-control login_inputStyle mt-1"
						name="id" id="id" placeholder="아이디" autocapitalize="off"
						required="requeired" onblur="validateInputId()" /> <input
						type="password" class="form-control login_inputStyle"
						name="password" id="password" placeholder="비밀번호"
						onblur="validateInputPw()" required="required" style="margin-bottom:5px;" />
					<p id="validateInputId" style="color: red; margin: 0; display: none;  font-size:15px;">아이디를
						입력해주세요.</p>
					<p id="validateInputPassword" style="color: red; margin: 0; display: none; font-size:15px;">비밀번호를
						입력해주세요.</p>
					<input type="text" class="form-control login_inputStyle"
						name="name" id="name" placeholder="이름" required="required" style="margin-top:5px;"/><input
						type="text" class="form-control login_inputStyle" name="birthDate"
						id="birthDate" placeholder="생년월일(8자리) ex.20010203"
						required="required" /> <input type="text"
						class="form-control login_inputStyle" name="address" id="address"
						placeholder="주소" required="required" /><input type="text"
						class="form-control login_inputStyle" name="phone" id="phone"
						placeholder="핸드폰번호('-' 없이 11자리) ex.01012345678"
						required="required" /> <input type="text"
						class="form-control login_inputStyle" name="nickname"
						id="nickname" placeholder="닉네임" required="required" /><input
						type="email" class="form-control login_inputStyle" name="email"
						id="email" placeholder="이메일 주소" required="required" />

					<script>
						function validateInputId() {
							var inputId = document.getElementById('id').value;
							var inputIdMessage = document.getElementById('validateInputId');
							
							if(inputId.trim() === "") {
								inputIdMessage.style.display = 'block';
							} else {
								inputIdMessage.style.display = 'none';
							}
						}
						
						function validateInputPw() {
							var inputPassword = document.getElementById('password').value;
							var inputPasswordMessage = document.getElementById('validateInputPassword');
							
							if(inputPassword.trim() === "") {
								inputPasswordMessage.style.display = 'block'
							} else {
								inputPasswordMessage.style.display = 'none';
							}
						}
					</script>

					<div class="mt-2"
						style="display: flex; justify-content: space-around; align-content: center; align-items: center;">
						<form action="uploadOK" method="post"
							enctype="multipart/form-data">
							프로필 사진 첨부: <input style="width: 250px;" type="file" name="file">
						</form>
					</div>
					<div class="loginButton mt-2">
						<button type="button" class="btn login_btnStyle mb-1 mt-1"
							value="회원가입 완료">회원가입</button>
						<button type="button" class="btn login_btnStyle" value="로그인 하러 가기"
							onclick="location.href='${path}/account/login.do';">로그인
							하러 가기</button>
					</div>
				</div>
			</div>
		</form>
	</c:if>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>