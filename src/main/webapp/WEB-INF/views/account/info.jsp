<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container acc_info_page" style="padding-top: 100px;">


	<c:choose>
		<c:when test="${other_info == null}">
			<!-- 마이페이지를 누른 경우 -->
			<c:set var="account_info" value="${loginMember}" />
		</c:when>
		<c:otherwise>
			<!-- 다른사람 정보를 누른 경우 -->
			<c:set var="account_info" value="${other_info}" />
		</c:otherwise>
	</c:choose>


	<c:choose>
		<c:when test="${account_info.acc_profile == null}">
			<!-- DB에 프로필이미지가 null인 경우 기본이미지-->
			<c:set var="profile_path" value="${path}/resources/img/login1.png" />
		</c:when>
		<c:otherwise>
			<!-- DB에 프로필이미지가 있는 경우 -->
			<c:set var="profile_path" value="${path}/resources/img/${account_info.acc_index}/profile/${account_info.acc_profile}" />
		</c:otherwise>
	</c:choose>


	<div id="acc_summary" class="container">
		<div id="acc_public" class="acc_inform">
			<div class="top_container">
				<div class="container info_box">
					<div class="d-flex">
						<p class="public_title container mt-3">
							<span>아</span><span>이</span><span>디</span>
						</p>
						<p class="public_text ms-3 mt-3">${account_info.acc_id}</p>
					</div>
					<div class="d-flex">
						<p class="public_title container">
							<span>별</span><span>명</span>
						</p>
						<p class="public_text ms-3">${account_info.acc_nickname}</p>
					</div>
					<div class="d-flex">
						<p class="public_title container">
							<span>주</span><span>소</span>
						</p>
						<p class="public_text ms-3">${account_info.acc_address}</p>
					</div>
				</div>
				<div class="btn_boxContainer">
					<img id="acc_profile" class="s120"
						src="${profile_path}" alt="프로필사진">
					<c:if test="${other_info == null}">
						<button type="button" id="btn_acc_mod"
							class="btn_acc btn btn-success btn-sm" style="margin-top:5px;"
							onclick="location.href='${path}/account/alter.do'">내 정보
							수정</button>
					</c:if>
				</div>
			</div>
			<hr id="acc_hr">
			<div class="bottom_container">
				<div class="bottom_info_box">
					<div class="acc_level">
						<div>
							<p class="public_title container">
								<span>매</span><span>너</span><span>등</span><span>급</span>
							</p>
						<img src="${path}/resources/img/level${account_info.acc_level}.png" alt="등급">
						</div>
					</div>
					<div>
						<p class="public_title container">
							<span>거</span><span>래</span><span>횟</span><span>수</span>
						</p>
						<p class="public_text">${account_info.acc_count}</p>
					</div>
					<div class="black_report">
						<div>
							<p class="public_title container">
								<span>누</span><span>적</span><span>신</span><span>고</span>
							</p>
							<p class="public_text">${account_info.acc_blackCount}</p>
						</div>

						<%-- <c:if test="${account_info.acc_id != loginMember.acc_id}">
							<!-- 보고 있는 계정정보가 내가 로그인한 아이디가 아니라면 -->
							<img class="ms-3" src="${path}/resources/img/police.png" alt="신고">
							<a
								href="${path}/blacklist/complain.do?object_id=${account_info.acc_id}">신고하기</a>
						</c:if> --%>

					</div>
				</div>
				<%-- <div class="btn_box container d-flex flex-column align-items-center">
					<p id="acc_mock" class="">&nbsp;</p>
					<button type="button" id="btn_acc_blacklist"
						class="btn_acc btn btn-warning btn-sm"
						onclick="location.href='${path}/blacklist/complainList.do?currentPage=1&searchBlack=${account_info.acc_id}&searchType=acc_id'">신고내역
						조회</button>
				</div> --%>
			</div>
		</div>
		<!-- 수입지출내역 -->
		<%-- <c:if test="${other_info == null}">
			<div id="acc_profit" class="container inform">
				<h3 class="text-center">수입 지출 내역</h3>
				<div class="d-flex align-items-end flex-column">
					<div class="input-group input-group-sm w-100" id="period">
						<select class="form-select" id="inputGroupSelect04"
							aria-label="Example select with button addon">
							<option selected>이번달</option>
							<option value="1">3개월</option>
							<option value="2">6개월</option>
							<option value="3">1년</option>
							<option value="4">기간 설정</option>
						</select>
						<button class="btn btn-outline-secondary" type="button">조회</button>
					</div>
				</div>
				<hr>
				<div class="d-flex justify-content-between">
					<p>&nbsp;&nbsp;&nbsp;&nbsp;판매 금액(2건) :</p>
					<p>100,000원</p>
				</div>
				<div class="d-flex justify-content-between">
					<p>(-) 구매 금액(1건) :</p>
					<p>35,000원</p>
				</div>
				<hr>
				<div class="d-flex justify-content-between">
					<p>(=) 수익 금액 :</p>
					<p>65,000원</p>
				</div>
			</div>
		</c:if> --%>
		
	</div>
	
	
	<!-- 새거 -->
	<!-- ONDEAL 거래중 -->
	<div id="acc_ondeal" class="carousel-wrapper">
		<div class="subtitle d-flex mb-1">
			<div class="vr align-self-center"></div>
			<h4 class="container">
				<span>거</span><span>래</span><span>중</span>
			</h4>
			<div class="vr align-self-center"></div>
		</div>
		<c:if test="${empty ondealItem}">
			<div class="item_empty_wrapper">
				<div class="item_info_empty">
					<p class="notice_empty txt_long text-center">거래중인 물품이 없습니다</p>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty ondealItem}">
			<div class="newItem_wrap">
				<div class="item_slick_container">
					<div id="slick_carousel_ondeal" class="slick_carousel">
						<c:forEach var="ondealItem" items="${ondealItem}">
							<div class="item_ondeal item_info">
								<a href="${path}/item/itemView?item_index=${ondealItem.item_index}"
									style="text-decoration: none; color: black"> <img
									src="${path}/resources/img/${ondealItem.item_thumbPath}" alt="..">
									<div class="item_view2">
										<h3>${ondealItem.item_title}</h3>
										<div class="item_price">
											<h4>
												<fmt:formatNumber value="${ondealItem.item_price}" type="number"
													groupingUsed="true" />
												원
											</h4>

										</div>
										<div class="item_like">
											<p>관심 ${ondealItem.item_interest}</p>
											<p>댓글 ${ondealItem.repl_count}</p>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	
	<!-- ONSALE 판매중 -->
	<div id="acc_onsale" class="carousel-wrapper">
		<div class="subtitle d-flex mb-1">
			<div class="vr align-self-center"></div>
			<h4 class="container">
				<span>판</span><span>매</span><span>중</span>
			</h4>
			<div class="vr align-self-center"></div>
		</div>
		<c:if test="${empty onsaleItem}">
				<div class="item_info_empty">
					<p class="notice_empty txt_long text-center">판매중인 물품이 없습니다</p>
				</div>
		</c:if>
		<c:if test="${not empty onsaleItem}">
			<div class="newItem_wrap">
				<div class="item_slick_container">
					<div id="slick_carousel_onsale" class="slick_carousel">
						<c:forEach var="onsaleItem" items="${onsaleItem}">
							<div class="item_onsale item_info">
								<a href="${path}/item/itemView?item_index=${onsaleItem.item_index}"
									style="text-decoration: none; color: black"> <img
									src="${path}/resources/img/${onsaleItem.item_thumbPath}" alt="..">
									<div class="item_view2">
										<h3>${onsaleItem.item_title}</h3>
										<div class="item_price">
											<h4>
												<fmt:formatNumber value="${onsaleItem.item_price}" type="number"
													groupingUsed="true" />
												원
											</h4>

										</div>
										<div class="item_like">
											<p>관심 ${onsaleItem.item_interest}</p>
											<p>댓글 ${onsaleItem.repl_count}</p>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	
	<!-- SOLD 판매내역 -->
	<div id="acc_sold" class="carousel-wrapper">
		<div class="subtitle d-flex mb-1">
			<div class="vr align-self-center"></div>
			<h4 class="container">
				<span>판</span><span>매</span><span>내</span><span>역</span>
			</h4>
			<div class="vr align-self-center"></div>
		</div>
		<c:if test="${empty soldItem}">
			<div class="item_empty_wrapper">
				<div class="item_info_empty">
					<p class="notice_empty text-center">등록한 물품이 없습니다</p>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty soldItem}">
			<div class="newItem_wrap">
				<div class="item_slick_container">
					<div id="slick_carousel_sold" class="slick_carousel">
						<c:forEach var="soldItem" items="${soldItem}">
							<div class="item_sold item_info">
								<a href="${path}/item/itemView?item_index=${soldItem.item_index}"
									style="text-decoration: none; color: black"> <img
									src="${path}/resources/img/${soldItem.item_thumbPath}" alt="..">
									<div class="item_view2">
										<h3>${soldItem.item_title}</h3>
										<div class="item_price">
											<h4>
												<fmt:formatNumber value="${soldItem.item_price}" type="number"
													groupingUsed="true" />
												원
											</h4>

										</div>
										<div class="item_like">
											<p>관심 ${soldItem.item_interest}</p>
											<p>댓글 ${soldItem.repl_count}</p>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	
	<!-- BOUGHT 구매내역 -->
	<c:if test="${other_info == null}">
	<div id="acc_bought" class="carousel-wrapper">
		<div class="subtitle d-flex mb-1">
			<div class="vr align-self-center"></div>
			<h4 class="container">
				<span>구</span><span>매</span><span>내</span><span>역</span>
			</h4>
			<div class="vr align-self-center"></div>
		</div>
		<c:if test="${empty boughtItem}">
			<div class="item_empty_wrapper">
				<div class="item_info_empty">
					<p class="notice_empty text-center">구매한 물품이 없습니다</p>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty boughtItem}">
			<div class="newItem_wrap">
				<div class="item_slick_container">
					<div id="slick_carousel_bought" class="slick_carousel">
						<c:forEach var="boughtItem" items="${boughtItem}">
							<div class="item_bought item_info">
								<a href="${path}/item/itemView?item_index=${boughtItem.item_index}"
									style="text-decoration: none; color: black"> <img
									src="${path}/resources/img/${boughtItem.item_thumbPath}" alt="..">
									<div class="item_view2">
										<h3>${boughtItem.item_title}</h3>
										<div class="item_price">
											<h4>
												<fmt:formatNumber value="${boughtItem.item_price}" type="number"
													groupingUsed="true" />
												원
											</h4>

										</div>
										<div class="item_like">
											<p>관심 ${boughtItem.item_interest}</p>
											<p>댓글 ${boughtItem.repl_count}</p>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	</c:if>
	
	
	<!-- INTERESTS 관심물품 -->
	<c:if test="${other_info == null}">
	<div id="acc_interest" class="carousel-wrapper">
		<div class="subtitle d-flex mb-1">
			<div class="vr align-self-center"></div>
			<h4 class="container">
				<span>관</span><span>심</span><span>물</span><span>품</span>
			</h4>
			<div class="vr align-self-center"></div>
		</div>
		<c:if test="${empty my_interests}">
			<div class="item_empty_wrapper">
				<div class="item_info_empty">
					<p class="notice_empty text-center">관심물품이 없습니다</p>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty my_interests}">
			<div class="newItem_wrap">
				<div class="item_slick_container">
					<div id="slick_carousel_interests" class="slick_carousel">
						<c:forEach var="my_interests" items="${my_interests}">
							<div class="item_interests item_info">
								<a href="${path}/item/itemView?item_index=${my_interests.item_index}"
									style="text-decoration: none; color: black"> <img
									src="${path}/resources/img/${my_interests.item_thumbPath}" alt="..">
									<div class="item_view2">
										<h3>${my_interests.item_title}</h3>
										<div class="item_price">
											<h4>
												<fmt:formatNumber value="${my_interests.item_price}" type="number"
													groupingUsed="true" />
												원
											</h4>

										</div>
										<div class="item_like">
											<p>관심 ${my_interests.item_interest}</p>
											<p>댓글 ${my_interests.repl_count}</p>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	</c:if>
	
