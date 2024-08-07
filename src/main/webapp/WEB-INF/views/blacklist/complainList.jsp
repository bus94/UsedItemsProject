<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<c:set var="searchType" value="${param.searchType}" />
<c:set var="subject_id" value="${param.subject_id}" />
<!-- c:set을 안해주면 직접 param에서 값을 불러오면 됨, ex) searchBlack -->

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container blacklist_page">


	<div class="whole-container container d-flex flex-column align-items-center">
		
		<div id="blacklist_title_container" class="container d-flex flex-column align-items-center">
			<p id="main_title" class="fs-1"><span id="safeMarket">Safe Market</span>에 신고가 등록되었어요</p>
			<p id="sub_title" class="fs-5">다음 사용자와 거래할 때는 주의가 필요해요</p>
			<p id="sub_title" class="fs-5">안전한 거래를 위해 빈번한 신고 내역을 미리 확인하세요!</p>
		</div>

		<form action="${path}/blacklist/complainList.do" method="get">

			<input type="hidden" name="currentPage" value="1">

			<div class="search_box container d-flex flex-column align-items-center ">
				
				<div class="input-group">
					<input type="text" class="form-control border border-warning focus-ring focus-ring-warning" id="searchBlack"
						name="searchBlack" value="${param.searchBlack}">
					<button id="search_btn" class="btn btn-outline-warning d-flex align-items-center justify-content-center" type="submit">
						<img id="search_img" alt="검색" src="${path}/resources/img/search.png">
					</button>
				</div>
				
				<div class="container d-flex justify-content-center mt-2 mb-2">
				<input type="radio" name="searchType" id="acc_nickname" 
					value="acc_nickname" ${searchType=='acc_nickname' ? 'checked':''} required/>
				<label class="radio_type" for="acc_nickname">별명</label> 
				<input type="radio"	name="searchType" id="acc_id" 
					value="acc_id" ${searchType=='acc_id' ? 'checked':''} required/> 
				<label class="radio_type" for="acc_id">아이디</label>
				<input type="radio" name="searchType" id="content" 
					value="content"	${searchType=='content' ? 'checked':''}required/>
				<label class="radio_type" for="내용">내용</label>
				</div>
				
			</div>
		</form>

		<table id="blacklist_container" class="table table-warning table-borderless table-striped table-hover">
			<thead class="table-dark">
				<tr class="text-center">
					<th class="list_index text-end" scope="col">#</th>
					<th class="list_id" scope="col">누구를</th>
					<th class="list_content" scope="col">내용</th>
					<c:if test="${loginMember.acc_status=='admin'}">
					<th class="list_id" scope="col">누가</th>
					</c:if>
					<th class="list_date" scope="col">언제</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty blacklist}">
					<tr>
						<td colspan="5" class="text-center">조회된 글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty blacklist}">
					<c:forEach var="each" items="${blacklist}">
						<tr class="text-center">
							<th class="list_index text-end" scope="row">${each.black_index}</th>
							<td class="list_id">${each.object_id}</td>
							<td class="list_content text-start ps-3">
								<c:if test="${loginMember.acc_id==each.subject_id||loginMember.acc_status=='admin'}">
									<a href="" id="del_black">&lt;삭제&gt;</a>
								</c:if>
								<span>${each.black_content}</span>
							</td>
							
							<c:if test="${loginMember.acc_status=='admin'}">
							<td class="list_id">${each.subject_id}</td>
							</c:if>
							
							<td class="list_date"><fmt:formatDate type="date"	value="${each.black_enrollDate}" /></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>

		<!-- 페이징 -->
		<div align="center" class="pagination_container container d-flex justify-content-center">
			<a href="complainList.do?currentPage=1&searchType=${searchType}&searchBlack=${param.searchBlack}&subject_id=${subject_id}">|&lt;</a>
		&nbsp;
			<a href="complainList.do?currentPage=${pageInfo.prevPage}&searchType=${searchType}&searchBlack=${param.searchBlack}&subject_id=${subject_id}">&lt;</a>
		&nbsp;
			<c:forEach var="currentPage" begin="${pageInfo.fromPage}" end="${pageInfo.tillPage}" step="1">
				<a href="complainList.do?currentPage=${currentPage}&searchType=${searchType}&searchBlack=${param.searchBlack}&subject_id=${subject_id}"
				${pageInfo.currentPage==currentPage ? "style='font-weight:bold;'":""}>${currentPage}</a>
		&nbsp;
			</c:forEach>
		
			<a href="complainList.do?currentPage=${pageInfo.nextPage}&searchType=${searchType}&searchBlack=${param.searchBlack}&subject_id=${subject_id}">&gt;</a>
		&nbsp;
			<a href="complainList.do?currentPage=${pageInfo.lastPage}&searchType=${searchType}&searchBlack=${param.searchBlack}&subject_id=${subject_id}">&gt;|</a>
		</div>
		
		<c:if test="${loginMember!=null}">
			<div class="btn_container container d-flex ">
				<form action="${path}/blacklist/complainList.do" method="get">
					<input type="hidden" name="currentPage" value="1">
					<input type="hidden" name="subject_id" value="${loginMember.acc_id}">
				<button type="submit" class="btn btn-warning btn-sm mt-3">나의 신고내역</button>
				</form>
				<button type="button" class="btn btn-danger btn-sm mt-3"
					onclick="location.href='${path}/blacklist/complain.do'">신고하러 가기</button>
				<%-- <a href="${path}/blacklist/complain.do" class="align-self-end">신고하러 가기</a> --%>
			</div>
		</c:if>
	</div>



</section>

<script src="${path}/resources/js/blacklist/complainList.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>