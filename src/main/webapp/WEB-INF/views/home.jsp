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
	<h1>새로 올라온 상품</h1>

	<div class="container d-flex">

		<c:forEach var="each" items="${new5}">

			<div class="container d-flex flex-wrap">
				<div class="item">
					<img src="${path}/resources/img/item2.jpg" alt="1">
					<div class="item_view">
						<h3>${each.item_title}</h3>
						<div class="item_price">
							<h4>${each.item_price}원</h4>
							<h5>${each.item_enrollDate}</h5>
						</div>
						<div class="item_like">
							<p>${each.item_interest}</p>
							<p>${each.repl_count}</p>
							<!-- 채팅개수???  -->
						</div>
						<div class="item_addr">
							<img src="${path}/resources/img/gps.png" alt="위치">
							<p>${each.item_place }</p>
						</div>
					</div>
				</div>
			</div>

		</c:forEach>
	</div>



	<h1>Power Seller</h1>
	<p>ID: ${powerSeller.acc_id}, 별명: ${powerSeller.acc_nickname} 주소:
		${powerSeller.acc_address}</p>

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
		</div>
	</div>




	<h1>개조심</h1>

	<div class="container d-flex">
		<div>
			<img src="${path}/resources/img/redwhistle.jpg" class="d-block"
				style="width: 200px;" alt="...">
		</div>
		<div>
			<table id="blacklist_container"
				class="table table-warning table-borderless table-striped table-hover">
				<thead class="table-dark">
					<tr class="text-center">
						<th class="list_index text-end" scope="col">#</th>
						<th class="list_count" scope="col">피신고횟수</th>
						<th class="list_id" scope="col">ID</th>
						<th class="list_nickname" scope="col">별명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="each" varStatus="stat" begin="0" step="1"
						items="${black5}">
						<!-- stat.current: 현재 item 상세 // stat.index: 0부터 // stat.count: 1부터 -->
						<tr class="text-center">
							<th class="list_index text-end" scope="row">${stat.count}</th>
							<td class="list_count">${each.acc_blackCount}</td>
							<td class="list_id">${each.acc_id}</td>
							<td class="list_nickname">${each.acc_nickname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>


</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