</section>

<script>
var itemCount4 = $('#slick_carousel_ondeal .item_ondeal').length;
var itemCount5 = $('#slick_carousel_onsale .item_onsale').length;
var itemCount6 = $('#slick_carousel_sold .item_sold').length;
var itemCount7 = $('#slick_carousel_bought .item_bought').length;
var itemCount8 = $('#slick_carousel_interests .item_interests').length;



 if (itemCount4 > 5) {
	console.log("5 초과 itemCount: " + itemCount4);
    $('#slick_carousel_ondeal').slick({
        dots: false,
        infinite: true,
        arrows: true,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false
    });
} else {
	console.log("5 이하 itemCount: " + itemCount4);
    $('#slick_carousel_ondeal').css({
        'overflow': 'hidden',
        'width': 'auto',
        'justify-content': 'flex-start'
    }),
    $('.item_ondeal').css({
    	'border' : '1px solid lightgray',
    	'width' : '190px' 
    }),
    $('#slick_carousel_ondeal:first-child').css({
    	'margin-left' : '8px' 
    })
}

if (itemCount5 > 5) {
	console.log("5 초과 itemCount: " + itemCount5);
    $('#slick_carousel_onsale').slick({
        dots: false,
        infinite: true,
        arrows: true,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false
    });
} else {
	console.log("5 이하 itemCount: " + itemCount5);
    $('#slick_carousel_onsale').css({
        'overflow': 'hidden',
        'width': 'auto',
        'justify-content': 'flex-start'
    }),
    $('.item_onsale').css({
    	'border' : '1px solid lightgray',
    	'width' : '190px'
    }),
    $('#slick_carousel_onsale:first-child').css({
    	'margin-left' : '8px' 
    })
}

