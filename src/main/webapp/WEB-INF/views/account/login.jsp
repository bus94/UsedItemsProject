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
					<div class="input_css input_id">
						<input type="text"
							class="form-control login_inputStyle login_inputStyleId"
							name="acc_id" id="acc_id" placeholder="아이디" required="requeired" />
						<button type="button" class="input_btn" id="clearId"
							style="display: block;">
							<span class="input_btn"><img alt=".."
								src="${path}/resources/img/삭제.png" style="filter: contrast(0%);"><span
								class="blind">삭제</span></span>
						</button>
					</div>
					<div class="input_css input_password">
						<input type="password"
							class="form-control login_inputStyle login_inputStylePw"
							name="acc_password" id="acc_password" placeholder="비밀번호"
							required="required" />
						<button type="button" class="input_btn pwExpr"
							style="display: block;">
							<span class="input_btn"><img alt=".."
								src="${path}/resources/img/비밀번호 숨기기.png" class="pwIcon"><span
								class="blind">비밀번호 표시/숨기기</span></span>
						</button>
						<button type="button" class="input_btn" id="clearPw"
							style="display: block;">
							<span class="input_btn"><img alt=".."
								src="${path}/resources/img/삭제.png" style="filter: contrast(0%);"><span
								class="blind">삭제</span></span>
						</button>
					</div>
				</div>

				<script>
					$(document).ready(function() {
						function showBtn() {
				            var idInput = $('.login_inputStyleId');
				            var clearIdBtn = $('#clearId');
				            var passwordInput = $('.login_inputStylePw');
				            var pwExprBtn = $('.pwExpr');
				            var clearPwBtn = $('#clearPw');

				            if (idInput.val()) {
				            	clearIdBtn.show();
				            } else {
				            	clearIdBtn.hide();
				            }
				            
				            if(passwordInput.val()) {
				            	pwExprBtn.show();
				            	clearPwBtn.show();
				            } else {
				            	pwExprBtn.hide();
				            	clearPwBtn.hide();
				            }
				        }
						
						showBtn();
						$('.login_inputStyleId').on('input', function() {
				        	showBtn();
				        });
						
				        $('.login_inputStylePw').on('input', function() {
				        	showBtn();
				        });
						
						$('.pwExpr').on('click', function() {
							var login_inputStylePw = $('.login_inputStylePw');
							var pwIcon = $(this).find('.pwIcon');
							
							if(login_inputStylePw.attr('type') === 'password') {
								login_inputStylePw.attr('type', 'text');
								pwIcon.attr('src', "${path}/resources/img/비밀번호 표시.png");
								showBtn();
							} else {
								login_inputStylePw.attr('type', 'password');
								pwIcon.attr('src', "${path}/resources/img/비밀번호 숨기기.png");
								showBtn();
							}
						});
						
						$('#clearId').on('click', function() {
							$('.login_inputStyleId').val('');
							showBtn();
						});
						
						$('#clearPw').on('click', function() {
							$('.login_inputStylePw').val('');
							showBtn();
						});
					});
				</script>

				<div class="loginButton">
					<input type="submit" class="btn login_btnStyle mb-1 mt-2"
						value="로그인" /> <input type="button"
						class="btn login_btnStyle mb-1" value="회원가입"
						onclick="location.href='${path}/account/signup.do';" />
					<div class="find mt-1">
						<button type="button" class="findId findBtnW"
							data-bs-toggle="modal" data-bs-target="#exampleModalId"
							data-bs-whatever="@mdo">아이디 찾기</button>
						<div class="modal fade" id="exampleModalId" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="exampleModalLabel">아이디
											찾기</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<form>
											<div class="mb-3">
												<label for="recipient-name" class="col-form-label condition">이름:</label>
												<input type="text" class="form-control" id="findId_name">
											</div>
											<div class="mb-3">
												<label for="message-text" class="col-form-label condition">핸드폰
													번호:</label> <input type="text" class="form-control"
													id="findId_phone">
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-success" id="findIdBtn">확인</button>
										<button type="button" class="btn btn-secondary"
											id="findCancel" data-bs-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
						<div class="findBorder"></div>
						<button type="button" class="findPw findBtnW"
							data-bs-toggle="modal" data-bs-target="#exampleModalPw"
							data-bs-whatever="@mdo">비밀번호 찾기</button>
						<div class="modal fade" id="exampleModalPw" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호
											찾기</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<form>
											<div class="mb-3">
												<label for="recipient-name" class="col-form-label condition">아이디:</label>
												<input type="text" class="form-control" id="findPw_id">
											</div>
											<div class="mb-3">
												<label for="message-text" class="col-form-label condition">이름:</label>
												<input type="text" class="form-control" id="findPw_name">
											</div>
											<div class="mb-3">
												<label for="message-text" class="col-form-label condition">핸드폰
													번호:</label> <input type="text" class="form-control"
													id="findPw_phone">
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-success" id="findPwBtn">확인</button>
										<button type="button" class="btn btn-secondary"
											id="findCancel" data-bs-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</form>
	</c:if>
</section>

<script>
	$(document).ready(function() {
		$('#findIdBtn').click(function() {
			let name = $('#findId_name').val();
			let phone = $('#findId_phone').val();
			console.log("전송 findId_name: " + name);
			console.log("전송 findId_phone: " + phone);

			$.ajax({
				type : "POST",
				url : "findId.do",
				data : JSON.stringify({name, phone}),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					console.log("전송 성공: " + data);
					var checkId = data.checkId;
					var msg = data.msg;
					console.log("checkId: " + checkId);
					console.log("msg: " + msg);
					if(checkId !== null && checkId !== undefined && checkId !== "") {
						alert('아이디 찾기 성공!\n아이디: ' + checkId);
						$('#acc_id').val(checkId);
						$('#findId_name').val('');
						$('#findId_phone').val('');
						$('#exampleModalId').modal('hide');
					} else {
						alert(msg);
					}
				},
				error : function(xhr, status, error) {
				    console.error("전송 실패. 상태: " + status + ", 오류: " + error);
				    console.error("응답 텍스트: " + xhr.responseText);
				}
			});
		});
		
		$('#findPwBtn').click(function() {
			let id = $('#findPw_id').val();
			let name = $('#findPw_name').val();
			let phone = $('#findPw_phone').val();

			$.ajax({
				type : "POST",
				url : "findPw.do",
				data : JSON.stringify({id, name, phone}),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					console.log("전송 성공: " + data);
					var checkPw = data.checkPw;
					var msg = data.msg;
					console.log("checkPw: " + checkPw);
					console.log("msg: " + msg);
					if(checkPw !== null && checkPw !== undefined && checkPw !== "") {
						alert('비밀번호 찾기 성공!\n비밀번호: ' + checkPw);
						$('#findPw_id').val('');
						$('#findPw_name').val('');
						$('#findPw_phone').val('');
						$('#exampleModalPw').modal('hide');
					} else {
						alert(msg);
					}
				},
				error : function(xhr, status, error) {
				    console.error("전송 실패. 상태: " + status + ", 오류: " + error);
				    console.error("응답 텍스트: " + xhr.responseText);
				}
			});
		});
		
		$('#findCancel').click(function() {
			$('#findId_name').val('');
			$('#findId_phone').val('');
			$('#findPw_id').val('');
			$('#findPw_name').val('');
			$('#findPw_phone').val('');
			$('#exampleModalId').modal('hide');
			$('#exampleModalPw').modal('hide');
		});
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>