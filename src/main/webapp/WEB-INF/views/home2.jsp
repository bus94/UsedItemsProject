<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />




<!-- 테스트페이지(헤더2) 연결 -->
<jsp:include page="/WEB-INF/views/common/header2.jsp"></jsp:include>



<script defer src="${path}/resources/js/home.js"></script>

<section id="content" class="home_page container">


	<h1>Hot5</h1>

	<div class="container d-flex">
		
		<c:forEach var="each" items="${hot5}">
	
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
						<p>${each.repl_count}</p><!-- 채팅개수???  -->
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
						<p>${each.repl_count}</p><!-- 채팅개수???  -->
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
	<p>ID: ${powerSeller.acc_id}, 별명: ${powerSeller.acc_nickname} 주소: ${powerSeller.acc_address}</p>

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
			<img src="${path}/resources/img/redwhistle.jpg" class="d-block" style="width:200px;"
				alt="...">
		</div>
		<div>
			<table id="blacklist_container" class="table table-warning table-borderless table-striped table-hover">
				<thead class="table-dark">
					<tr class="text-center">
						<th class="list_index text-end" scope="col">#</th>
						<th class="list_count" scope="col">피신고횟수</th>
						<th class="list_id" scope="col">ID</th>
						<th class="list_nickname" scope="col">별명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="each" varStatus="stat" begin="0" step="1" items="${black5}">
					<!-- stat.current: 현재 item 상세 // stat.index: 0부터 // stat.count: 1부터 -->
						<tr class="text-center">
							<th class="list_index text-end" scope="row">${stat.count}</th>
							<td class="list_count">${each.black_count}</td>
							<td class="list_id">${each.object_id}</td>
							<td class="list_nickname">${each.object_nickname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>






</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