if (itemCount6 > 5) {
	console.log("5 초과 itemCount: " + itemCount6);
    $('#slick_carousel_sold').slick({
        dots: false,
        infinite: true,
        arrows: true,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false
    });
} else {
	console.log("5 이하 itemCount: " + itemCount6);
    $('#slick_carousel_sold').css({
        'overflow': 'hidden',
        'width': 'auto',
        'justify-content': 'flex-start'
    }),
    $('.item_sold').css({
    	'border' : '1px solid lightgray',
    	'width' : '190px'
    }),
    $('#slick_carousel_sold:first-child').css({
    	'margin-left' : '8px' 
    })
} 

if (itemCount7 > 5) {
	console.log("5 초과 itemCount: " + itemCount7);
    $('#slick_carousel_bought').slick({
        dots: false,
        infinite: true,
        arrows: true,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false
    });
} else {
	console.log("5 이하 itemCount: " + itemCount7);
    $('#slick_carousel_bought').css({
        'overflow': 'hidden',
        'width': 'auto',
        'justify-content': 'flex-start'
    }),
    $('.item_bought').css({
    	'border' : '1px solid lightgray',
    	'width' : '190px'
    }),
    $('#slick_carousel_bought:first-child').css({
    	'margin-left' : '8px' 
    })
} 

