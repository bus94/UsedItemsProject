<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container" style="padding-top: 100px;">
	<c:if test="${loginMember != null}">
		<div id="container_inner" class="container d-flex flex-column">
			<div class="itemEnroll_title">
				<h2>물품 등록하기</h2>
			</div>
			<hr>
			<form id="itemEnrollForm" method="POST"
				action="${path}/item/itemEnrollOK.do" enctype="multipart/form-data">
				<table>
					<colgroup>
						<col style="width: 60%">
						<col style="width: 40%">
					</colgroup>
					<tr>
						<td>
							<div id="input_box" class="container">
								<p class="itemEnroll_subtitle fs-5">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_title" id="item_title" placeholder="제목">
							</div>
							<div id="input_box2" class="container box3">
								<p class="itemEnroll_subtitle fs-5">카 테 고 리</p>
								<select id="item_category" name="item_category"
									class="form-select item_input">
									<option selected>==========분류===========</option>
									<option value="상의">상의</option>
									<option value="하의">하의</option>
									<option value="신발">신발</option>
									<option value="기타의류">기타의류</option>
									<option value="지갑">지갑</option>
									<option value="피규어">피규어</option>
									<option value="전자기기">전자기기</option>
									<option value="가구">가구</option>
									<option value="식품">식품</option>
									<option value="기타">기타</option>
								</select>
							</div>
							<div id="input_box3" class="container">
								<p class="itemEnroll_subtitle fs-5">가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_price" id="item_price" placeholder="가격">
							</div>
							<div id="input_box4" class="container">
								<p class="itemEnroll_subtitle fs-5">장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_place" id="item_place" placeholder="장소">
							</div>
							<div class="container input_thumbnail">
								<p class="itemEnroll_subtitle fs-5">썸&nbsp;&nbsp;&nbsp;네&nbsp;&nbsp;&nbsp;일</p>
								<input style="width: 270px" type="file" name="item_thumb"
									id="item_thumb">
							</div>
							<div id="input_box5" class="container">
								<p class="itemEnroll_subtitle fs-5">첨 부 파 일</p>
								<input style="width: 270px" type="file" name="item_image"
									id="item_image" multiple>
							</div>
							<div id="input_box1" class="container">
								<p class="itemEnroll_subtitle fs-5">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</p>
								<textarea class="form-control item_input d-inline input_text"
									name="item_content" id="item_content" placeholder="내용을 입력해주세요"></textarea>
							</div>
							<div class="container_btn">
								<button type="submit" id="itemEnroll_form"
									class="btn btn-success btn-sm">등록</button>
								<button type="reset" class="btn btn-success btn-sm">취소</button>
							</div>
						</td>
						<td>
							<div class="container_preview">
								<img id="preview" alt="첨부된 썸네일 파일이 없습니다.">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</c:if>

	<script>
		document.addEventListener('DOMContentLoaded', () => {
			const item_thumb = document.getElementById("item_thumb");
			const preview = document.getElementById("preview");
			const itemEnroll_form = document.getElementById("itemEnroll_form");
			
			item_thumb.addEventListener('change', () => {
				const file = item_thumb.files[0];
				if(file) {
					const reader = new FileReader();
					reader.onload = function(e) {
						preview.src = e.target.result;
						preview.style.display = 'block';
						itemEnroll_form.classList.remove('hidden');
					}
					reader.readAsDataURL(file);
				} else {
					preview.style.display = 'none';
					itemEnroll_form.classList.add('hidden');
				}
			});
		});
	</script>

	<c:if test="${loginMember == null}">
		<script>
			alert("로그인 먼저 해주세요.");
			location.href = "${path}/account/login.do";
		</script>
	</c:if>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>