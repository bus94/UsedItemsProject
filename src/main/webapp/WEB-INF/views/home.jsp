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
							<div class="item_view">
								<h3>${each.item_title}</h3>
								<div class="item_price">
									<h4>${each.item_price}원</h4>
									<h5>
										<fmt:formatDate value="${each.item_enrollDate}"
											pattern="yy/MM/dd" />
									</h5>
								</div>
								<div class="item_like">
									<p>관심 ${each.item_interest}</p>
									<p>댓글 ${each.repl_count}</p>
								</div>
								<div class="item_addr">
									<img src="${path}/resources/img/gps.png" alt="위치">
									<p>${each.item_place}</p>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>

	</div>
	<%-- 
	<div class="popular_product">
        <div class="left_section">
            <div>
                <h3>Popular Product</h3>
                <p>세잎마켓에서 인기있는 상품들을 만나보세요.
            </div>
            <div>
                <img alt="" src="${path}/resources/img/zz.png">
            </div>
        </div>
        <div class="right_section">
            <div class="pic_box">
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
                <div class="pic">
                    <img alt="" src="${path}/resources/img/study.jpg">
                </div>
            </div>
        </div>
    </div> --%>


	<div class="container d-flex">
		<div>
			<table id="blacklist_container"
				class="table table-warning table-borderless table-striped table-hover">
				<a href="${path}/blacklist/complainList.do" style="font-size: 22px;">신고조회
					하러가기 &gt;</a>
				<thead class="table-dark">
					<tr class="text-center" style="background-color: #AAFFA3">
						<th class="list_index text-end" scope="col"></th>
						<th class="list_count" scope="col" style="width: 100px;">신고접수</th>
						<th class="list_id" scope="col" style="width: 150px;">ID</th>
						<th class="list_nickname" scope="col" style="width: 200px;">별명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="each" varStatus="stat" begin="0" step="1"
						items="${black5}">
						<!-- stat.current: 현재 item 상세 // stat.index: 0부터 // stat.count: 1부터 -->
						<tr class="text-center">
							<th class="list_index text-end" scope="row">${stat.count}</th>
							<td class="list_count">${each.acc_blackCount}건</td>
							<td class="list_id">${each.acc_id}</td>
							<td class="list_nickname">${each.acc_nickname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="rolling">
		<div class="rolling-list">
			<ul>
				<li style="list-style: none">
					<div class="image-wrap">
						<img src="${path}/resources/img/banner.png" alt="">
					</div>
				</li>
				<li style="list-style: none">
					<div class="image-wrap">
						<img src="${path}/resources/img/banner.png" alt="">
					</div>
				</li>
			</ul>
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
