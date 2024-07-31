<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container" style="padding-top: 100px;">
	<h1>메인 컨테이너</h1>
<<<<<<< HEAD
	<a href="${path}/account/login.do">로그인</a>
	<a href="${path}/account/signup.do">회원가입</a>
	<a href="${path}/item/itemList.do">매물검색</a>
	<a href="${path}/item/itemView.do">매물상세</a>
	<a href="${path}/item/itemEnroll.do">매물등록</a>
	<a href="${path}/account/acc_info.do?acc_id=id_test4">계정 정보 조회 페이지</a>
	<a href="${path}/blacklist/complainList.do">사기 조회 페이지</a>
	<a href="${path}/item/interest.do">찜한 상품</a>
=======
	<a href="${path}/account/login.do">로그인</a> <a
		href="${path}/account/signup.do">회원가입</a> <a
		href="${path}/item/itemList.do">매물검색</a> <a
		href="${path}/item/itemView.do">매물상세</a> <a
		href="${path}/item/itemEnroll.do">매물등록</a> <a
		href="${path}/account/acc_info.do?acc_id=id_test4">계정 정보 조회 페이지</a> <a
		href="${path}/blacklist/complainList.do">사기 조회 페이지</a>

>>>>>>> e5bd4dd247e28abc8519951230377342ee24f7ea
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
