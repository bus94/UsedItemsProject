<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="categoryList" value="${param.categoryList}" />
<%-- <c:set var="categories" value="${['상의', '하의', '신발', '기타의류', '지갑', '피규어', '전자기기', '가구', '식품', '기타']}" /> --%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_content_list" style="padding-top: 100px;">


	<form action="${path}/item/categoryList.do" method="get">
		<div class="category">
			<div>
				<input type="radio" name="searchType" id="searchType" value="nearPlace"/>
				<label class="radio_type" for="내용">가까운 순</label>
				
				<input type="radio" name="searchType" id="searchType" value="popular" />
				<label class="radio_type" for="내용">인기많은 순</label>
				
				<input type="radio" name="searchType" id="searchType" value="bestSeller" />
				<label class="radio_type" for="내용">거래가 많은 판매자순</label>
			</div>
			
			<div>
				<input type="checkbox" name="categoryList" id="categoryList" value="상의" ${categoryList=='상의' ? 'checked':''}/>
				<label class="radio_type" for="item_category">상의</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="하의" ${categoryList=='하의' ? 'checked':''}/>
				<label class="radio_type" for="item_category">하의</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="신발"  ${categoryList=='신발' ? 'checked':''}/>
				<label class="radio_type" for="item_category">신발</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="기타의류" ${categoryList=='기타의류' ? 'checked':''}/>
				<label class="radio_type" for="item_category">기타의류</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="지갑" ${categoryList=='지갑' ? 'checked':''} />
				<label class="radio_type" for="item_category">지갑</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="피규어" ${categoryList=='피규어' ? 'checked':''} />
				<label class="radio_type" for="item_category">피규어</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="전자기기" ${categoryList=='전자기기' ? 'checked':''} />
				<label class="radio_type" for="item_category">전자기기</label>
		
				<input type="checkbox" name="categoryList" id="categoryList" value="가구" ${categoryList=='가구' ? 'checked':''} />
				<label class="radio_type" for="item_category">가구</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="식품" ${categoryList=='식품' ? 'checked':''} />
				<label class="radio_type" for="item_category">식품</label>
				
				<input type="checkbox" name="categoryList" id="categoryList" value="기타"${categoryList=='기타' ? 'checked':''} />
				<label class="radio_type" for="item_category">기타</label>
				<button type="submit" class="sear_category">상세검색</button>
				<button type="reset" class="sear_category">초기화</button>
			</div>			
		</div>
	</form>

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
						<a href="${path}/item/itemView?item_index=${item.item_index}" style="text-decoration: none; color: black"> <img src="${path}/resources/img/${item.item_image}"
							alt="매물사진">
							<div class="item_view">
								<h3>${item.item_title}</h3>
								<div class="item_price">
									<h4>${item.item_price}원</h4><br>
									<h5><fmt:formatDate value="${item.item_enrollDate}" pattern="yy/MM/dd"/></h5>
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