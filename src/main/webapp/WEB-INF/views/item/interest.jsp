<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="interest_content">

	<h1>찜한상품</h1>
	<div class="interest_item_container " style="padding-top:100px">
		<div class="interest_item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="interest_item_info">
				<h3>관심제품명</h3>
				<div class="interest_item_price">
					<p>9,999원</p>
					<p>몇분 전</p>
				</div>
				<div class="interest_item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>수원시 팔달구</p>
				</div>
			</div>
			<div class="partition">
				<div class="vr"></div>
			</div>
			<div class="interest_item_detail">
				<div class="interest_item_detail_info">
					<p>거래형태 ex)택배, 직거래, 스팟(세잎존)직거래</p>
					<p>분류</p>
					<p>흥정여부</p>
				</div>
			</div>
			<div class="app">
				<img src="${path}/resources/img/message.png" alt="삭제">
				<img src="${path}/resources/img/delete.png" alt="삭제">
			</div>
		</div>
		<div class="interest_item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="interest_item_info">
				<h3>관심제품명</h3>
				<div class="interest_item_price">
					<p>9,999원</p>
					<p>몇분 전</p>
				</div>
				<div class="interest_item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>수원시 팔달구</p>
				</div>
			</div>
		</div>
		<div class="interest_item">
			<img src="${path}/resources/img/item1.jpg" alt="1">
			<div class="interest_item_info">
				<h3>관심제품명</h3>
				<div class="interest_item_price">
					<p>9,999원</p>
					<p>몇분 전</p>
				</div>
				<div class="interest_item_addr">
					<img src="${path}/resources/img/gps.png" alt="위치">
					<p>수원시 팔달구</p>
				</div>
			</div>
		</div>
	</div>
</section>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
