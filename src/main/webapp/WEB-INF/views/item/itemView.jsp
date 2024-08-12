<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

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
			<div class="detail_top">
				<div class="detail_info">
					<h4>${item.item_title}</h4>
					<form action="${path}/item/itemView/addInterest" method="post">
						<input type="hidden" name="acc_index"
							value="${loginMember.acc_index}"> <input type="hidden"
							name="item_index" value="${item.item_index}">
						<button type="submit">관심</button>
					</form>
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
					<c:if
						test="${loginMember != null && itemMember.acc_id != loginMember.acc_id}">
						<div class="detail_report">
							<img src="${path}/resources/img/report.png" alt="신고"> <a
								href="${path}/blacklist/complain.do?object_id=${itemMember.acc_id}">신고하기</a>
						</div>
					</c:if>
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
						<div class="reply_img">
							<img src="${path}/resources/img/study.jpg" alt="프사">
						</div>
						<div class="reply_txt">
							<h4>${reply.repl_nickname}</h4>
							<p>${reply.repl_content}</p>
						</div>
					</div>
					<div class="reply_btn">
						<%-- <c:if test="${loginMember != null && reply.repl_candidate == loginMember.acc_index}"> --%>
						<button
							onclick="showEditForm(${reply.repl_index}, '${reply.repl_content}')">수정하기</button>
						<button
							onclick="deleteReply('${reply.repl_index}','${item.item_index}')">삭제하기</button>
						<button>채팅하기</button>
					</div>
				</div>
				<!-- 수정 폼 -->
				<div id="edit-form-${reply.repl_index}" style="display: none;">
					<form action="${path}/itemView/replyEdit" method="post">
						<input type="hidden" name="itemNo" value="${item.item_index}" />
						<input type="hidden" name="replyNo" value="${reply.repl_index}" />
						<textarea name="content" rows="3">${reply.repl_content}</textarea>
						<button type="submit">수정 완료</button>
						<button type="button" onclick="hideEditForm(${reply.repl_index})">취소</button>
					</form>
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
										<h4>${item.item_price}원</h4>
										<br>
										<h5>
											<fmt:formatDate value="${item.item_enrollDate}"
												pattern="yy/MM/dd" />
										</h5>
									</div>
									<div class="item_like">
										<p>관심 ${item.item_interest}</p>
										<p>댓글 ${item.repl_count}</p>
									</div>
									<div class="item_addr">
										<img src="${path}/resources/img/gps.png" alt="위치">
										<p>${item.item_place}</p>
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
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
<!-- <script>
function addInterest(accIndex, itemIndex) {
 
    var url = `${path}/itemView/addInterest`;
	console.log(url);
    
    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json' 
        },
        body: JSON.stringify({ 
            acc_index: accIndex,
            item_index: itemIndex
        })
    })
    .then(response => response.text()) 
    .then(data => {
        if (data === "Success") {
            alert("관심에 추가되었습니다.");
        } else {
            alert("관심 추가에 실패했습니다. 다시 시도해주세요.");
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("서버와의 통신 중 오류가 발생했습니다.");
    });
}

</script> -->



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>