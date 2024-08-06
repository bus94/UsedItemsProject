<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<<<<<<< HEAD
<<<<<<< HEAD
<section id="content" class="container" style="padding-top: 100px;">
	<h1>메인 컨테이너</h1>
	<a href="${path}/account/login.do">로그인</a><br>
	<a href="${path}/account/signup.do">회원가입</a><br>
	<a href="${path}/item/itemList.do">매물검색</a><br>
	<a href="${path}/item/itemEnroll.do">매물등록</a><br>
	<a href="${path}/account/acc_info.do?acc_id=id_test2">계정 정보 조회 페이지(id_test2)</a><br>
	<a href="${path}/account/acc_info.do?acc_id=id_test4">계정 정보 조회 페이지(id_test4)</a><br>
	<a href="${path}/blacklist/complainList.do">사기 조회 페이지</a><br>
	<a href="${path}/blacklist/mainProto1.do">메인프로토1</a><br>
	<a href="${path}/item/interest.do">찜한 상품</a><br>
	<a href="${path}/chat/chat.do">채팅하기</a><br>
	<a href="${path}/common/test.do">테스트</a><br>
	
=======
=======
>>>>>>> 984f9271c33c5add876e62eb976575aa1667b58a
<section id="content" class="home_page container">

	<h1>캐러셀 ad1</h1>

	<!-- concept viewer -->
	<div id="carouselExampleAutoplaying" class="carousel slide"
		data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${path}/resources/img/item4.jpg"
					class="carsl d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="${path}/resources/img/item2.jpg"
					class="carsl d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="${path}/resources/img/item3.jpg"
					class="carsl d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- concept viewer -->

	<h1>Item Category</h1>

	<!-- category viewer -->
	<div id="categories" class="container w-100 mt-5 mb-5">
		<h2 class="categ_title">Categories</h2>
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







<<<<<<< HEAD
>>>>>>> 984f9271c33c5add876e62eb976575aa1667b58a
=======
>>>>>>> 984f9271c33c5add876e62eb976575aa1667b58a
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
