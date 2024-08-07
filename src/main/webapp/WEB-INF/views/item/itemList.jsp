<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_content_list" style="padding-top: 100px;">


	<form action="${path}/item/itemList.do" method="post">
		<div class="category">
			<div>
				<input type="radio" name="searchType" id="searchTypeNearPlace"
					value="nearPlace" ${searchType != null && searchType == 'nearPlace' ? 'checked' : ''} />
				<label class="radio_type" for="radio_nearPlace">가까운 순</label> <input
					type="radio" name="searchType" id="searchTypePopular"
					value="popular" ${searchType != null && searchType == 'popular' ? 'checked' : ''} /> <label
					class="radio_type" for="radio_searchType">인기많은 순</label> <input
					type="radio" name="searchType" id="searchTypeBestSeller"
					value="bestSeller" ${searchType != null && searchType == 'bestSeller' ? 'checked' : ''} />
				<label class="radio_type" for="radio_beastSeller">거래가 많은
					판매자순</label>
			</div>

			<div>
				<c:forEach var="value" items="${categoryAllList}">
					<c:set var="isChecked" value="${categoryList != null && fn:contains(categoryList, value)}" />
					<c:forEach var="category" items="${categoryList}">
						<c:if test="${category == value}">
							<c:set var="isChecked" value="true" />
						</c:if>
					</c:forEach>
					<input type="checkbox" name="categoryList"
						id="categoryList_${value}" value="${value}"
						${isChecked ? 'checked':''} />
					<label class="radio_type" for="item_category_${value}">${value}</label>
				</c:forEach>

				<button type="submit" class="sear_category">상세검색</button>
				<button type="reset" class="sear_category">초기화</button>
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
							<a href="${path}/item/itemView?item_index=${item.item_index}"
								style="text-decoration: none; color: black"> <img
								src="${path}/resources/img/${item.item_image}" alt="매물사진">
								<div class="item_view">
									<h3>${item.item_title}</h3>
									<div class="item_price">
										<h4>${item.item_price}원</h4>
										<br>
										<h5>
											<fmt:formatDate value="${item.item_enrollDate}"
												pattern="yy/MM/dd" />
										</h5>
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
	</form>

	<!-- 페이징 -->
	<div align="center"
		class="pagination container d-flex justify-content-center">
		<a
			href="itemList.do?currentPage=1&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}">|&lt;</a>
		&nbsp; <a
			href="itemList.do?currentPage=${pageInfo.prevPage}&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}">&lt;</a>
		&nbsp;
		<c:forEach var="currentPage" begin="${pageInfo.fromPage}"
			end="${pageInfo.tillPage}" step="1">
			<a
				href="itemList.do?currentPage=${currentPage}&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}"
				${pageInfo.currentPage == currentPage} ? "style='font-weight: bold;'":""}>${currentPage}</a>
		&nbsp;
		</c:forEach>

		<a
			href="itemList.do?currentPage=${pageInfo.nextPage}&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}">&gt;</a>
		&nbsp; <a
			href="itemList.do?currentPage=${pageInfo.lastPage}&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}">&gt;|</a>
		&nbsp; <a href="${path}/item/itemEnroll.do" class="align-self-end"
			target="_blank">매물 등록</a>
	</div>


</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>