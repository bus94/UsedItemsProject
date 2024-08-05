<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_content_list" style="padding-top: 100px;">
	<div class="category">
		<div class="category">
		<input type="radio" name="searchType" id="item_category"
			value="item_category"/>
		<label class="radio_type" for="item_category">의류잡화</label>
		<input type="radio" name="searchType" id="item_category" value="item_category"/>
		<label class="radio_type" for="acc_id">전자기기</label>
		<input type="radio" name="searchType" id="content" value="content" />
		<label class="radio_type" for="내용">가구</label>
		<input type="radio" name="searchType" id="content" value="content" />
		<label class="radio_type" for="내용">식품</label>
		<input type="radio" name="searchType" id="content" value="content" />
		<label class="radio_type" for="내용">기타</label>
		<button>상세검색</button>
	</div>
	</div>

	<div class="item_title">
		<h3>검색 결과 &gt;</h3>
	</div>
	<c:if test="${empty itemList}">
		<tr>
			<td colspan="6">조회된 글이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${not empty itemList}">
		<div class="item_wrapper">
			<c:forEach var="item" items="${itemList}">
				<div class="item_container">
					<div class="item">
						<a href="${path}/item/itemView?id=${item.item_index}" style="text-decoration: none; color: black"> <img src="${path}/resources/img/${item.item_image}"
							alt="매물사진">
							<div class="item_view">
								<h3>${item.item_title}</h3>
								<div class="item_price">
									<h4>${item.item_price}원</h4>
									<%-- <h5>${item.item_enrollDate}</h5> --%>
								</div>
								<div class="item_like">
									<p>관심 ${item.item_interest}</p>
									<p>채팅 22</p>
								</div>
								<div class="item_addr">
									<img src="${path}/resources/img/gps.png" alt="위치">
									<p>${item.item_place}</p>
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>

	<!-- 페이징 -->
	<div align="center"
		class="pagination container d-flex justify-content-center">
		<a href="itemList.do?currentPage=1&searchValue=${searchValue}">|&lt;</a>
		&nbsp; 
		<a href="itemList.do?currentPage=${pageInfo.prevPage}&searchValue=${searchValue}">&lt;</a>
		&nbsp;
		<c:forEach var="currentPage" begin="${pageInfo.fromPage}" end="${pageInfo.tillPage}" step="1">
			<a href="itemList.do?currentPage=${currentPage}&searchValue=${searchValue}"
			${pageInfo.currentPage == currentPage ? "style='font-weight:bold;'":""}>${currentPage}</a>
		&nbsp;
		</c:forEach>

		<a href="itemList.do?currentPage=${pageInfo.nextPage}&searchValue=${searchValue}">&gt;</a>
		&nbsp;
		<a href="itemList.do?currentPage=${pageInfo.lastPage}&searchValue=${searchValue}">&gt;|</a>
		&nbsp;
		<a href="${path}/item/itemEnroll.do" class="align-self-end"
			target="_blank">매물 등록</a>
	</div>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>