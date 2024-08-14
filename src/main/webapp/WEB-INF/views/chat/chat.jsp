<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container" style="padding-top: 100px;">
	<h1>채팅리스트</h1>
	<a href="javascript:window.history.back();">뒤로가기</a>
	
	
	<a href="${path}/chat/chatRoom.do">채팅방 입장</a>
	
	
	
	
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>