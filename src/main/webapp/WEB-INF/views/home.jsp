<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<script defer src="${path}/resources/js/home.js"></script>

<section id="main_content" class="home_page container">
	
	<div id="carouselExampleAutoplaying" class="carousel slide"
		data-bs-ride="carousel">
		<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${path}/resources/img/slide1.jpg" class="w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${path}/resources/img/slide1.jpg" class="w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="${path}/resources/img/slide1.jpg" class="w-100" alt="...">
                </div>
            </div>
        </div>
	</div>


	<div id="categories" class="container w-100 mt-5 mb-5">
		<ul class="majors d-flex flex-wrap">
			<li id="veggies" class="major"><i class="fa-solid fa-shirt"></i>
				<p class="major_title">상의</p></li>
			<li id="meat" class="major"><i class="fa-solid fa-socks"></i>
				<p class="major_title">하의</p></li>
			<li id="seafood" class="major"><i
				class="fa-solid fa-shoe-prints"></i>
				<p class="major_title">신발</p></li>
			<li id="seafood" class="major"><i class="fa-solid fa-glasses"></i>
				<p class="major_title">기타의류</p></li>
			<li id="seafood" class="major"><i class="fa-solid fa-wallet"></i>
				<p class="major_title">지갑</p></li>
			<li id="seafood" class="major"><i
				class="fa-solid fa-jet-fighter-up"></i>
				<p class="major_title">피규어</p></li>
			<li id="seafood" class="major"><i
				class="fa-solid fa-camera-retro"></i>
				<p class="major_title">전자기기</p></li>
			<li id="seafood" class="major"><i class="fa-solid fa-chair"></i>
				<p class="major_title">가구</p></li>
			<li id="seafood" class="major"><i class="fa-solid fa-cheese"></i>
				<p class="major_title">식품</p></li>
			<li id="seafood" class="major"><i
				class="fa-regular fa-lightbulb"></i>
				<p class="major_title">기타</p></li>
		</ul>
	</div>
	<!-- category viewer -->

	<h1>캐러셀 ad2</h1>

	<!-- ad banner -->
	<div id="carouselExampleSlidesOnly" class="carousel slide"
		data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${path}/resources/img/item1.jpg"
					class="ad_banner d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="${path}/resources/img/logo.png"
					class="ad_banner d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="${path}/resources/img/study.jpg"
					class="ad_banner d-block w-100" alt="...">
			</div>
		</div>
	</div>
	<!-- ad banner -->

	<h1>Power Seller</h1>

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

	<h1>개조심</h1>

	<div class="container d-flex">
		<div>
			<img src="${path}/resources/img/redwhistle.jpg" class="d-block w-100"
				alt="...">
		</div>
	</div>


</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
