<%@page import="com.ss.useditems.dto.ItemInfoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<c:choose>
	<c:when test="${itemMember.acc_profile == null}">
		<!-- 판매자 DB에 프로필이미지가 null인 경우 기본이미지-->
		<c:set var="seller_profile_path"
			value="${path}/resources/img/login1.png" />
	</c:when>
	<c:otherwise>
		<!-- DB에 프로필이미지가 있는 경우 -->
		<c:set var="seller_profile_path"
			value="${path}/resources/img/${itemMember.acc_index}/profile/${itemMember.acc_profile}" />
	</c:otherwise>
</c:choose>


<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<div id="hiddenData" data-item-id="${item.item_index}"
	data-context-path="${path}" style="display: none;"></div>
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
					<img src="${path}/resources/img/${item.item_thumbPath}"
						class="d-block" alt="...">
				</div>
				<c:if test="${item.show_img1 != null}">
					<div class="carousel-item">
						<img src="${path}/resources/img/${item.item_img1Path}"
							class="d-block" alt="...">
					</div>
				</c:if>
				<c:if test="${item.show_img2 != null}">
					<div class="carousel-item">
						<img src="${path}/resources/img/${item.item_img2Path}"
							class="d-block" alt="...">
					</div>
				</c:if>
				<c:if test="${item.show_img3 != null}">
					<div class="carousel-item">
						<img src="${path}/resources/img/${item.item_img3Path}"
							class="d-block" alt="...">
					</div>
				</c:if>
				<c:if test="${item.show_img4 != null}">
					<div class="carousel-item">
						<img src="${path}/resources/img/${item.item_img4Path}"
							class="d-block" alt="...">
					</div>
				</c:if>
				<c:if test="${item.show_img5 != null}">
					<div class="carousel-item">
						<img src="${path}/resources/img/${item.item_img5Path}"
							class="d-block" alt="...">
					</div>
				</c:if>
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
			<div class="detail_top" style="padding-botton: 50px; hegight: 200px;">
				<div class="detail_info">
					<div
						style="display: flex; align-items: center; height: 30px; justify-content: space-between;">
						<h4 style="margin-bottom: 20px;">${item.item_title}</h4>
						<form id="interestForm"
							action="${path}/item/itemView/${isInterested ? 'removeInterest' : 'addInterest'}"
							method="post" style="margin-left: 10px;">
							<input type="hidden" name="acc_index"
								value="${loginMember.acc_index}"> <input type="hidden"
								name="item_index" value="${item.item_index}">
							<button type="submit"
								class="${isInterested ? 'btn-cancel-interest' : 'btn-add-interest'}"
								onclick="return confirmInterestAction('${isInterested}')">
								<span></span>
							</button>
						</form>
					</div>
					<h3>
						<fmt:formatNumber value="${item.item_price}" pattern="#,###,###원" />
					</h3>
					<div class="item_like">
						<div id="miniMapContainer"></div>
						<p>
							희망거래장소: <span id="mapPreviewText"
								style="text-decoration: underline;">${item.item_place_address}</span>
						</p>
					</div>
				</div>
				<div class="detail_like">
					<div class="like_txt">
						<p>관심 ${item.item_interest}</p>
						<p>조회 ${item.item_click}</p>
						<p id="enrollDate"></p>
					</div>
					<c:if
						test="${loginMember != null && itemMember.acc_id != loginMember.acc_id}">
						<div class="detail_report">
							<img src="${path}/resources/img/police.png" alt="신고"> <a
								href="${path}/blacklist/complain.do?object_id=${itemMember.acc_id}">신고하기</a>
						</div>
					</c:if>
				</div>
			</div>
			<a href="${path}/account/acc_info.do?acc_id=${itemMember.acc_id}">
				<div class="store_profile">
					<div class="profile_img">
						<img src="${seller_profile_path}" alt="프사">
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
		<div class="content-button">
			<c:if test="${item.item_seller==loginMember.acc_index}">
				<button type="button" onclick="editItem('${item.item_index}')">수정하기</button>
				<button type="button" onclick="deleteItem('${item.item_index}')">삭제하기</button>
			</c:if>
		</div>
	</div>
	<div id="comment-container">
		<div class="comment-editor" align="center">
			<form action="${path}/itemView/reply" method="post"
				class="commentBox">
				<input type="hidden" name="itemNo" value="${item.item_index}" /> <input
					type="hidden" name="writerId" value="${loginMember.acc_id}" />
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

						<c:choose>
							<c:when test="${reply.repl_profile == null}">
								<!-- DB에 프로필이미지가 null인 경우 기본이미지-->
								<c:set var="repl_profile_path"
									value="${path}/resources/img/login1.png" />
							</c:when>
							<c:otherwise>
								<!-- DB에 프로필이미지가 있는 경우 -->
								<c:set var="repl_profile_path"
									value="${path}/resources/img/${reply.repl_candidate}/profile/${reply.repl_profile}" />
							</c:otherwise>
						</c:choose>

						<div class="reply_img">
							<img src="${repl_profile_path}" alt="프사">
						</div>

						<div class="reply_txt">
							<h4>${reply.repl_nickname}</h4>
							<p>${reply.repl_content}</p>
						</div>
					</div>
					<div class="reply_btn">
						<c:if
							test="${reply.repl_nickname.equals(loginMember.acc_nickname)}">
							<button
								onclick="showEditForm(${reply.repl_index}, '${reply.repl_content}')">수정하기</button>
							<button
								onclick="deleteReply('${reply.repl_index}','${item.item_index}')">삭제하기</button>
						</c:if>
						<c:if
							test="${item.item_seller==loginMember.acc_index && item.item_status.equals('onsale')}">
							<button
								onclick="openChat(${item.item_index}, ${reply.repl_index})">채팅하기</button>
						</c:if>
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


	<div class="reply2">
		<c:forEach var="reply" items="${replyList}">
			<div id="edit-form-${reply.repl_index}" style="display: none;">
				<div class="reply_container2">
					<c:choose>
						<c:when test="${reply.repl_profile == null}">
							<c:set var="repl_profile_path"
								value="${path}/resources/img/login1.png" />
						</c:when>
						<c:otherwise>
							<c:set var="repl_profile_path"
								value="${path}/resources/img/${reply.repl_candidate}/profile/${reply.repl_profile}" />
						</c:otherwise>
					</c:choose>
					<form action="${path}/itemView/replyEdit" method="post"
						class="replyEditBox"
						style="width: 100%; display: flex; justify-content: space-between; align-items: center">
						<input type="hidden" name="itemNo" value="${item.item_index}" />
						<input type="hidden" name="replyNo" value="${reply.repl_index}" />
						<div style="display: flex">
							<div class="reply_img">
								<img src="${repl_profile_path}" alt="프사">
							</div>
							<div class="reply_txt">
								<h4>${reply.repl_nickname}</h4>
								<textarea name="content" rows="3" cols="50">${reply.repl_content}</textarea>
							</div>
						</div>
						<div id="edit-form-${reply.repl_index}">
							<div class="reply_btn" style="align-items: center">
								<button type="submit">수정 완료</button>
								<button type="button"
									onclick="hideEditForm(${reply.repl_index})">취소</button>
							</div>
						</div>

					</form>
				</div>
			</div>
		</c:forEach>
	</div>




	<div class="carousel-wrapper">
		<div>
			<h3 style="font-size: 22px;">판매자의 다른 상품</h3>
		</div>
		<c:if test="${empty otherItemList}">
			<tr>
				<td colspan="6">현재 판매하는 다른 상품이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty otherItemList}">
			<div class="item_wrapper">
				<c:forEach var="item" items="${otherItemList}">
					<div class="item_container">
						<div class="item">
							<a href="${path}/item/itemView?item_index=${item.item_index}"
								style="text-decoration: none; color: black"> <img
								src="${path}/resources/img/${item.item_thumbPath}" alt="매물사진">
								<div class="item_view">
									<h3>${item.item_title}</h3>
									<div class="item_price">
										<h4>
											<fmt:formatNumber value="${item.item_price}" type="number"
												groupingUsed="true" />
											원
										</h4>
										<br>
									</div>
									<div class="item_like">
										<p>관심 ${item.item_interest}</p>
										<p>댓글 ${item.repl_count}</p>
									</div>
									<div class="item_addr"
										style="display: flex; justify-content: space-between;">
										<div style="display: flex">
											<img src="${path}/resources/img/gps.png" alt="위치">
											<p>${item.item_place}</p>
										</div>
										<div>
											<h5>
												<fmt:formatDate value="${item.item_enrollDate}"
													pattern="yy/MM/dd" />
											</h5>
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 지도 모달 -->
			<div class="modal fade" id="mapModal" tabindex="-1"
				aria-labelledby="mapModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="mapModalLabel">위치 보기</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" id="mapModalBody"
							style="width: 100%; height: 500px;">
							<!-- 큰 지도가 여기에 렌더링됩니다 -->
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</section>
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a41a4466a946b1b4af605da49e598032&libraries=services"></script>

