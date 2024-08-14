<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section id="content" class="container chatRoom_page" style="padding-top: 100px;">
	<h1>채팅방</h1>
	<a href="${path}/chat/chat.do">나가기</a>
	
	<div class="chat-container">
    <div class="header">
        세이프챗
    </div>

    <div class="chat-area" id="chatArea">
        
    </div>

    <div class="input-area">
        <input type="text" id="chatInput" placeholder="메시지입력">
        <button id="sendButton">전송</button>
    </div>
</div>
	
	
	
	
</section>

<script>




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>