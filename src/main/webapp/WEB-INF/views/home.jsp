<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section class="container">
	<h1>메인 컨테이너</h1>
	<a href="${path}/account/login.do">로그인</a>
	<a href="${path}/account/signup.do">회원가입</a>
	<a href="${path}/item/itemList.do">매물검색</a>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>