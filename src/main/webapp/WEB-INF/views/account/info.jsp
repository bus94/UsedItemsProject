<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container">
	<h1>계정 정보 조회 페이지</h1>

	<a href="${path}/account/alter.do">내 정보 수정</a>

	<a href="${path}/complain/complainList.do">사기조회</a>



</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>