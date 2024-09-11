<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_content_list" style="padding-top: 100px;">
	<!-- 물품 전체 목록 검색 조회 -->
	<form action="${path}/item/itemList.do" method="post" id="searchForm">
		<div class="category">
			<div class="selectBox">
				<div class="selectBoxIn">
					<!-- 정렬 (조회순, 매너등급순) -->
					<p>정렬:</p>
					<select class="selectBox_value" name="searchType">
						<!-- 정렬 선택 -->
						<option value="">===정렬 선택===</option>
						<option id="searchTypePopular" value="popular"
							${searchType != null && searchType == 'popular' ? 'selected' : ''}>조회순</option>
						<option id="searchTypeBestSeller" value="bestSeller"
							${searchType != null && searchType == 'bestSeller' ? 'selected' : ''}>매너등급순</option>
					</select>
					<!-- 카테고리 필터 ("상의", "하의", "신발", "기타의류", "지갑", "피규어", "전자기기", "가구", "식품", "기타") -->
					<p>필터:</p>
					<div class="dropdown dropdown_checkBox">
						<!-- 필터 선택 -->
						<button class="btn dropdown-toggle dropdownBtn" type="button"
							data-bs-toggle="dropdown" aria-expanded="false">===필터
							선택===</button>
						<!-- 드롭다운 메뉴 -->
						<ul class="dropdown-menu">
							<!-- categoryAllList 리스트를 변수 value에 저장 -->
							<c:forEach var="value" items="${categoryAllList}">
								<li>
									<!-- categoryList가 비어있는지 확인하고, categoryList에 value가 포함되어있는지 확인한 후 true면 isChecked에 저장 -->
									<c:set var="isChecked"
										value="${categoryList != null && fn:contains(categoryList, value)}" />
									<!-- categoryList 리스트를 변수 category에 저장 --> 
									<c:forEach
										var="category" items="${categoryList}">
										<!-- categoryList의 category값과 categoryAllList의 value값이 같다면 isChecked는 true -->
										<c:if test="${category == value}">
											<c:set var="isChecked" value="true" />
										</c:if>
									</c:forEach> 
									<!-- isChecked가 true라면 체크박스에 체크된 상태로 표현 --> 
									<input type="checkbox" name="categoryList" id="category_${value}"
									value="${value}" class="category-checkbox" ${isChecked ? 'checked':''} /> 
									<label class="radio_type" for="category_${value}">${value}</label>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class="sear_categoryBtn">
					<button type="submit" class="sear_category">상세검색</button>
					<button type="button" class="sear_category" id="resetBtn">초기화</button>
				</div>
			</div>
			<div id="divContainer"></div>
		</div>

		<script>
		 document.addEventListener('DOMContentLoaded', function() {
             // 카테고리 필터의 체크박스에서 선택한 경우 체크된 값에 대해 작은 div로 표현   
			 const divContainer = document.querySelector('#divContainer');
		        // li 클릭 시 체크박스 토글
		        document.querySelectorAll('.dropdown-menu li').forEach(li => {
		            li.addEventListener('click', function(event) {
		                const checkbox = li.querySelector('input[type="checkbox"]');
		                if (checkbox) {
		                    checkbox.checked = !checkbox.checked;
		                }
		                
		                const value = checkbox.value;
                        console.log("value: " + value);

                        // 기존 div를 찾기
                        let existingDiv = Array.from(document.querySelectorAll('.addDiv')).find(div => div.getAttribute('data-value') === value);
                        
                        if (checkbox.checked) {
                            if (!existingDiv) {
                                // 새로운 div 생성
                                const newDiv = document.createElement('div');
                                newDiv.className = 'addDiv';
                                newDiv.setAttribute('data-value', value);

                                // 새로운 p 태그 생성 및 추가
                                const newParagraph = document.createElement('p');
                                newParagraph.textContent = value;
                                newDiv.appendChild(newParagraph);
                                
                                // 새로운 x 버튼 생성 및 추가
                                const removeBtn = document.createElement('button');
                                removeBtn.textContent = 'x';
                                removeBtn.className = 'removeBtn';
                                removeBtn.type = 'button';
                                newDiv.appendChild(removeBtn);

                                // divContainer에 추가
                                divContainer.appendChild(newDiv);
                                
                                // removeBtn 클릭 시
                                removeBtn.addEventListener('click', function() {
                                	// 체크박스 선택 해제
            		                if (checkbox) {
            		                    checkbox.checked = false;
            		                }
                                	// div 제거
                                	divContainer.removeChild(newDiv);
                                });
                            }
                        } else {
                            if (existingDiv) {
                                // 기존 div 제거
                                divContainer.removeChild(existingDiv);
                            } else {
                                console.warn("제거할 div가 없다.");
                            }
                        }
		            });
		        });
		        
		     // 페이지 로드 시 체크박스 상태에 따라 div 생성
		        function initializeDivs() {
		            document.querySelectorAll('.dropdown-menu input[type="checkbox"]').forEach(checkbox => {
		                if (checkbox.checked) {
		                    const value = checkbox.value;
		                    let existingDiv = document.querySelector(`.addDiv[data-value="${value}"]`);

		                    if (!existingDiv) {
		                        const newDiv = document.createElement('div');
		                        newDiv.className = 'addDiv';
		                        newDiv.setAttribute('data-value', value);

		                        const newParagraph = document.createElement('p');
		                        newParagraph.textContent = value;
		                        newDiv.appendChild(newParagraph);

		                        const removeBtn = document.createElement('button');
		                        removeBtn.textContent = 'x';
		                        removeBtn.className = 'removeBtn';
		                        removeBtn.type = 'button';
		                        newDiv.appendChild(removeBtn);

		                        divContainer.appendChild(newDiv);

		                        removeBtn.addEventListener('click', function() {
		                            checkbox.checked = false;
		                            divContainer.removeChild(newDiv);
		                        });
		                    }
		                }
		            });
		        }

		        // 호출하여 초기화
		        initializeDivs();

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
		            
		         	// 생성된 div 요소 모두 삭제
		            while (divContainer.firstChild) {
		                    divContainer.removeChild(divContainer.firstChild);
		            }
		        });
		    });
		</script>

		<div class="item_title">
			<h3>검색 결과</h3>
		</div>
		<!-- itemList가 비어있는 경우 -->
		<c:if test="${empty itemList}">
			<tr>
				<td colspan="6">조회된 글이 없습니다.</td>
			</tr>
		</c:if>
		<!-- itemList가 있는 경우 -->
		<c:if test="${not empty itemList}">
			<!-- 물품 정보 -->
			<div class="item_wrapper">
				<c:forEach var="item" items="${itemList}">
					<div class="item_container">
						<div class="item">
							<a href="${path}/item/itemView?item_index=${item.item_index}"
								style="text-decoration: none; color: black">
								<div class="imgDiv">
									<img src="${path}/resources/img/${item.item_thumbPath}"
										alt="물품사진">
								</div>
								<div class="item_view">
									<h3>${item.item_title}</h3>
									<div class="item_price">
										<h4>
											<!-- 가격 formatter -->
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
									<!-- 물품 판매 장소 -->
									<div class="item_addr"
										style="display: flex; justify-content: space-between;">
										<div style="display: flex">
											<img src="${path}/resources/img/gps.png" alt="위치">
											<p>${item.item_place}</p>
										</div>
										<div>
											<h5>
												<!-- 물품 등록 날짜 formatter -->
												<fmt:formatDate value="${item.item_enrollDate}"
													pattern="MM/dd" />
											</h5>
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- <div class="modal fade" id="placeModal" tabindex="-1"
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
			</div> -->
		</c:if>
	</form>

	<!-- 페이지네이션 -->
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

<!-- <script>
		document.addEventListener('DOMContentLoaded', () => {
			// 지도 객체
			let map; 
			// 장소 선택 버튼
			const mapButton = document.getElementById("mapButton"); 
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
</script> -->