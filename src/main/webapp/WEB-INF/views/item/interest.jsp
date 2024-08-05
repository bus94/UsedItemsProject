<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="interest_content">


	<h1>찜한상품</h1>
	<div class="interest_item_container" style="padding-top: 100px">
		<c:forEach var="item" items="${interestItemList}">
			<div class="interest_item">
				<img src="${path}/resources/img/${item.item_image}" alt="매물사진">
				<div class="interest_item_info">
					<h3>${item.item_title}</h3>
					<div class="interest_item_price">
						<p>${item.item_price}원</p>
						<p>${item.item_enrollDate}</p>
					</div>
					<div class="interest_item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>${item.item_place}</p>
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
					<img src="${path}/resources/img/message.png" alt="삭제"> <img
						src="${path}/resources/img/delete.png" alt="삭제"
						onclick="deleteInterestItem(${item.item_index})">
				</div>
			</div>
		</c:forEach>
		<!-- 페이징 -->
		<div align="center"
			class="pagination container d-flex justify-content-center">
			<a href="interest.do?currentPage=1&memberIndex=${loginMember.acc_index}">|&lt;</a>
			&nbsp; <a
				href="interest.do?currentPage=${pageInfo.prevPage}&memberIndex=${loginMember.acc_index}">&lt;</a>
			&nbsp;
			<c:forEach var="currentPage" begin="${pageInfo.fromPage}"
				end="${pageInfo.tillPage}" step="1">
				<a
					href="interest.do?currentPage=${currentPage}&memberIndex=${loginMember.acc_index}"
					${pageInfo.currentPage == currentPage ? "style='font-weight:bold;'":""}>${currentPage}</a>
		&nbsp;
		</c:forEach>
		</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>
function deleteInterestItem(itemId) {
    if (confirm('정말 이 아이템을 삭제하시겠습니까?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${path}/item/deleteInterest.do';
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'itemId';
        input.value = itemId;
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
}
</script>