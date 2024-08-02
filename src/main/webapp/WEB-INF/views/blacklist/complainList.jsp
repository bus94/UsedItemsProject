<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container blacklist_page"
	style="padding-top: 100px;">


	<div class="whole-container container d-flex flex-column align-items-center">
		<p id="main_title" class="fs-3">신고 조회</p>
		

		<c:set var="searchType" value="${param.searchType}" />
		<form action="${path}/blacklist/complainList.do" method="get">

			<input type="hidden" name="currentPage" value="1">

			<div class="container d-flex align-items-center">
				<input type="radio" name="searchType" id="acc_nickname"
					value="acc_nickname" ${searchType=='acc_nickname' ? 'checked':''} />
				<label for="acc_nickname">별명</label> 
				<input type="radio"	name="searchType" id="acc_id" 
				value="acc_id" ${searchType=='acc_id' ? 'checked':''} /> 
				<label for="acc_id">아이디</label>
				<input type="radio" name="searchType" id="content" 
				value="content"	${searchType=='content' ? 'checked':''}>
				<label for="내용">내용</label>

				<div class="input-group">
					<input type="text" class="form-control" id="searchBlack"
						name="searchBlack" value="${param.searchBlack}">
					<button id="search_btn" class="btn btn-outline-secondary d-flex align-items-center justify-content-center" type="submit">
						<img id="search_img" alt="검색" src="${path}/resources/img/search.png">
					</button>
				</div>
			</div>
		</form>

		<a href="${path}/blacklist/complain.do" class="align-self-end">신고하러 가기</a>
		<table id="blacklist_container" class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">누구를</th>
					<th scope="col">내용</th>
					<th scope="col">누가</th>
					<th scope="col">언제</th>
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
						<tr>
							<th scope="row">${each.black_index}</th>
							<td>${each.object_nickname}</td>
							<td>${each.black_content}</td>
							<td>${each.subject_nickname}</td>
							<td><fmt:formatDate type="date"	value="${each.black_enrollDate}" /></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>

		<!-- 페이징 -->
		<div align="center" class="pagination container d-flex justify-content-center">
			<a href="complainList.do?currentPage=1&searchType=${searchType}&searchBlack=${param.searchBlack}">|&lt;</a>
		&nbsp;
			<a href="complainList.do?currentPage=${pageInfo.prevPage}&searchType=${searchType}&searchBlack=${param.searchBlack}">&lt;</a>
		&nbsp;
			<c:forEach var="currentPage" begin="${pageInfo.fromPage}" end="${pageInfo.tillPage}" step="1">
				<a href="complainList.do?currentPage=${currentPage}&searchType=${searchType}&searchBlack=${param.searchBlack}"
				${pageInfo.currentPage == currentPage ? "style='font-weight:bold;'":""}>${currentPage}</a>
				&nbsp;
			</c:forEach>
		
			<a href="complainList.do?currentPage=${pageInfo.nextPage}&searchType=${searchType}&searchBlack=${param.searchBlack}">&gt;</a>
		&nbsp;
			<a href="complainList.do?currentPage=${pageInfo.lastPage}&searchType=${searchType}&searchBlack=${param.searchBlack}">&gt;|</a>
		</div>
	</div>





	</div>

</section>

<script src="${path}/resources/js/blacklist/complainList.js"></script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>