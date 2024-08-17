<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
/* 모달 내 Daum Postcode API의 크기 조정 */
#postcode {
	width: 100%;
	height: 400px; /* 높이 조정 */
}
</style>
<section id="content" class="container signup_container"
	style="padding-top: 100px;">
	<c:if test="${loginMember == null}">
		<div class="login_containerIn">
			<form id="loginForm" action="${path}/account/signupOK.do"
				method="post">
				<div class="loginTitle">
					<img class="loginLogo mb-1" alt="로고"
						src="${path}/resources/img/logo.png">
				</div>
				<div class="login_input">
					<div class="login_inputId" id="login_inputId">
						<input type="text" class="form-control login_inputStyle" name="id"
							id="id" placeholder="아이디" autocapitalize="off" required
							onblur="validateInputId()" onkeyup="currIdCheck(this)"> <input
							type="button" class="btn checkBtn" id="checkId" value="중복확인"
							disabled>
					</div>
					<div class="login_inputPw" id="login_inputPw">
						<input type="password" class="form-control login_inputStyle"
							name="password" id="password" placeholder="비밀번호"
							onblur="validateInputPw()" required />
					</div>
					<p id="validateInputId"
						style="color: red; margin: 0; display: none; font-size: 15px;">&nbsp;아이디를
						입력해주세요.</p>
					<p id="validateCheckId"
						style="color: green; margin: 0; display: none; font-size: 15px;">&nbsp;사용
						가능한 ID입니다.</p>
					<p id="validateId"
						style="color: blue; margin: 0; display: none; font-size: 15px;">&nbsp;ID를
						다시 확인 후 중복확인을 눌러주세요.</p>
					<p id="validateInputPassword"
						style="color: red; margin: 0; display: none; font-size: 15px;">&nbsp;비밀번호를
						입력해주세요.</p>
					<div class="mb-1"></div>
					<div class="login_inputName">
						<input type="text" class="form-control login_inputStyle"
							name="name" id="name" placeholder="이름" required
							style="margin-top: 5px;" />
					</div>
					<div class="login_inputBirth">
						<input type="text" class="form-control login_inputStyle"
							name="birthDate" id="birthDate"
							placeholder="생년월일(8자리) ex.20010203" required />
					</div>
					<div class="searchAddrDiv">
						<input type="text" class="form-control login_inputStyle"
							name="address" id="address" placeholder="주소" readonly required />
						<input type="button" class="btn searchAddrBtn"
							onclick="openAddressModal()" value="주소 검색">
					</div>
					<div class="login_inputAddr">
						<input type="text" class="form-control login_inputStyle"
							name="detail_address" id="address" placeholder="상세 주소" required />
					</div>
					<div class="login_inputPhone">
						<input type="text" class="form-control login_inputStyle"
							name="phone" id="phone"
							placeholder="핸드폰번호('-' 없이 11자리) ex.01012345678" required />
					</div>

					<!-- 숨겨진 필드에 좌표 값을 저장 -->
					<input type="hidden" name="addressx" id="addressx"> <input
						type="hidden" name="addressy" id="addressy">
				</div>

				<div class="loginButton mt-2">
					<button type="submit" class="btn login_btnStyle mb-1 mt-1"
						value="회원가입 완료">회원가입</button>
				</div>
			</form>
			<!-- 주소 검색 모달 -->
			<div class="modal fade" id="addressModal" tabindex="-1"
				aria-labelledby="addressModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="addressModalLabel">주소 검색</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div id="postcode"></div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a41a4466a946b1b4af605da49e598032&libraries=services"></script>
		<script>
		var borderId = document.getElementById('login_inputId');
		var borderPw = document.getElementById('login_inputPw');
			function validateInputId() {
				var inputId = document.getElementById('id').value;
				var inputIdMessage = document.getElementById('validateInputId');
				var checkIdMessage = document.getElementById('validateCheckId');

				if (inputId.trim() === "") {
					inputIdMessage.style.display = 'block';
					checkIdMessage.style.display = 'none';
					borderId.classList.add("errorId");
				} else {
					inputIdMessage.style.display = 'none';
					checkIdMessage.style.display = 'none';
					borderId.classList.remove("errorId");
				}
			}

			function validateInputPw() {
				var inputPassword = document.getElementById('password').value;
				var inputPasswordMessage = document
						.getElementById('validateInputPassword');

				if (inputPassword.trim() === "") {
					inputPasswordMessage.style.display = 'block';
					borderPw.classList.add("errorPw");
				} else {
					inputPasswordMessage.style.display = 'none';
					borderPw.classList.remove("errorPw");
				}
			}
			
			function currIdCheck(pId) {
				var currId = pId.value.trim();
				
				if(currId != "") {
					$('#checkId').prop('disabled', false);
				} else {
					$('#checkId').prop('disabled', true);
				}
			}
			
			var status = "0";

			$(document).ready(function() {
				console.log("제이쿼리 시작");
				
				$("#id").on('input', function() {
					if($("#id").val() != '') {
						$("#checkId").prop("disabled", false);
					} else {
						$("#checkId").prop("disabled", true);
					}
				});

				$("#checkId").click(function() {
					console.log("checkId 시작");

					var checkId = {
						"id" : $("#id").val()
					}
					console.log("전송할 id: " + checkId.id);
					
					var validateCheckId = document.getElementById('validateCheckId');
					var validateId = document.getElementById('validateId');

					$.ajax({
						type : "POST",
						url : "duplicateCheckId.do",
						data : checkId,
						success : function(data) {
							status = data;
							if(data === "1") {
								$("#checkId").prop("disabled", true);
<<<<<<< HEAD
								/* alert("사용 가능한 ID입니다."); */
=======
>>>>>>> 58373499cf035314be97fde38fca75c75628b77d
								validateId.style.display = 'none';
								validateCheckId.style.display = 'block';
								borderId.classList.remove("errorId");
							} else {
<<<<<<< HEAD
								/* alert("중복되거나 사용 불가능한 ID입니다. 다시 입력해주세요."); */
=======
>>>>>>> 58373499cf035314be97fde38fca75c75628b77d
								validateCheckId.style.display = 'none';
								validateId.style.display = 'block';
								borderId.classList.add("errorId");
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
			
			function openAddressModal() {
				 var modal = new bootstrap.Modal(document.getElementById('addressModal'));
				    modal.show();
				    
				    modal._element.addEventListener('shown.bs.modal', function () {
				        var geocoder = new daum.maps.services.Geocoder();
				        new daum.Postcode({
				            oncomplete: function(data) {
				                var addr = data.address; // 최종 주소 변수
				                document.getElementById("address").value = addr;
				                
				                // 주소로 상세 정보를 검색
				                geocoder.addressSearch(data.address, function(results, status) {
				                    if (status === daum.maps.services.Status.OK) {
				                        var result = results[0];
				                        var coords = new daum.maps.LatLng(result.y, result.x);
				                        console.log("Latitude: " + coords.getLat() + ", Longitude: " + coords.getLng());
				                        
				                        // 좌표 값을 hidden input 필드에 설정
				                        document.getElementById('addressx').value = coords.getLat();
				                        document.getElementById('addressy').value = coords.getLng();
				                        
				                        modal.hide();
				                    } else {
				                        console.error("Geocoder failed due to: " + status);
				                    }
				                });
				            },
				            width: '100%',
				            height: '100%'
				        }).embed(document.getElementById('postcode'));
				    });
			}

		</script>
	</c:if>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>