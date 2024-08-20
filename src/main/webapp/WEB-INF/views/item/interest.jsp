<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="interest_content">


	<h1>찜한상품</h1>
	<div class="interest_item_container" style="padding:30px 0">
		<c:forEach var="item" items="${interestitemList}">
			<div class="interest_item">			
				<img src="${path}/resources/img/${item.item_thumbPath}" alt="매물사진" OnClick="location.href ='${path}/item/itemView?item_index=${item.item_index}'" style="cursor:pointer;">
				<div class="interest_item_info" OnClick="location.href ='${path}/item/itemView?item_index=${item.item_index}'" style="cursor:pointer; text-decoration: none; color: black" >
					<h3>${item.item_title}</h3>
					<div class="interest_item_price">
						<h4><fmt:formatNumber value="${item.item_price}" type="number"
												groupingUsed="true" />
											원</h4>
						<p><fmt:formatDate value="${item.item_enrollDate}"
													pattern="yy/MM/dd" /></p>
					</div>
					<div class="interest_item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>${item.item_place}</p>
					</div>
				</div>		
				<div class="app">
					<img src="${path}/resources/img/delete.png" alt="삭제"
						onclick="deleteInterestItem(${item.item_index})">
				</div>

			</div>

		</c:forEach>
		<c:if test="${empty interestitemList}">
			<div style="height:450px; padding-top:100px;">
				<p>찜한 상품이 없습니다.</p>
			</div>
			<!-- 데이터가 없는 경우 -->
		</c:if>
		<!-- 페이징 -->
		<c:if test="${pageInfo.dtoTotal > 1}">
			<div align="center"
				class="pagination container d-flex justify-content-center">
				<a
					href="interest.do?currentPage=1&memberIndex=${loginMember.acc_index}">|&lt;</a>
				&nbsp;
				<a href="interest.do?currentPage=${pageInfo.prevPage}&memberIndex=${loginMember.acc_index}">&lt;</a>
				&nbsp;
				<c:forEach var="currentPage" begin="${pageInfo.fromPage}"
					end="${pageInfo.tillPage}" step="1">
					<a
						href="interest.do?currentPage=${currentPage}&memberIndex=${loginMember.acc_index}" 
						class="${pageInfo.currentPage == currentPage ? 'active' : ''}">${currentPage}</a>
					&nbsp;
				</c:forEach>
				<a
					href="interest.do?currentPage=${pageInfo.nextPage}&memberIndex=${loginMember.acc_index}">&gt;</a>
				&nbsp;
				<a href="interest.do?currentPage=${pageInfo.lastPage}&memberIndex=${loginMember.acc_index}">&gt;|</a>
			</div>
		</c:if>
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
console.log(${item.item_thumbPath});
</script>