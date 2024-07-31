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
		<div class="login_containerIn">
			<form id="loginForm" action="${path}/account/login.do" method="post">
				<div class="loginTitle">
					<img class="loginLogo" alt="로고"
						src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<div class="login_inputId">
						<input type="text" class="form-control login_inputStyle mt-1"
							name="id" id="id" placeholder="아이디" autocapitalize="off" required
							onblur="validateInputId()"> <input type="button"
							class="btn checkBtn" id="checkId" value="중복확인" disabled>
					</div>
					<input type="password" class="form-control login_inputStyle"
						name="password" id="password" placeholder="비밀번호"
						onblur="validateInputPw()" required style="margin-bottom: 5px;" />
					<p id="validateInputId"
						style="color: red; margin: 0; display: none; font-size: 15px;">&nbsp;아이디를
						입력해주세요.</p>
					<p id="validateInputPassword"
						style="color: red; margin: 0; display: none; font-size: 15px;">&nbsp;비밀번호를
						입력해주세요.</p>
					<input type="text" class="form-control login_inputStyle"
						name="name" id="name" placeholder="이름" required
						style="margin-top: 5px;" /><input type="text"
						class="form-control login_inputStyle" name="birthDate"
						id="birthDate" placeholder="생년월일(8자리) ex.20010203" required /> <input
						type="text" class="form-control login_inputStyle" name="address"
						id="address" placeholder="주소" required /><input type="text"
						class="form-control login_inputStyle" name="phone" id="phone"
						placeholder="핸드폰번호('-' 없이 11자리) ex.01012345678" required />
				</div>

				<%-- <div class="mt-2"
				style="display: flex; justify-content: space-around; align-content: center; align-items: center;">
				<form id="uploadFile" method="post"
					enctype="multipart/form-data">
					&nbsp;프로필 사진 첨부:&nbsp;<input style="width: 250px;" type="file" name="file">
					<button type="button" class="btn btn-outline-secondary" onclick="submitUploadForm('${path}/uploadOK.do')">업로드</button>
				</form>
			</div> --%>
				<div class="loginButton mt-2">
					<button type="submit" class="btn login_btnStyle mb-1 mt-1"
						value="회원가입 완료">회원가입</button>
					<button type="button" class="btn login_btnStyle" value="로그인 하러 가기"
						onclick="location.href='${path}/account/login.do';">로그인
						하러 가기</button>
				</div>
			</form>
		</div>
		<script>
			function validateInputId() {
				var inputId = document.getElementById('id').value;
				var inputIdMessage = document.getElementById('validateInputId');

				if (inputId.trim() === "") {
					inputIdMessage.style.display = 'block';
				} else {
					inputIdMessage.style.display = 'none';
				}
			}

			function validateInputPw() {
				var inputPassword = document.getElementById('password').value;
				var inputPasswordMessage = document
						.getElementById('validateInputPassword');

				if (inputPassword.trim() === "") {
					inputPasswordMessage.style.display = 'block'
				} else {
					inputPasswordMessage.style.display = 'none';
				}
			}
			
			var status = "0";

			$(document).ready(function() {
				console.log("제이쿼리 시작");
				
				$("#id").on('input', function() {
					if($("#id").val() != '') {
						$("#checkId").attr("disabled", false);
					}
				});

				$("#checkId").click(function() {
					console.log("checkId 시작");

					var checkId = {
						"id" : $("#id").val()
					}
					console.log("전송할 id: " + checkId.id);

					$.ajax({
						type : "POST",
						url : "duplicateCheckId.do",
						data : checkId,
						success : function(data) {
							status = data;
							if(data === "1") {
								$("#checkId").attr("disabled", true);
								alert("사용 가능한 ID입니다.");
							} else {
								alert("중복되거나 사용 불가능한 ID입니다. 다시 입력해주세요.");
							}
						},
						error : function(e) {
						}
					});
					
				});
				
				$("#loginForm").submit(function(event) {
					event.preventDefault();
					
					if(status === "0") {
						alert("먼저 ID 중복 확인을 해주세요.");
						
						const invalidFields = document.querySelectorAll('input:invalid');
						invalidFields.forEach(field => {
							field.style.border = '2px solid red';
						});
					} else {
						this.submit();
					}
				});
			});
		</script>
		<!-- <script>
	function submitUploadForm(url) {
		${"#uploadFile"}.attr("action", url);
		${"#uploadFile"}.submit();
	}
</script> -->
	</c:if>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>