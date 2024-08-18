<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_content_list" style="padding-top: 100px;">


	<form action="${path}/item/itemList.do" method="post" id="searchForm">
		<div class="category">
			<div class="selectBox">
				<div class="selectBoxIn">
					<!-- <button style="width: 10px;" id="mapButton">지도</button> -->
					<p>정렬:</p>
					<select class="selectBox_value" name="searchType">
						<option value="">===정렬 선택===</option>
						<option id="searchTypeNearPlace" value="nearPlace"
							${searchType != null && searchType == 'nearPlace' ? 'selected' : ''}>가까운
							순</option>
						<option id="searchTypePopular" value="popular"
							${searchType != null && searchType == 'popular' ? 'selected' : ''}>인기많은
							순</option>
						<option id="searchTypeBestSeller" value="bestSeller"
							${searchType != null && searchType == 'bestSeller' ? 'selected' : ''}>거래가
							많은 판매자 순</option>
					</select>
					<p>필터:</p>
					<div class="dropdown dropdown_checkBox">
						<button class="btn dropdown-toggle dropdownBtn" type="button"
							data-bs-toggle="dropdown" aria-expanded="false">===필터
							선택===</button>
						<ul class="dropdown-menu">
							<c:forEach var="value" items="${categoryAllList}">
								<li><c:set var="isChecked"
										value="${categoryList != null && fn:contains(categoryList, value)}" />
									<c:forEach var="category" items="${categoryList}">
										<c:if test="${category == value}">
											<c:set var="isChecked" value="true" />
										</c:if>
									</c:forEach> <input type="checkbox" name="categoryList"
									id="category_${value}" value="${value}"
									class="category-checkbox" ${isChecked ? 'checked':''} /> <label
									class="radio_type" for="category_${value}">${value}</label></li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class="sear_categoryBtn">
					<button type="submit" class="sear_category">상세검색</button>
					<button type="button" class="sear_category" id="resetBtn">초기화</button>
				</div>
			</div>

		</div>

		<script>
		 document.addEventListener('DOMContentLoaded', function() {
		        // li 클릭 시 체크박스 토글
		        document.querySelectorAll('.dropdown-menu li').forEach(li => {
		            li.addEventListener('click', function(event) {
		                const checkbox = li.querySelector('input[type="checkbox"]');
		                if (checkbox) {
		                    checkbox.checked = !checkbox.checked;
		                }
		            });
		        });

		        // 드롭다운 메뉴 클릭 시 자동 숨김 방지
		        document.querySelector('.dropdown-menu').addEventListener('click', function(event) {
		            event.stopPropagation();
		        });

		        // 초기화 버튼 클릭 시 체크박스 모두 체크 해제
		        document.querySelector('#resetBtn').addEventListener('click', function(event) {
		            document.querySelectorAll('.dropdown-menu input[type="checkbox"]').forEach(checkbox => {
		                checkbox.checked = false;
		            });
		            
		            // select 요소의 모든 옵션 선택 해제
		            document.querySelectorAll('.selectBox_value option').forEach(option => {
		                option.selected = false;
		            });
		        });
		    });
		</script>

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
								src="${path}/resources/img/${item.item_thumbPath}" alt="매물사진">
								<div class="item_view">
									<h3>${item.item_title}</h3>
									<div class="item_price">
										<h4>
											<fmt:formatNumber value="${item.item_price}" type="number"
												groupingUsed="true" />
											원
										</h4>
										<br>
									</div>
									<div class="item_like">
										<p>관심 ${item.item_interest}</p>
										<p>댓글 ${item.repl_count}</p>
									</div>
									<div class="item_addr"
										style="display: flex; justify-content: space-between;">
										<div style="display: flex">
											<img src="${path}/resources/img/gps.png" alt="위치">
											<p>${item.item_place}</p>
										</div>
										<div>
											<h5>
												<fmt:formatDate value="${item.item_enrollDate}"
													pattern="yy/MM/dd" />
											</h5>
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="modal fade" id="placeModal" tabindex="-1"
				aria-labelledby="placeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="placeModalLabel">주변 검색</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div id="map" style="width: 100%; height: 400px;"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="confirmPlace">확인</button>
						</div>
					</div>
				</div>
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
				class="${pageInfo.currentPage == currentPage ? 'active' : ''}">${currentPage}</a>
		&nbsp;
		</c:forEach>

		<a
			href="itemList.do?currentPage=${pageInfo.nextPage}&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}">&gt;</a>
		&nbsp; <a
			href="itemList.do?currentPage=${pageInfo.lastPage}&searchValue=${searchValue}&searchType=${searchType}&categoryList=${fn:join(categoryList, ',')}">&gt;|</a>
		&nbsp;
	</div>


</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a41a4466a946b1b4af605da49e598032&libraries=services"></script>

<script>
		document.addEventListener('DOMContentLoaded', () => {
			let map; // 지도 객체
			const mapButton = document.getElementById("mapButton"); // 장소 선택 버튼
			const mapContainer = document.getElementById('map');
			const placeModal = new bootstrap.Modal(document.getElementById('placeModal'));
			
			const fullAddress="${loginMember.acc_address}";
			
			mapButton.addEventListener('click', (e) => {
				e.preventDefault();
	            placeModal.show();
	            if (!map) {
	                const addressX = ${loginMember.acc_addressX}; 
	                const addressY = ${loginMember.acc_addressY};
	                
	                const mapOption = {
		                    center: new kakao.maps.LatLng(addressX, addressY),
		                    level: 3 
		            };
	                map = new kakao.maps.Map(mapContainer, mapOption);
	                setTimeout(function() {
		                if (map) {
		                    map.relayout();
		                    map.setCenter(new kakao.maps.LatLng(addressX, addressY));
		                } else {
		                    console.error("Map object is not initialized yet.");
		                }
		            }, 500); 
	            }
			});
			
		});
		
</script>