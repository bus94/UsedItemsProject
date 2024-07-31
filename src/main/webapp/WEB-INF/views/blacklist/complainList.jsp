<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container blacklist_page"
	style="padding-top: 100px;">
	<a href="${path}/blacklist/complain.do">신고하러 가기</a>

	<div
		class="whole-container container d-flex flex-column align-items-center">
		<p id="main_title" class="fs-3">신고 조회</p>
		<table class="table table-success table-striped table-hover" >
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">누구를</th>
					<th scope="col">내용</th>
					<th scope="col">누가</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">1</th>
					<td>Mark</td>
					<td>Otto</td>
					<td>@mdo</td>
				</tr>
				<tr>
					<th scope="row">2</th>
					<td>Jacob</td>
					<td>Thornton</td>
					<td>@fat</td>
				</tr>
				<tr>
					<th scope="row">3</th>
					<td colspan="2">Larry the Bird</td>
					<td>@twitter</td>
				</tr>
			</tbody>
		</table>








	</div>

</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>