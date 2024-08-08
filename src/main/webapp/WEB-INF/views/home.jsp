<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<script defer src="${path}/resources/js/home.js"></script>

<section id="main_content" class="home_page">
	
	<div id="carouselExampleAutoplaying" class="carousel slide carousel-fade"
		data-bs-ride="carousel">
		<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${path}/resources/img/slide1.jpg" class="w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${path}/resources/img/slide2.jpg" class="w-100" alt="...">
                </div>
            </div>
        </div>
	</div>


	<div id="categories" class="categories">
		<div class="majors">
			<a href="${path}/item/itemList.do?categoryList=상의" id="category" class="major"><i class="fa-solid fa-shirt"></i>
				<p class="major_title">상의</p></a>
			<a href="${path}/item/itemList.do?categoryList=하의" id="category" class="major"><i class="fa-solid fa-socks"></i>
				<p class="major_title">하의</p></a>
			<a href="${path}/item/itemList.do?categoryList=신발" id="category" class="major"><i
				class="fa-solid fa-shoe-prints"></i>
				<p class="major_title">신발</p></a>
			<a href="${path}/item/itemList.do?categoryList=기타의류" id="category" class="major"><i class="fa-solid fa-glasses"></i>
				<p class="major_title">기타의류</p></a>
			<a href="${path}/item/itemList.do?categoryList=지갑" id="category" class="major"><i class="fa-solid fa-wallet"></i>
				<p class="major_title">지갑</p></a>
			<a href="${path}/item/itemList.do?categoryList=피규어" id="category" class="major"><i
				class="fa-solid fa-jet-fighter-up"></i>
				<p class="major_title">피규어</p></a>
			<a href="${path}/item/itemList.do?categoryList=전자기기" id="category" class="major"><i
				class="fa-solid fa-camera-retro"></i>
				<p class="major_title">전자기기</p></a>
			<a href="${path}/item/itemList.do?categoryList=가구" id="category" class="major"><i class="fa-solid fa-chair"></i>
				<p class="major_title">가구</p></a>
			<a href="${path}/item/itemList.do?categoryList=식품" id="category" class="major"><i class="fa-solid fa-cheese"></i>
				<p class="major_title">식품</p></a>
			<a href="${path}/item/itemList.do?categoryList=기타" id="category" class="major"><i
				class="fa-regular fa-lightbulb"></i>
				<p class="major_title">기타</p></a>
		</div>
	</div>

	<div class="container d-flex">
		<!-- power seller -->
		<div>
			<img src="${path}/resources/img/study.jpg" class="d-block w-100"
				alt="...">
		</div>
		<div class="container d-flex flex-wrap">
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
		</div>
	</div>

	<h1>광고</h1>

	<!-- ad banner -->
	<div class="ad_banner" style="width: 100%; height: 300px; margin: auto">
		<img alt="광고" src="${path}/resources/img/study.jpg">
	</div>
	

	<h1>개조심</h1>

	<div class="">
		<div>
			<img src="${path}/resources/img/redwhistle.jpg" class="d-block w-100"
				alt="...">
		</div>
	</div>


</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
