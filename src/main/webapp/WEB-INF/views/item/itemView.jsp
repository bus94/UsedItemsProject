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
					<img src="${path}/resources/img/item1.jpg" class="d-block" alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/item2.jpg"class="d-block" alt="...">
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/img/item3.jpg" class="d-block" alt="...">
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
					<h3><fmt:formatNumber value="${item.item_price}" pattern="#,###,###원" /></h3>
					<p>${item.item_place}</p>
				</div>
				<div class="detail_like">
					<div class="like_txt">
						<p>관심 ${item.item_interest}</p>
						<p>조회 ${item.item_click}</p>
						<p>20분전</p>
					</div>
					<div class="detail_report">
						<img src="${path}/resources/img/report.png" alt="신고"><a href="#">신고하기</a>
					</div>
				</div>
			</div>
			<div class="store_profile">
				<div class="profile_img">
					<img src="${path}/resources/img/study.jpg" alt="프사">
				</div>
				<div class="profile_txt">
					<div>
						<div style="display: flex;">
							<h4>뭉지</h4>
							<img src="${path}/resources/img/shop.png" alt="스토어"
								style="width: 20px; height: 22px; opacity: 40%; margin-left: 5px;">
						</div>
						<p>서울시 강남구 테헤란로 엔데버타워</p>
					</div>
					<div style="display: flex;">
						<p>매너등급</p>
						<img src="${path}/resources/img/clover.png" alt="등급">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="store_content">
		<p>
			요즘 유행하는 두바이초콜릿 팝니다<br> 3개 있고 직거래만 합니다. 많은 문의 바람<br> 네고. 사절.
			합니다 네고. 사절. 합니다 네고. 사절. 합니다 네고. 사절. 합니다 네고. 사절. 합니다네고. 사절. 합니다네고. 사절.
			합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절.
			합니다네고.네고. 사절. 합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절. 합니다네고. 사절.
			합니다네고. 사절. 합니다 사절. 합니다
		</p>
	</div>
	<div class="reply">
		<div class="reply_img">
			<img src="${path}/resources/img/study.jpg" alt="프사">
		</div>
		<div class="reply_container">
			<div class="reply_txt">
				<h4>뭉지</h4>
				<p>너무 비싸요~~ 양심이 있으신가요?</p>
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
	</div>
	<div class="reply">
		<div class="reply_img">
			<img src="${path}/resources/img/study.jpg" alt="프사">
		</div>
		<div class="reply_container">
			<div class="reply_txt">
				<h4>쌍용다람쥐</h4>
				<p>사고싶어요</p>
			</div>
			<div class="reply_btn">
				<button>삭제하기</button>
				<button>채팅하기</button>
			</div>
		</div>
	</div>
	<div class="carousel-wrapper">
		<div>
			<h3 style="font-size: 22px;">판매자의 다른 상품 &gt;</h3>
		</div>
		<div class="itemView_carousel">
			<img src="${path}/resources/img/item1.jpg" alt=""> <img src="${path}/resources/img/item2.jpg" alt="">
			<img src="${path}/resources/img/item3.jpg" alt=""> <img src="${path}/resources/img/item4.jpg" alt="">
			<img src="${path}/resources/img/item5.jpg" alt=""> <img src="${path}/resources/img/item2.jpg" alt="">
		</div>
	</div>
	<div class="carousel-wrapper">
		<div>
			<h3 style="font-size: 22px;">근처 매물 &gt;</h3>
		</div>
		<div class="itemView_carousel">
			<img src="${path}/resources/img/item1.jpg" alt=""> <img src="${path}/resources/img/item2.jpg" alt="">
			<img src="${path}/resources/img/item3.jpg" alt=""> <img src="${path}/resources/img/item4.jpg" alt="">
			<img src="${path}/resources/img/item5.jpg" alt=""> <img src="${path}/resources/img/item2.jpg" alt="">
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>