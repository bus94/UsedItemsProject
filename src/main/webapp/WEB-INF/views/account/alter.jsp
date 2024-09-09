<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- CSS: acc_alter.css -->
<!-- JS: acc_alter.js, 섹션 하단에서 import -->
<section id="content" class="container acc_alt_page" style="padding-top: 100px;">

	<c:choose>
		<c:when test="${loginMember.acc_profile == null}">
			<!-- DB에 프로필이미지가 null인 경우 기본이미지 -->
			<c:set var="profile_path" value="${path}/resources/img/login1.png" />
		</c:when>
		<c:otherwise>
			<!-- DB에 프로필이미지가 있는 경우 -->
			<c:set var="profile_path"
				value="${path}/resources/img/${loginMember.acc_index}/profile/${loginMember.acc_profile}" />
		</c:otherwise>
	</c:choose>

	<!-- 회원정보 수정페이지 컨테이너(회색 테두리) -->
	<div id="acc_detail" class="container d-flex flex-column">
			
		<!-- 아이디 & 프로필 사진 -->
		<div id="profile_box" class="container d-flex flex-column align-items-center">
			<label id="acc_id" for="profile">${loginMember.acc_id}</label> 
			<img id="profile" src="${profile_path}" alt="프로필이미지">

			<!-- display:none -> 프로필사진 클릭 시 보임 -->
			<div id="file_box" class="container">
				<form method="post" enctype="multipart/form-data" action="${path}/account/setProfile.do">
					<p class="subtitle fs-5">이&nbsp;&nbsp;&nbsp;미&nbsp;&nbsp;&nbsp;지</p>
					<input type="file" name="profile"
							class="info_box form-control d-inline" required>
					<button type="submit" id="alt_profile"
							class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
				</form>
			</div>
		</div>

		<hr>
			
		<!-- 비밀번호 변경 박스 -> 변경하기 버튼 클릭 시 보임 -->
		<div id="pw_box" class="container">
			<p class="subtitle fs-5">비&nbsp;밀&nbsp;번&nbsp;호</p>
			<button type="button" id="alt_pw" class="btn btn-success btn-sm">변경하기</button>

			<!-- input check 및 submit은 acc_alter.js에서 -->
			<form id="input_pw_box" method="post">
				<div class="container d-flex flex-column">
					<input type="password" class="form-control input_pw mb-2"
						name="currPW" id="currPW" placeholder="현재 비밀번호"
						onkeyup="currPWcheck(this)"> <input type="password"
						class="form-control input_pw mb-2" name="neoPW" id="neoPW"
						placeholder="새 비밀번호" onkeyup="neoPWcheck(this)"> 
					<input type="password" class="form-control input_pw mb-2"
						name="neoPWconf" id="neoPWconf" placeholder="새 비밀번호 확인"
						onkeyup="neoPW2check(this)">
				</div>
				<div class="btn_container container">
					<button type="button" id="setPW" class="btn btn-success btn-sm"
						disabled>수&nbsp;&nbsp;&nbsp;정</button>
					<button type="reset" id="setPWcancel"
						class="btn btn-success btn-sm ">취&nbsp;&nbsp;&nbsp;소</button>
				</div>
			</form>
		</div>

		<hr>
			
		<!-- 별명, 전화번호 변경 박스: 각각 제약조건 unique -->
		<!-- input check 및 submit은 acc_alter.js에서 -->
		<div id="nickname_box" class="container">
			<p class="subtitle fs-5">별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</p>
			<input type="text" class="info_box form-control d-inline"
				name="nickname" id="nickname" value="${loginMember.acc_nickname}">
			<button type="button" id="setNickname"
				class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
		</div>
		<div id="phone_box" class="container">
			<p class="subtitle fs-5">전&nbsp;화&nbsp;번&nbsp;호</p>
			<input type="text" class="info_box form-control d-inline"
				pattern="[0-9]+" maxlength="11" oninput="this.value = this.value.replace(/[^0-9]/g, '')"
				name="phone" id="phone" value="${loginMember.acc_phone}">
			<button type="button" id="setPhone" class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
		</div>

		<hr>
			
		<!-- 이름, 생년월일, 주소 변경 박스: unique 제약이 없어서(redundant) 묶어서 한번에 변경 -->
		<!-- input check 및 submit은 acc_alter.js에서 -->
		<div id="redundant_box" class="container">
			<form method="post">
				<div>
					<p class="subtitle fs-5">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</p>
					<input type="text" class="info_box form-control d-inline"
						name="name" id="name" value="${loginMember.acc_name}">
				</div>
				<div>
					<p class="subtitle fs-5">생&nbsp;년&nbsp;월&nbsp;일</p>
					<input type="text" class="info_box form-control d-inline"
						name="birthDate" id="birthDate"
						value="<fmt:formatDate value='${loginMember.acc_birthDate}' pattern='yyyy-MM-dd' />">
				</div>
				<div>
					<p class="subtitle fs-5">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</p>
					<input type="hidden" name="addressX" id="addressX"
						value="${loginMember.acc_addressX}"> 
					<input type="hidden"
						name="addressY" id="addressY" value="${loginMember.acc_addressY}">
					<input type="text" class="info_box form-control d-inline"
						name="address" id="address" value="${loginMember.acc_address}"
						readonly />
					<button type="button" id="serchAddress"
						class="btn btn-success btn-sm">주소검색</button>
				</div>
				<div>
					<p class="subtitle fs-5">상&nbsp;세&nbsp;주&nbsp;소</p>
					<input type="text" class="info_box form-control d-inline"
						name="addressDetail" id="addressDetail"
						value="${loginMember.acc_addressDetail}">
				</div>
				<div class="btn_container container">
					<button type="button" id="setRedunds"
						class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
					<button type="reset" class="btn btn-success btn-sm">취&nbsp;&nbsp;&nbsp;소</button>
				</div>
			</form>
		</div>
			
		<hr>
			
		<!-- 회원탈퇴 박스 -> 탈퇴하기 버튼 클릭 시 보임 -->
		<!-- input check 및 submit은 acc_alter.js에서 -->
		<div id="wd_hide2" class="container">
			<p class="subtitle fs-5 ">회&nbsp;원&nbsp;탈&nbsp;퇴</p>
			<button type="button" id="btn_withdraw" class="btn btn-warning btn-sm">탈퇴하기</button>
		</div>

		<form id="wd_hide1" method="post" action="${path}/withdraw.do">
			<div id="withdraw_box" class="container">
				<p class="subtitle fs-5 ">회&nbsp;원&nbsp;탈&nbsp;퇴</p>
				<input type="password" class="info_box form-control d-inline mb-2"
					name="wd_currPW" id="wd_currPW" placeholder="현재 비밀번호" required>
				<button type="submit" id="setStatus" class="btn btn-danger btn-sm">탈&nbsp;&nbsp;&nbsp;퇴</button>
			</div>
		</form>
		
	</div>


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
					<div id="postcode" style="width:100%; height:400px;"></div>
				</div>
			</div>
		</div>
	</div>

