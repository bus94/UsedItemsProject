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
			<c:set var="profile_path" value="${path}/resources/img/login.png" />
		</c:when>
		<c:otherwise>
			<!-- DB에 프로필이미지가 있는 경우 -->
			<c:set var="profile_path" value="${path}/resources/img/${account_info.acc_index}/profile/${account_info.acc_profile}" />
		</c:otherwise>
	</c:choose>


	<div class="container acc_summary d-flex">
		<div id="acc_public" class="container inform">
			<div class="container d-flex">
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
				<div class="btn_box container d-flex flex-column align-items-center">
					<img id="acc_profile" class="s120"
						src="${profile_path}" alt="프로필사진">
					<c:if test="${other_info == null}">
						<button type="button" id="btn_acc_mod"
							class="btn_acc btn btn-success btn-sm"
							onclick="location.href='${path}/account/alter.do'">내 정보
							수정</button>
					</c:if>
				</div>
			</div>
			<hr>
			<div class="container d-flex">
				<div class="container info_box">
					<div class="d-flex">
						<p class="public_title container mt-3">
							<span>등</span><span>급</span>
						</p>
						<p class="public_text ms-3 mt-3">${account_info.acc_score}</p>
					</div>
					<div class="d-flex">
						<p class="public_title container">
							<span>거</span><span>래</span><span>횟</span><span>수</span>
						</p>
						<p class="public_text ms-3">${account_info.acc_count}</p>
					</div>
					<div class="black_report d-flex mb-3">
						<div class="d-flex">
							<p class="public_title container">
								<span>피</span><span>신</span><span>고</span><span>횟</span><span>수</span>
							</p>
							<p class="public_text ms-3">${account_info.acc_blackCount}</p>
						</div>

						<c:if test="${account_info.acc_id != loginMember.acc_id}">
							<!-- 보고 있는 계정정보가 내가 로그인한 아이디가 아니라면 -->
							<img class="ms-3" src="${path}/resources/img/report.png" alt="신고">
							<a
								href="${path}/blacklist/complain.do?object_id=${account_info.acc_id}">신고하기</a>
						</c:if>

					</div>
				</div>
				<div class="btn_box container d-flex flex-column align-items-center">
					<p id="acc_mock" class="">&nbsp;</p>
					<button type="button" id="btn_acc_blacklist"
						class="btn_acc btn btn-warning btn-sm"
						onclick="location.href='${path}/blacklist/complainList.do?currentPage=1&searchBlack=${account_info.acc_id}&searchType=acc_id'">신고내역
						조회</button>
				</div>
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

	<!-- ondeal인지 onsale인지 확인 -->
	<div id="acc_ondeal" class="container items_domain">
		<div class="subtitle d-flex">
			<div class="vr align-self-center"></div>
			<h4 class="container">
				<span>거</span><span>래</span><span>중</span>
			</h4>
			<div class="vr align-self-center"></div>
		</div>
		<c:if test="${empty onsaleItem}">
			<div class="item_wrapper">
				<div class="item justify-content-center">
					<p class="notice_empty">거래중인 물품이 없습니다.</p>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty onsaleItem}">
		<div class="item_wrapper">
			<c:forEach var="onsaleItem" items="${onsaleItem}">
				<div class="item_container_acc d-flex">
					<div class="item">
						<a
							href="${path}/item/itemView?item_index=${onsaleItem.item_index}"
							style="text-decoration: none; color: black"> <img
							src="${path}/resources/img/${onsaleItem.item_thumbPath}"
							alt="매물사진">
							<div class="item_view">
								<h3>${onsaleItem.item_title}</h3>
								<div class="item_price">
									<h4>${onsaleItem.item_price}원</h4>
									<br>
									<h5>
										<fmt:formatDate value="${onsaleItem.item_enrollDate}"
											pattern="yy/MM/dd" />
									</h5>
								</div>
								<div class="item_like">
									<p>관심 ${onsaleItem.item_interest}</p>
									<p>댓글 ${onsaleItem.repl_count}</p>
								</div>
								<div class="item_addr">
									<img src="${path}/resources/img/gps.png" alt="위치">
									<p>${onsaleItem.item_place}</p>
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
			</div>
		</c:if>
	</div>

	<div id="acc_selling" class="container items_domain">
		<div class="d-flex">
			<div class="subtitle d-flex">
				<div class="vr align-self-center"></div>
				<h4 class="container">
					<span>판</span><span>매</span><span>내</span><span>역</span>
				</h4>
				<div class="vr align-self-center"></div>
			</div>
			<c:if test="${other_info == null}">
				<button type="button" id="btn_item_enroll"
					class="btn_item btn btn-success btn-sm align-self-center"
					onclick="location.href='${path}/item/itemEnroll.do'">매물 등록</button>
			</c:if>
		</div>
		<c:if test="${empty dropItem}">
			<div class="item_wrapper">
				<div class="item justify-content-center">
					<p class="notice_empty">등록한 물품이 없습니다.</p>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty dropItem}">
		<div class="item_wrapper">
			<c:forEach var="dropItem" items="${dropItem}">
				<div class="item_container_acc d-flex">
					<div class="item">
						<a href="${path}/item/itemView?item_index=${dropItem.item_index}"
							style="text-decoration: none; color: black"> <img
							src="${path}/resources/img/${dropItem.item_thumbPath}" alt="매물사진">
							<div class="item_view">
								<h3>${dropItem.item_title}</h3>
								<div class="item_price">
									<h4>${dropItem.item_price}원</h4>
									<br>
									<h5>
										<fmt:formatDate value="${dropItem.item_enrollDate}"
											pattern="yy/MM/dd" />
									</h5>
								</div>
								<div class="item_like">
									<p>관심 ${dropItem.item_interest}</p>
									<p>댓글 ${dropItem.repl_count}</p>
								</div>
								<div class="item_addr">
									<img src="${path}/resources/img/gps.png" alt="위치">
									<p>${dropItem.item_place}</p>
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
			</div>
		</c:if>
	</div>


	<c:if test="${other_info == null}">
		<div id="acc_buying" class="container items_domain">
			<div class="subtitle d-flex">
				<div class="vr align-self-center"></div>
				<h4 class="container">
				<span>구</span><span>매</span><span>내</span><span>역</span>
				</h4>
				<div class="vr align-self-center"></div>
			</div>
			<c:if test="${empty buyItem}">
				<div class="item_wrapper">
					<div class="item justify-content-center">
						<p class="notice_empty">구매한 물품이 없습니다.</p>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty buyItem}">
			<div class="item_wrapper">
				<c:forEach var="buyItem" items="${buyItem}">
					<div class="item_container_acc d-flex">
						<div class="item">
							<a href="${path}/item/itemView?item_index=${buyItem.item_index}"
								style="text-decoration: none; color: black"> <img
								src="${path}/resources/img/${buyItem.item_thumbPath}" alt="매물사진">
								<div class="item_view">
									<h3>${buyItem.item_title}</h3>
									<div class="item_price">
										<h4>${buyItem.item_price}원</h4>
										<br>
										<h5>
											<fmt:formatDate value="${buyItem.item_enrollDate}" pattern="yy/MM/dd" />
										</h5>
									</div>
									<div class="item_like">
										<p>관심 ${buyItem.item_interest}</p>
										<p>댓글 ${buyItem.repl_count}</p>
									</div>
									<div class="item_addr">
										<img src="${path}/resources/img/gps.png" alt="위치">
										<p>${buyItem.item_place}</p>
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
				</div>
			</c:if>
		</div>
	</c:if>
	
	<c:if test="${other_info == null}">
		<div id="acc_interest" class="container items_domain">
			<div class="d-flex">
				<div class="subtitle d-flex">
					<div class="vr align-self-center"></div>
					<h4 class="container">
						<span>관</span><span>심</span><span>물</span><span>품</span>
					</h4>
					<div class="vr align-self-center"></div>
				</div>
				<button type="button" id="btn_item_interest"
					class="btn_item btn btn-success btn-sm align-self-center"
					onclick="location.href='${path}/item/interest.do'">자세히</button>
			</div>
			
			<c:if test="${empty my_interests}">
				<div class="item_wrapper">
					<div class="item justify-content-center">
						<p class="notice_empty">관심물품이 없습니다.</p>
					</div>
				</div>
			</c:if>
			
			<c:if test="${not empty my_interests}">
			<div class="item_wrapper">
			<c:forEach var="my_interests" items="${my_interests}">
				<div class="item_container_acc d-flex">
					<div class="item">
						<a
							href="${path}/item/itemView?item_index=${my_interests.item_index}"
							style="text-decoration: none; color: black"> <img
							src="${path}/resources/img/${my_interests.item_thumbPath}"
							alt="매물사진">
							<div class="item_view">
								<h3>${my_interests.item_title}</h3>
								<div class="item_price">
									<h4>${my_interests.item_price}원</h4>
									<br>
									<h5>
										<fmt:formatDate value="${my_interests.item_enrollDate}"
											pattern="yy/MM/dd" />
									</h5>
								</div>
								<div class="item_like">
									<p>관심 ${my_interests.item_interest}</p>
									<p>댓글 ${my_interests.repl_count}</p>
								</div>
								<div class="item_addr">
									<img src="${path}/resources/img/gps.png" alt="위치">
									<p>${my_interests.item_place}</p>
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
			</div>
			</c:if>
		</div>
	</c:if>
	
	
</section>

<script></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>