<script>
const placeX = ${item.item_placeX};
const placeY = ${item.item_placeY};
console.log(placeX);
console.log(placeY);
</script>
<script>
	const item_enrollDateStr = "${item.item_enrollDate}"; 
	const item_enrollDate = new Date(item_enrollDateStr);

	function date(enrollDate) {
		console.log("날짜 계산 시작");
		console.log("item_enrollDateStr: " + item_enrollDateStr); // Fri Jul 26 11:10:30 KST 2024
		console.log("item_enrollDate: " + item_enrollDate); // Invalid Date
		console.log("new Date: " + new Date()); // Mon Aug 19 2024 03:06:29 GMT+0900 (한국 표준시)
		const milliSeconds = new Date() - enrollDate;
		console.log("milliSeconds: " + milliSeconds);
		const seconds = milliSeconds / 1000;
		console.log("seconds: " + seconds);

		if (seconds < 60) {
			return document.getElementById('enrollDate').textContent = `방금 전`;
		}

		const minutes = seconds / 60;
		console.log("minutes: " + minutes);
		if (minutes < 60) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(minutes)}분 전`;
		}

		const hours = minutes / 60;
		console.log("hours: " + hours);
		if (hours < 24) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(hours)}시간 전`;
		}

		const days = hours / 24;
		console.log("days: " + days);
		if (days < 7) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(days)}일 전`;
		}

		const weeks = days / 7;
		console.log("weeks: " + weeks)
		if (weeks < 5) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(weeks)}주 전`;
		}

		const months = days / 30;
		console.log("months: " + months);
		if (months < 12) {
			return document.getElementById('enrollDate').textContent = `${Math.floor(months)}개월 전`;
		}

		const years = days / 365;
		console.log("years: " + years);
		console.log("Math.floor(years): " + Math.floor(years));
		return document.getElementById('enrollDate').textContent = `${Math.floor(years)}년 전`;
	}
	
	date(item_enrollDate);
