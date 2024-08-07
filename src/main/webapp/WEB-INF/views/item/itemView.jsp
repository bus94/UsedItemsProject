<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="item_detail" style="padding-top: 90px;">
	<div class="detail_content">
		<div id="carouselExampleIndicators" class="carousel slide">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="${path}/resources/img/item1.jpg" class="d-block"
						alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/item2.jpg" class="d-block"
						alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/item3.jpg" class="d-block"
						alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<div class="detail_right">
			<div class="detail_top">
				<div class="detail_info">
					<h4>${item.item_title}</h4>
					<h3>
						<fmt:formatNumber value="${item.item_price}" pattern="#,###,###원" />
					</h3>
					<p>${item.item_place}</p>
				</div>
				<div class="detail_like">
					<div class="like_txt">
						<p>관심 ${item.item_interest}</p>
						<p>조회 ${item.item_click}</p>
						<p id="enrollDate"></p>
					</div>
					<div class="detail_report">
						<img src="${path}/resources/img/report.png" alt="신고"><a
							href="${path}/blacklist/complain.do?object_id=${itemMember.acc_id}">신고하기</a>
					</div>
				</div>
			</div>
			<a href="${path}/account/acc_info.do?acc_id=${itemMember.acc_id}">
				<div class="store_profile">
					<div class="profile_img">
						<img src="${path}/resources/img/study.jpg" alt="프사">
					</div>
					<div class="profile_txt">
						<div>
							<div style="display: flex;">
								<h4>${itemMember.acc_nickname}</h4>
								<img src="${path}/resources/img/shop.png" alt="스토어"
									style="width: 20px; height: 22px; opacity: 40%; margin-left: 5px;">
							</div>
							<p>${itemMember.acc_address}</p>
						</div>
						<div style="display: flex;">
							<p>매너등급</p>
							<img src="${path}/resources/img/clover.png" alt="등급">
						</div>
					</div>
				</div>
			</a>
		</div>
	</div>
	<div class="store_content">
		<p>${item.item_content}</p>
	</div>
		<div id="comment-container">
			<div class="comment-editor" align="center">
				<form action="${path}/itemView/reply" method="post">
					<input type="hidden" name="itemNo" value="${item.item_index}" />
					<input type="hidden" name="writerId" value="${loginMember.acc_id}" />
					<textarea name="content" id="replyContent" cols="90" rows="3"></textarea>
					<button type="submit" id="btn-insert">등록</button>
				</form>
			</div>
		</div>

	<c:if test="${!empty replyList}">
		<div class="reply">
			<c:forEach var="reply" items="${replyList}">
				<div class="reply_container">
					<div style="display: flex;">
						<div class="reply_img">
							<img src="${path}/resources/img/study.jpg" alt="프사">
						</div>
						<div class="reply_txt">
							<h4>뭉지</h4>
							<p>${reply.repl_content}</p>
						</div>
					</div>
					<div class="reply_btn">
						<button onclick='btnClick()'>삭제하기</button>
						<button>채팅하기</button>
					</div>
					<div id="delete_box" class="delete_box">
						<div style="width: 85px; text-align: right; margin-top: 5px;">
							<a onclick="closeClick()" style="cursor: pointer;">X</a>
						</div>
						<div style="margin-top: 3px;">
							<input type="password" placeholder="비밀번호" size=6 maxlength=4>
							<div class="delete_btn">
								<button>삭제</button>
								<button>수정</button>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${empty replyList}">
			<tr>
				<td colspan="3" style="text-align: center;">등록된 리플이 없습니다.</td>
			</tr>
		</c:if>


	<div class="carousel-wrapper">
		<div>
			<h3 style="font-size: 22px;">판매자의 다른 상품 &gt;</h3>
		</div>
		<div class="itemView_carousel">
			<img src="${path}/resources/img/item1.jpg" alt=""> <img
				src="${path}/resources/img/item2.jpg" alt=""> <img
				src="${path}/resources/img/item3.jpg" alt=""> <img
				src="${path}/resources/img/item4.jpg" alt=""> <img
				src="${path}/resources/img/item5.jpg" alt=""> <img
				src="${path}/resources/img/item2.jpg" alt="">
		</div>
	</div>
	<div class="carousel-wrapper">
		<div>
			<h3 style="font-size: 22px;">근처 매물 &gt;</h3>
		</div>
		<div class="itemView_carousel">
			<img src="${path}/resources/img/item1.jpg" alt=""> <img
				src="${path}/resources/img/item2.jpg" alt=""> <img
				src="${path}/resources/img/item3.jpg" alt=""> <img
				src="${path}/resources/img/item4.jpg" alt=""> <img
				src="${path}/resources/img/item5.jpg" alt=""> <img
				src="${path}/resources/img/item2.jpg" alt="">
		</div>
	</div>
</section>

<script>
	function date(enrollDate) {
		const milliSeconds = new Date() - enrollDate;
		const seconds = milliSeconds / 1000;

		if (seconds < 60) {
			return document.getElementById('enrollDate').textContent = `방금 전`;
		}

		const minutes = seconds / 60
		if (minutes < 60) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(minutes)}분 전`
		}

		const hours = minutes / 60
		if (hours < 24) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(hours)}시간 전`
		}

		const days = hours / 24
		if (days < 7) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(days)}일 전`
		}

		const weeks = days / 7
		if (weeks < 5) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(weeks)}주 전`
		}

		const months = days / 30
		if (months < 12) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(months)}개월 전`
		}

		const years = days / 365
		return document.getElementById('enrollDate').textContent = `${Math.floor(years)}년 전`
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>