if (itemCount8 > 5) {
	console.log("5 초과 itemCount: " + itemCount8);
    $('#slick_carousel_interests').slick({
        dots: false,
        infinite: true,
        arrows: true,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false
    });
} else {
	console.log("5 이하 itemCount: " + itemCount8);
    $('#slick_carousel_interests').css({
        'overflow': 'hidden',
        'width': 'auto',
        'justify-content': 'flex-start'
    }),
    $('.item_interests').css({
    	'border' : '1px solid lightgray',
    	'width' : '190px'
    }),
    $('#slick_carousel_interests:first-child').css({
    	'margin-left' : '8px' 
    })
} 

/* for (i = 3; i <= 7; i++) {

if(`itemCount${i}` > 5) {
	console.log("5 초과 itemCount: " + `itemCount${i}`);
    $(`#newItem_container${i}`).slick({
        dots: false,
        infinite: true,
        arrows: true,
        speed: 500,
        slidesToShow: 5,
        slidesToScroll: 1,
        autoplay: false
    });
} else {
	console.log("5 이하 itemCount: " + `itemCount${i}`);
    $(`#newItem_container${i}`).css({
        'overflow': 'hidden',
        'width': 'auto',
        'justify-content': 'flex-start'
    }),
    $(`#item${i}`).css({
    	'border' : '1px solid lightgray'    	
    })
}

} */




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>