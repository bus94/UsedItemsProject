<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container acc_info_page" style="padding-top: 100px;">
	<div class="container acc_summary d-flex">
		<div id="acc_public" class="container inform">
			<div class="container d-flex">
				<img src="${path}/resources/img/login.png" alt="프로필사진">
				<div class="container info_box editable_info">
					<p>별명</p>
					<p>아이디</p>
					<button type="button" class="btn btn-success btn-sm" onclick="location.href='${path}/account/alter.do'">내 정보
						수정</button>
				</div>
			</div>
			<hr>
			<div class="container info_box uneditable_info">
				<div>
					<p>등급</p>
					<p>거래 횟수</p>
				</div>
				<div>
					<span>피신고 횟수</span>
					<button type="button" class="btn btn-success btn-sm" onclick="location.href='${path}/blacklist/complainList.do'">신고내역
						조회</button>
				</div>
			</div>
		</div>

		<div id="acc_profit" class="container inform">
			<h4 class="text-center">수입 지출 내역</h4>
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
	</div>
	<div id="acc_interest" class="container">
		<div class="container subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4>찜 Interest</h4>
			<div class="vr align-self-center"></div>
		</div>
		<div class="item_container2 d-flex">
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




	<div id="acc_ondeal" class="container">
		<div class="container subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4>거래 중 Ondeal</h4>
			<div class="vr align-self-center"></div>
		</div>
		<div class="item_container2 d-flex">
			<div class="item"></div>
		</div>
	</div>




	<div id="acc_selling" class="container">
		<div class="container subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4>판매 내역 Selling</h4>
			<div class="vr align-self-center"></div>
			<button type="button" id="btn_enroll_item"
				class="btn btn-success btn-sm align-self-center"
				onclick="location.href='${path}/item/itemEnroll.do'">매물 등록</button>
		</div>
		<div class="item_container2 d-flex">
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


	<div id="acc_buying" class="container">
		<div class="container subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4>구매 내역 Buying</h4>
			<div class="vr align-self-center"></div>
		</div>
		<div class="item_container2 d-flex">
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


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>