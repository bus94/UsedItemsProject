<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container acc_info_page" style="padding-top: 100px;">

	<c:if test="${loginMember != null}"> </c:if>

	<c:choose>
		<c:when test="${other_info == null}"> <!-- 마이페이지를 누른 경우 -->
			<c:set var="account_info" value="${loginMember}" />
		</c:when>
		<c:otherwise> <!-- 다른사람 정보를 누른 경우 -->
			<c:set var="account_info" value="${other_info}" />
		</c:otherwise>
	</c:choose>

	
	<div class="container acc_summary">
		<div id="acc_public" class="container inform">
			<div class="container d-flex">
				<div class="container info_box">
					<div class="d-flex">
						<p class="public_title container mt-3"><span>아</span><span>이</span><span>디</span></p><p class="public_text ms-3 mt-3">${account_info.acc_id}</p>
					</div>
					<div class="d-flex">
						<p class="public_title container"><span>별</span><span>명</span></p><p class="public_text ms-3">${account_info.acc_nickname}</p>
					</div>
					<div class="d-flex">
						<p class="public_title container"><span>주</span><span>소</span></p><p class="public_text ms-3">${account_info.acc_address}</p>
					</div>
				</div>
				<div class="btn_box container d-flex flex-column align-items-center">
					<img id="acc_profile" class="s120"
						src="${path}/resources/img/login.png" alt="프로필사진">
					<c:if test="${other_info == null}">
					<button type="button" id="btn_acc_mod"
						class="btn_acc btn btn-success btn-sm"
						onclick="location.href='${path}/account/alter.do'">내 정보
						수정</button>
					</c:if>
				</div>
			</div>
			<hr>
			<div class="container d-flex">
				<div class="container info_box">
					<div class="d-flex">
						<p class="public_title container mt-3"><span>등</span><span>급</span></p><p class="public_text ms-3 mt-3">${account_info.acc_level}</p>
					</div>
					<div class="d-flex">
						<p class="public_title container"><span>거</span><span>래</span><span>횟</span><span>수</span></p><p class="public_text ms-3">${account_info.acc_count}</p>
					</div>
					<div class="black_report d-flex mb-3">
						<div class="d-flex">
							<p class="public_title container"><span>피</span><span>신</span><span>고</span><span>횟</span><span>수</span></p><p class="public_text ms-3">${account_info.acc_blackCount}</p>
						</div>
						
						<c:if test="${account_info.acc_id != loginMember.acc_id}">
						<!-- 보고 있는 계정정보가 내가 로그인한 아이디가 아니라면 -->
							<img class="ms-3" src="${path}/resources/img/report.png" alt="신고">
							<a href="${path}/blacklist/complain.do?object_id=${account_info.acc_id}">신고하기</a>
						</c:if>
						
					</div>	
				</div>
				<div class="btn_box container d-flex flex-column align-items-center">
					<p id="acc_mock" class="">&nbsp;</p>			
					<button type="button" id="btn_acc_blacklist" class="btn_acc btn btn-warning btn-sm"
							onclick="location.href='${path}/blacklist/complainList.do?currentPage=1&searchBlack=${account_info.acc_id}&searchType=acc_id'">신고내역 조회</button>
				</div>
			</div>
		</div>
	<c:if test="${other_info == null}">
		<div id="acc_profit" class="container inform">
			<h3 class="text-center">수입 지출 내역</h3>
			<div class="d-flex align-items-end flex-column">
				<div class="input-group input-group-sm w-100" id="period">
					<select class="form-select" id="inputGroupSelect04"
						aria-label="Example select with button addon">
						<option selected>이번달</option>
						<option value="1">3개월</option>
						<option value="2">6개월</option>
						<option value="3">1년</option>
						<option value="4">기간 설정</option>
					</select>
					<button class="btn btn-outline-secondary" type="button">조회</button>
				</div>
			</div>
			<hr>
			<div class="d-flex justify-content-between">
				<p>&nbsp;&nbsp;&nbsp;&nbsp;판매 금액(2건) :</p>
				<p>100,000원</p>
			</div>
			<div class="d-flex justify-content-between">
				<p>(-) 구매 금액(1건) :</p>
				<p>35,000원</p>
			</div>
			<hr>
			<div class="d-flex justify-content-between">
				<p>(=) 수익 금액 :</p>
				<p>65,000원</p>
			</div>
		</div>
	</c:if>
	</div>
	
	<c:if test="${other_info == null}">
	<div id="acc_interest" class="container items_domain">
		<div class="d-flex">
		<div class="subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4 class="container"><span>관</span><span>심</span><span>상</span><span>품</span></h4>
			<div class="vr align-self-center"></div>
		</div>
			<button type="button" id="btn_item_interest"
				class="btn_item btn btn-success btn-sm align-self-center"
				onclick="location.href='${path}/item/interest.do'">자세히</button>
		</div>
		<div class="item_container_acc d-flex">
			<div class="item">
				<img src="${path}/resources/img/item1.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item2.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item3.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item3.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item3.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>



	<div id="acc_ondeal" class="container items_domain">
		<div class="subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4 class="container"><span>거</span><span>래</span><span>중</span></h4>
			<div class="vr align-self-center"></div>
		</div>
		<div class="item_container_acc d-flex">
			<div class="item"></div>
		</div>
	</div>




	<div id="acc_selling" class="container d-flex flex-column items_domain">
		<div class="d-flex">
		<div class="subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4 class="container"><span>판</span><span>매</span><span>내</span><span>역</span></h4>
			<div class="vr align-self-center"></div>
		</div>
			<c:if test="${other_info == null}">
			<button type="button" id="btn_item_enroll"
				class="btn_item btn btn-success btn-sm align-self-center"
				onclick="location.href='${path}/item/itemEnroll.do'">매물 등록</button>
			</c:if>
		</div>
		<div class="item_container_acc d-flex">
			<div class="item">
				<img src="${path}/resources/img/item1.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item2.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item3.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="acc_buying" class="container items_domain">
		<div class="subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4 class="container"><span>구</span><span>매</span><span>내</span><span>역</span></h4>
			<div class="vr align-self-center"></div>
		</div>
		<div class="item_container_acc d-flex">
			<div class="item">
				<img src="${path}/resources/img/item1.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item2.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img src="${path}/resources/img/item3.jpg" alt="1">
				<div class="item_view">
					<h3>제품명입니다</h3>
					<div class="item_price">
						<h4>9999원</h4>
						<h5>몇분 전</h5>
					</div>
					<div class="item_like">
						<p>관심 22</p>
						<p>채팅 10</p>
					</div>
					<div class="item_addr">
						<img src="${path}/resources/img/gps.png" alt="위치">
						<p>인천광역시 계양구</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
</section>

<script></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>