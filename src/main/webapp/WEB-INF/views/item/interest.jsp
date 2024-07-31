<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container" style="padding-top: 100px;">

	<h1>찜한상품</h1>
	<div class="interest_item_container">
		<div class="interest_item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="interest_item">
				<h3>관심제품명</h3>
				<div class="interest_item_price">
					<h4>9,999원</h4>
					<h5>몇분 전</h5>
				</div>
			</div>
		</div>
	</div>
</section>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
