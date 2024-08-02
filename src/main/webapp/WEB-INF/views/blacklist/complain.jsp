<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container complain_page"
	style="padding-top: 100px;">

	<c:if test="${loginMember != null}">

		<div id="complain_detail" class="container d-flex flex-column">

			<div id="title_box"
				class="container d-flex flex-column align-items-center">
				<label id="complain_header" for="redwhistle"></label> 
				<img id="redwhistle" src="${path}/resources/img/redwhistle.jpg"
					alt="Red Whishtle">
			</div>
		<hr>
		
		<form>
			<div id="object_box" class="container">
				<p class="subtitle fs-5">누구를</p>
				<input type="text" class="info_box form-control" name="black_object"
					id="object_id" placeholder="id를 입력"
				<c:if test="${black_object != null}"> 
					value="${black_object}" disabled
				</c:if>
				/>
			</div>
		<hr>

			<div id="subject_box" class="container">
				<p class="subtitle fs-5">누가</p>
				<input type="text" class="info_box form-control"
					name="black_subject" id="subject_id" value="${loginMember.acc_id}"
					disabled>

			</div>
		<hr>

			<div id="content_box" class="container mb-3">
				<p class="subtitle fs-5">뭘 했길래</p>
				<div class="form-floating">
					<textarea class="form-control" id="floatingTextarea"
						style="height: 200px"></textarea>
					<label for="floatingTextarea">무분별한 신고는 하지 말어~</label>
				</div>
			</div>
			<div class="btn_container container">
				<button type="reset" class="btn btn-success btn-sm">취소하기</button>
				<button type="submit" id="" class="btn btn-success btn-sm">신고하기</button>
				<button type="button" class="btn btn-success btn-sm"
					onclick="location.href='${path}/blacklist/complainList.do'">신고조회</button>
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

<script></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>