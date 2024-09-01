<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="subject_id" value="${loginMember.acc_id}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container complain_page"
	style="padding-top: 100px;">

	<!-- 로그인 했을 때 -->
	<c:if test="${loginMember != null}">
		<div id="complain_detail" class="container d-flex flex-column">
			<div id="title_box"
				class="container d-flex flex-column align-items-center">
				<label id="complain_header" for="redwhistle"></label> <img
					id="redwhistle" src="${path}/resources/img/redwhistle.jpg"
					alt="Red Whishtle">
			</div>
			<hr>

			<form method="post" action="${path}/blacklist/complainPro.do">
				<div id="object_box" class="container">
					<p class="subtitle fs-5">신고할 사람(ID)</p>
					<c:choose>
						<!-- 해당 물품을 통해 신고한 경우 (신고 대상자의 ID를 넘겨준다) -->
						<c:when test="${object_id != null}">
							<input type="text" class="info_box form-control"
								name="object_id_show" id="object_id_show" value="${object_id}"
								disabled />
							<input type="hidden" class="info_box form-control"
								name="object_id" id="object_id" value="${object_id}">
						</c:when>
						<!-- 신고 조회 페이지에서 신고한 경우 (신고 대상자의 ID를 직접 입력해야한다) -->
						<c:otherwise>
							<input type="text"
								class="info_box form-control border border-warning focus-ring focus-ring-danger"
								name="object_id" id="object_id" placeholder="id를 입력하세요."
								required>
						</c:otherwise>
					</c:choose>
				</div>
				<hr>
				<div id="subject_box" class="container">
					<p class="subtitle fs-5">작성자(ID)</p>
					<input type="text" class="info_box form-control"
						name="subject_id_show" id="subject_id_show"
						value="${loginMember.acc_id}" disabled> <input
						type="hidden" class="info_box form-control" name="subject_id"
						id="subject_id" value="${subject_id}">
				</div>
				<hr>
				<div id="content_box" class="container mb-3">
					<p class="subtitle fs-5">내용(150자 이내)</p>
					<div class="form-floating">
						<textarea
							class="form-control border border-warning focus-ring focus-ring-danger"
							id="black_content" name="black_content" style="height: 200px"
							required></textarea>
						<label for="black_content">무분별한 신고는 자제해주세요! 관리자의 권한으로 게시
							글이 삭제될 수 있습니다. </label>
					</div>
				</div>
				<div class="btn_container container">
					<button type="reset" class="btn btn-success btn-sm">취소하기</button>
					<button type="submit" id="" class="btn btn-danger btn-sm">신고하기</button>
					<button type="button" class="btn btn-warning btn-sm"
						onclick="location.href='${path}/blacklist/complainList.do'">신고조회</button>
				</div>
			</form>
		</div>
	</c:if>

	<!-- 로그인 하지 않았을 때 -->
	<c:if test="${loginMember == null}">
		<script>
			alert("로그인 먼저 해주세요.");
			location.href = "${path}/account/login.do";
		</script>
	</c:if>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>