</section>

<script src="${path}/resources/js/acc/acc_alter.js"></script>


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
	    const searchButton = document.getElementById('serchAddress');
	    const addressInput = document.getElementById('address');
	    const addressXInput = document.getElementById('addressX');
	    const addressYInput = document.getElementById('addressY');
	    const modalElement = document.getElementById('addressModal');
	    const modal = new bootstrap.Modal(modalElement);
	 
	    searchButton.addEventListener('click', function() {
	        modal.show();
	
	        modalElement.addEventListener('shown.bs.modal', function() {
	            // 이 부분이 postcodeContainer를 모달 내부에 넣는 부분입니다.
	            new daum.Postcode({
	                oncomplete: function(data) {
	                    addressInput.value = data.address;
	
	                    const geocoder = new kakao.maps.services.Geocoder();
	                    geocoder.addressSearch(data.address, function(result, status) {
	                        if (status === kakao.maps.services.Status.OK) {
	                            var result = result[0];
		                        var coords = new daum.maps.LatLng(result.y, result.x);
		                        console.log("LatitudeX: " + coords.getLat() + ", LongitudeY: " + coords.getLng());
		                     
	                        
	                            
	                            addressXInput.value = coords.getLat();
	                            addressYInput.value = coords.getLng();
	                            modal.hide();
	                        }
	                    });
	                },
	                width: '100%',
	                height: '100%'
	            }).embed(document.getElementById('postcode')); // postcodeContainer를 여기에 삽입
	        }, { once: true });
	    });
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>