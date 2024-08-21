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
			<div class="detail_top" style="hegight: 200px;">
				<div class="detail_info">
					<div
						style="display: flex; align-items: center;justify-content: space-between;">
						<h4 style="font-size:25px;">${item.item_title}</h4>
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
					<h3 style="font-size:30px;">
						<fmt:formatNumber value="${item.item_price}" pattern="#,###,###원" />
					</h3>
					<div class="item_like">
						<div id="miniMapContainer"></div>
						<p class="address_txt">
							희망거래장소: <span id="mapPreviewText"
								style="text-decoration: underline;">${item.item_place_name}</span>
						</p>
					</div>
				</div>
				<div class="detail_like">
					<div class="like_txt">
						<p>관심 ${item.item_interest}</p>
						<p>조회 ${item.item_click}</p>
					</div>
					<c:if
						test="${loginMember != null && itemMember.acc_id != loginMember.acc_id}">
						<div class="detail_report">
							 <a href="${path}/blacklist/complain.do?object_id=${itemMember.acc_id}">
							 <img src="${path}/resources/img/police.png" alt="신고" style="margin-bottom: 7px; margin-right: 3px">신고하기</a>
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
									style="width: 22px; height: 22px; opacity: 40%; margin-left: 5px;">
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
							test="${item.item_seller==loginMember.acc_index && reply.repl_candidate!=item.item_seller && item.item_status.equals('onsale')}">
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
			<td colspan="3" style="text-align: center; ">등록된 리플이 없습니다.</td>
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
			<div class="newItem_wrap">
				<div class="otherItem_container">
					<div class="newItem_container2">
						<c:forEach var="each" items="${otherItemList}">
							<div class="item3">
								<a href="${path}/item/itemView?item_index=${each.item_index}"
									style="text-decoration: none; color: black"> <img
									src="${path}/resources/img/${each.item_thumbPath}" alt="..">
									<div class="item_view2">
										<h3>${each.item_title}</h3>
										<div class="item_price">
											<h4>
												<fmt:formatNumber value="${each.item_price}" type="number"
													groupingUsed="true" />
												원
											</h4>

										</div>
										<div class="item_like">
											<p>관심 ${each.item_interest}</p>
											<p>댓글 ${each.repl_count}</p>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
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

<script>
const placeX = ${item.item_placeX};
const placeY = ${item.item_placeY};
console.log(placeX);
console.log(placeY);
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
	function editItem(item_index){
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