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
		<form id="loginForm" action="${path}/account/loginOK.do" method="post">
			<div class="login_containerIn">
				<div class="loginTitle">
					<img class="loginLogo" alt="로고"
						src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<input type="text" class="form-control login_inputStyle mb-1 mt-1"
						name="acc_id" id="acc_id" placeholder="아이디" required="requeired" />
					<input type="password" class="form-control login_inputStyle"
						name="acc_password" id="acc_password" placeholder="비밀번호"
						required="required" />
				</div>
				<div class="loginButton">
					<input type="submit" class="btn login_btnStyle mb-1 mt-2"
						value="로그인" /> <input type="button"
						class="btn login_btnStyle mb-1" value="회원가입"
						onclick="location.href='${path}/account/signup.do';" />
					<div class="find">
						<a href="#" class="findId" onclick="inputPrompt(); return false;">아이디 찾기</a>
						<div class="findBorder"></div>
						<a href="#" class="findPw">비밀번호 찾기</a>
					</div>
				</div>
			</div>
			<%-- <input type="hidden" class="preUrl"
					name="preUrl" id="preUrl" value="${preUrl}"> --%>
		</form>
	</c:if>
</section>

<script>
	function inputPrompt() {
		const name = prompt("이름: ");
		const phone = prompt("핸드폰 번호: ");

		if (name && phone) {
			const req = new XMLHttpRequest();
			req.open("POST", "${path}/account/findId", true);
			req.setRequestHeader("Content-Type",
					"application/json;charset=UTF-8");

			req.onload = function() {
				if (req.status >= 200 && req.status < 300) {
					alert("전송 성공!!");
				} else {
					alert("전송 실패!!");
				}
			};
			
			const data = JSON.stringify({name, phone});
			
			req.send(data);
		} else {
			alert("정보를 입력해주세요.");
		}

	};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>