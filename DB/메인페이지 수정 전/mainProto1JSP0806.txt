<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세잎마켓</title>

<!-- 부트스트랩 -->
<link defer
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- css, js 포함 -->
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/mainProto.css?v=${systemProperties['timestamp']}">
<script defer src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script defer src="${path}/resources/js/mainProto1.js"></script>

</head>
<body>

	<div id="pageContainer" class="container">
		<!-- 전체컨테이너 -->
		<!-- Header&Navi -->
		<nav id="before"
			class="fixed-top navbar navbar-expand-lg bg-body-tertiary bg-success-subtle">
			<div class="container-fluid ">
				<a class="navbar-brand fs-3" href="${path}/"> <img alt="로고"
					src="${path}/resources/img/logo.png">
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="${path}/item/itemList.do">매물 검색</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${path}/item/itemEnroll.do">매물 등록</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${path}/item/itemView.do">매물 상세</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 더보기 </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item"
									href="${path}/item/interest.do">관심 상품</a></li>
								<li><a class="dropdown-item"
									href="${path}/blacklist/complainList.do">신고 조회</a></li>
								<li><a class="dropdown-item"
									href="${path}/account/acc_info.do?acc_id=id_test4">계정 정보</a></li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li><a class="dropdown-item" href="#">Something else
										here</a></li>
							</ul></li>
					</ul>
					<form class="d-flex" role="search">
						<input
							class="form-control me-2 focus-ring focus-ring-success border border-success"
							type="search" placeholder="Search" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</div>
			</div>
			<!-- 회원페이지 -->
			<a href="${path}/account/my_info.do" id="nav_user" class="nav_icon"
				style="font-weight: bold;"><i class="fa-solid fa-circle-user"></i></a>
			<!-- 즐겨찾기 -->
			<a href="${path}/item/interest.do" id="nav_wish" class="nav_icon"><i
				class="fa-brands fa-gratipay"></i></a>
			<!-- 링크 -->
			<a href="#" id="nav_link" class="nav_icon"><i
				class="fa-solid fa-circle-nodes"></i></a>
			<!-- 위로가기 -->
			<a href="#" id="nav_toTop" class="nav_icon"><i
				class="fa-solid fa-circle-arrow-up"></i></a>
		</nav>

		<h1>캐러셀 ad1</h1>

		<!-- concept viewer -->
		<div id="carouselExampleAutoplaying" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="${path}/resources/img/item4.jpg" class="carsl d-block w-100"
						alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/item2.jpg" class="carsl d-block w-100"
						alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/item3.jpg" class="carsl d-block w-100"
						alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
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
					<img src="${path}/resources/img/item1.jpg" class="ad_banner d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/logo.png" class="ad_banner d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/study.jpg" class="ad_banner d-block w-100" alt="...">
				</div>
			</div>
		</div><!-- ad banner -->
		
		<h1>Power Seller</h1>
		
		<div class="container d-flex"><!-- power seller -->
			<div>
				<img src="${path}/resources/img/study.jpg" class="d-block w-100" alt="...">
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
				<img src="${path}/resources/img/redwhistle.jpg" class="d-block w-100" alt="...">
			</div>
		</div>






	</div>
	<!-- 전체컨테이너 -->

	<!-- 부트스트랩 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<!-- 폰트어썸 -->
	<script src="https://kit.fontawesome.com/ae370a3256.js"
		crossorigin="anonymous"></script>

</body>
</html>