</script>

<script>

	function deleteReply(replyNo, itemNo) {
		var url = "${path}/itemView/replyDel?replyNo=";
		var requestURL = url + replyNo + "&itemNo=" + itemNo;
		console.log(requestURL);
		location.href = requestURL;
	}

</script>

<script>
    function showEditForm(replyIndex, currentContent) {
        document.getElementById('edit-form-' + replyIndex).style.display = 'block';
        document.getElementById('reply-content-' + replyIndex).style.display = 'none';
    }

    function hideEditForm(replyIndex) {
        document.getElementById('edit-form-' + replyIndex).style.display = 'none';
        document.getElementById('reply-content-' + replyIndex).style.display = 'block';
    }
    
</script>

<script>
	function confirmInterestAction(isInterested) {
	    if (isInterested === 'true') {
	        return confirm("관심 상품에서 삭제하시겠습니까?");
	    }
	    return true;
	}
</script>
<script>
	function deleteItem(itemNo) {
		if (confirm("정말 삭제하시겠습니까?")) {
			var url = "${path}/itemView/itemDel.do?&item_index=" + item_index;
			console.log(url);
			location.href = url;
		}
		
	}
</script>
<script>
	function editItem(item_index){F
		var url ="${path}/item/itemEdit.do?item_index="+item_index;
		location.href=url;
	}
</script>

<script>
	document.addEventListener('DOMContentLoaded', () => {
	    const mapPreviewText = document.getElementById('mapPreviewText');
	    const miniMapContainer = document.getElementById('miniMapContainer');
	    const placeX = parseFloat("${item.item_placeX}");
	    const placeY = parseFloat("${item.item_placeY}");
	
	    // 미니맵 초기화
	    const miniMapOption = {
	        center: new kakao.maps.LatLng(placeX, placeY),
	        draggable: false,
	         
	        level: 3
	    };
	    
	  
	    
	    const miniMap = new kakao.maps.Map(miniMapContainer, miniMapOption);
	    const miniMarker = new kakao.maps.Marker({
	        position: new kakao.maps.LatLng(placeX, placeY),
	        map: miniMap
	    });
	
	    mapPreviewText.addEventListener('mousemove', (event) => {
	        const rect = mapPreviewText.getBoundingClientRect();
	        const mouseX = event.clientX;
	        const mouseY = event.clientY;
	
	        // 마우스가 텍스트 영역 내에 있는지 확인
	        if (mouseX >= rect.left && mouseX <= rect.right && mouseY >= rect.top && mouseY <= rect.bottom) {
	            miniMapContainer.style.display = 'block';
	            miniMapContainer.style.top = (mouseY + 10) + 'px';
	            miniMapContainer.style.left = (mouseX + 10) + 'px';
	
	            // 지도가 올바르게 표시되도록 relayout 호출
	            setTimeout(() => {
	                miniMap.relayout();
	                miniMap.setCenter(new kakao.maps.LatLng(placeX, placeY));
	            }, 0);
	        } else {
	            miniMapContainer.style.display = 'none';
	        }
	    });
	    
	    mapPreviewText.addEventListener('mouseleave', () => {
	        miniMapContainer.style.display = 'none';
	    });
	    
	    // 텍스트를 클릭했을 때 모달에 큰 지도 표시
	    mapPreviewText.addEventListener('click', () => {
	        const modal = new bootstrap.Modal(document.getElementById('mapModal'));
	        modal.show();

	        const mapContainer = document.getElementById('mapModalBody');
	        const mapOption = {
	            center: new kakao.maps.LatLng(placeX, placeY),
	            level: 3
	        };
	        const map = new kakao.maps.Map(mapContainer, mapOption);
	        const marker = new kakao.maps.Marker({
	            position: new kakao.maps.LatLng(placeX, placeY),
	            map: map
	        });
	    
	        setTimeout(() => {
	            map.relayout();
	            map.setCenter(new kakao.maps.LatLng(placeX, placeY));
	        }, 500);
	    });
	});
</script>

<script src="${path}/resources/js/item/itemView.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>