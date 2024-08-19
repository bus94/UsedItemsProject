<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="content" class="container acc_alt_page"
	style="padding-top: 100px;">

	<c:if test="${loginMember != null}">

	<c:choose>
		<c:when test="${loginMember.acc_profile == null}">
			<!-- DB에 프로필이미지가 null인 경우 기본이미지 -->
			<c:set var="profile_path" value="${path}/resources/img/login.png" />
		</c:when>
		<c:otherwise>
			<!-- DB에 프로필이미지가 있는 경우 -->
			<c:set var="profile_path" value="${path}/resources/img/${loginMember.acc_index}/profile/${loginMember.acc_profile}" />
		</c:otherwise>
	</c:choose>


		<div id="acc_detail" class="container d-flex flex-column">

			<form method="post" enctype="multipart/form-data" action="${path}/account/setProfile.do">
				<div id="profile_box" class="container d-flex flex-column align-items-center">
					<label id="acc_id" for="profile">${loginMember.acc_id}</label>
						<img id="profile" src="${profile_path}" alt="프로필이미지">
						
						<div id="file_box" class="container">
							<p class="subtitle fs-5">이&nbsp;&nbsp;&nbsp;미&nbsp;&nbsp;&nbsp;지</p>
							<input type="file" name="profile" class="info_box form-control d-inline" required>
							<button type="submit" id="alt_profile"
								class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
						</div>
				</div>
			</form>	

			<hr>
				<div id="pw_box" class="container">
					<p class="subtitle fs-5">비&nbsp;밀&nbsp;번&nbsp;호</p>
					<button type="button" id="alt_pw" class="btn btn-success btn-sm">변경하기</button>

					<form id="input_pw_box" method="post">
						<div class="container d-flex flex-column">
							<input type="password" class="form-control input_pw mb-2"
								name="currPW" id="currPW" placeholder="현재 비밀번호"
								onkeyup="currPWcheck(this)"> <input type="password"
								class="form-control input_pw mb-2" name="neoPW" id="neoPW"
								placeholder="새 비밀번호" onkeyup="neoPWcheck(this)"> <input
								type="password" class="form-control input_pw mb-2"
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
						name="phone" id="phone" value="${loginMember.acc_phone}">
					<button type="button" id="setPhone" class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
				</div>

			<hr>
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
							<input type="text" class="info_box form-control d-inline"
								name="address" id="address" value="${loginMember.acc_address}">
						</div>
						<div>
							<p class="subtitle fs-5">상&nbsp;세&nbsp;주&nbsp;소</p>
							<input type="text" class="info_box form-control d-inline"
								name="addressDetail" id="addressDetail" value="${loginMember.acc_address}">
						</div>
						<div class="btn_container container">
							<button type="button" id="setRedunds"
								class="btn btn-success btn-sm">수&nbsp;&nbsp;&nbsp;정</button>
							<button type="reset" class="btn btn-success btn-sm">취&nbsp;&nbsp;&nbsp;소</button>
						</div>
					</form>
				</div>
			<hr>
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
		
	</c:if>
	
	<!-- 로그인 안했으면 -->
	<c:if test="${loginMember == null}">
		<script>
			alert("로그인 먼저 해주세요.");
			location.href = "${path}/account/login.do";
		</script>	
	</c:if>
	
</section>

<script src="${path}/resources/js/acc/acc_alter.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>