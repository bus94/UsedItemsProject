<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<script defer src="${path}/resources/js/home.js"></script>

<section id="main_content" class="home_page">

	<div id="carouselExampleAutoplaying"
		class="carousel slide carousel-fade" data-bs-ride="carousel">
		<div id="carouselExampleAutoplaying" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active" data-bs-interval="1500">
					<img src="${path}/resources/img/slide1.jpg" class="w-100" alt="...">
				</div>
				<div class="carousel-item" data-bs-interval="1500">
					<img src="${path}/resources/img/slide2.jpg" class="w-100" alt="...">
				</div>
			</div>
		</div>
	</div>


	<div id="categories" class="categories">
		<div class="majors">
			<a href="${path}/item/itemList.do?categoryList=상의" id="category"
				class="major"><i class="fa-solid fa-shirt"></i>
				<p class="major_title">상의</p></a> <a
				href="${path}/item/itemList.do?categoryList=하의" id="category"
				class="major"><i class="fa-solid fa-socks"></i>
				<p class="major_title">하의</p></a> <a
				href="${path}/item/itemList.do?categoryList=신발" id="category"
				class="major"><i class="fa-solid fa-shoe-prints"></i>
				<p class="major_title">신발</p></a> <a
				href="${path}/item/itemList.do?categoryList=기타의류" id="category"
				class="major"><i class="fa-solid fa-glasses"></i>
				<p class="major_title">기타의류</p></a> <a
				href="${path}/item/itemList.do?categoryList=지갑" id="category"
				class="major"><i class="fa-solid fa-wallet"></i>
				<p class="major_title">지갑</p></a> <a
				href="${path}/item/itemList.do?categoryList=피규어" id="category"
				class="major"><i class="fa-solid fa-jet-fighter-up"></i>
				<p class="major_title">피규어</p></a> <a
				href="${path}/item/itemList.do?categoryList=전자기기" id="category"
				class="major"><i class="fa-solid fa-camera-retro"></i>
				<p class="major_title">전자기기</p></a> <a
				href="${path}/item/itemList.do?categoryList=가구" id="category"
				class="major"><i class="fa-solid fa-chair"></i>
				<p class="major_title">가구</p></a> <a
				href="${path}/item/itemList.do?categoryList=식품" id="category"
				class="major"><i class="fa-solid fa-cheese"></i>
				<p class="major_title">식품</p></a> <a
				href="${path}/item/itemList.do?categoryList=기타" id="category"
				class="major"><i class="fa-regular fa-lightbulb"></i>
				<p class="major_title">기타</p></a>
		</div>
	</div>

	<div class="newItem_wrap">

		<div class="new_arrow prev">
			<img alt=".." src="${path}/resources/img/prev.png">
		</div>
		<div class="new_arrow next">
			<img alt=".." src="${path}/resources/img/next.png">
		</div>
		<div class="newItem_container">
			<h3 style="font-size: 22px;">새로 올라온 상품 &gt;</h3>
			<div class="newItem_container2">
				<c:forEach var="each" items="${new5}">
					<div class="item2">
						<a href="${path}/item/itemView?item_index=${each.item_index}"
							style="text-decoration: none; color: black"> <img
							src="${path}/resources/img/${each.item_thumbPath}" alt="..">
							<div class="item_view2">
								<h3>${each.item_title}</h3>
								<div class="item_price">
									<h4>
										<fmt:formatNumber value="${each.item_price}" type="number"
											groupingUsed="true" />
										원
									</h4>

								</div>
								<div class="item_like">
									<p>관심 ${each.item_interest}</p>
									<p>댓글 ${each.repl_count}</p>
								</div>
								<div class="item_addr"
									style="display: flex; justify-content: space-between;">
									<div style="display: flex">
										<img src="${path}/resources/img/gps.png" alt="위치">
										<p>${each.item_place}</p>
									</div>
									<div>
										<h5>
											<fmt:formatDate value="${each.item_enrollDate}"
												pattern="yy/MM/dd" />
										</h5>
									</div>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="ad_banner">
		<img alt="" src="${path}/resources/img/safemarket_banner.png">
	</div>

	<h3 style="font-size: 22px; margin-left: 200px">지금 인기있는 제품을 만나보세요
		&gt;</h3>
	<div class="best_Container" style="height: 600px">
		<ul class="best_Carousel">
			<li class="best_Items Front">
				<div class="best_item">
					<img src="${path}/resources/img/study.jpg" alt="1">
					<div class="bestitem_view">
						<h3>제품명입니다1</h3>
					</div>
				</div>
			</li>
			<li class="best_Items Left">
				<div class="best_item">
					<img src="${path}/resources/img/redwhistle.jpg" alt="1">
					<div class="bestitem_view">
						<h3>제품명입니다1</h3>
					</div>
				</div>
			</li>
			<li class="best_Items Left2">
				<div class="best_item">
					<img src="${path}/resources/img/zz.png" alt="1">
					<div class="bestitem_view">
						<h3>제품명입니다1</h3>
					</div>
				</div>
			</li>
			<li class="best_Items Right">
				<div class="best_item">
					<img src="${path}/resources/img/clover.png" alt="1">
					<div class="bestitem_view">
						<h3>제품명입니다1</h3>
					</div>
				</div>
			</li>
			<li class="best_Items Right2">
				<div class="best_item">
					<img src="${path}/resources/img/message.png" alt="1">
					<div class="bestitem_view">
						<h3>제품명입니다1</h3>
					</div>
				</div>
			</li>
		</ul>
	</div>

	<div class="mainbox_container">
		<div style="display:flex;width: 100%; justify-content: space-between;">
			<div class="mainbox boxLeft">
				<div class="box_txt">
					<h3>누적 회원수</h3>
					<h2>
						<span class="counter" data-target="3687546">0</span>명
					</h2>
				</div>
				<div class="box_img">
					<img src="${path}/resources/img/clover.png" alt="">
				</div>
				<div class="boxhover_img">
					<img src="${path}/resources/img/internet.jpg" alt="">
				</div>
				<div class="overlay"></div>
			</div>
			<div class="mainbox boxRight">
				<div class="box_txt">
					<h3>누적 거래량</h3>
					<h2>
						<span class="counter" data-target="9999">0</span>건
					</h2>
				</div>
				<div class="box_img">
					<img src="${path}/resources/img/clover.png" alt="">
				</div>
				<div class="boxhover_img">
					<img src="${path}/resources/img/trade.jpg" alt="">
				</div>
				<div class="overlay"></div>
			</div>
		</div>
		<div style="display:flex; gap:20px;">
			<div class="mainbox boxUnderLeft">
				<div class="box_txt">
					<h3>금일 거래량</h3>
					<h2>
						<span class="counter" data-target="65">0</span>건
					</h2>
				</div>
				<div class="box_img">
					<img src="${path}/resources/img/clover.png" alt="">
				</div>
				<div class="boxhover_img">
					<img src="${path}/resources/img/trade2.png" alt="">
				</div>
				<div class="overlay"></div>
			</div>
			<div class="mainbox boxUnderRight">
				<div class="box_txt">
					<h3>누적 신고</h3>
					<h2>
						<span class="counter" data-target="1234">0</span>건
					</h2>
				</div>
				<div class="box_img">
					<img src="${path}/resources/img/clover.png" alt="">
				</div>
				<div class="boxhover_img">
					<img src="${path}/resources/img/police.jpeg" alt="">
				</div>
				<div class="overlay"></div>
			</div>
		</div>

	</div>

	<div class="rolling">
		<div class="rolling-list">
			<ul style="list-style: none">
				<li>
					<div class="image-wrap">
						<img src="${path}/resources/img/rolling.png" alt="">
					</div>
				</li>
				<li>
					<div class="image-wrap">
						<img src="${path}/resources/img/rolling.png" alt="">
					</div>
				</li>
			</ul>
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
