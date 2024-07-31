<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />



<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container acc_alt_page" style="padding-top: 100px;">

	<c:if test="${loginMember != null}"> 
		
	</c:if>
	
        <div class="container whole_container">

            <div id="acc_detail" class="container d-flex flex-column">
                
                <div id="profile_box" class="container d-flex flex-column align-items-center">
                    <label id="acc_id" for="profile">${loginMember.acc_id}</label>
                    <img id="profile" src="${path}/resources/img/login.png" alt="프로필사진">
                    <button type="button" id="alt_profile" class="btn btn-success btn-sm">프로필 사진 변경</button>
                </div>
				
				<hr>
                <div id="pw_box" class="container">
                    <p class="subtitle fs-5">비&nbsp;밀&nbsp;번&nbsp;호</p>
                    <button type="button" id="alt_pw" class="btn btn-success btn-sm">수정</button>
   
                    <form id="password_reset" method="post">
                        <input type="password" class="form-control w-50" name="currPW" id="currPW"
                            placeholder="현재 비밀번호" required="required" disabled>
                        <input type="password" class="form-control w-50" name="neoPW" id="neoPW"
                            placeholder="새 비밀번호" required="required" disabled>
                        <input type="password" class="form-control w-50 d-inline" name="neoPWc" id="neoPWc"
                            placeholder="새 비밀번호 확인" required="required" disabled>
                        <button type="button" id="setPw" class="btn btn-success btn-sm">비밀번호 변경</button>
                    </form>
                </div>
                
                <hr>
                <div id="nickname_box" class="container">
                	<p class="subtitle fs-5">별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</p>
                	<input type="text" class="info_box form-control d-inline" 
                	name="nickname" id="nickname" value="${loginMember.acc_nickname}">
                    <button type="button" id="setNickname" class="btn btn-success btn-sm">수정</button>
                </div>
                <div id="phone_box" class="container">
                	<p class="subtitle fs-5">전&nbsp;화&nbsp;번&nbsp;호</p>
                	<input type="text" class="info_box form-control d-inline" 
                	name="phone" id="phone" value="${loginMember.acc_phone}">
                    <button type="button" id="setPhone" class="btn btn-success btn-sm">수정</button>
                </div>
                
                <hr>
                <div id="redundant_box" class="container">
                	<form>
                		<div>
                			<p class="subtitle fs-5">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</p>
                			<input type="text" class="info_box form-control d-inline" 
                			name="name" id="name" value="${loginMember.acc_name}">
                		</div>
                		<div>
                			<p class="subtitle fs-5">생&nbsp;년&nbsp;월&nbsp;일</p>
                			<input type="text" class="info_box form-control d-inline" 
                			name="birthDate" id="birthDate" value="<fmt:formatDate value='${loginMember.acc_birthDate}' pattern='yyyy-MM-dd' />">
                		</div>
                		<div>
                			<p class="subtitle fs-5">이&nbsp;&nbsp;&nbsp;메&nbsp;&nbsp;&nbsp;일</p>
                			<input type="email" class="info_box form-control d-inline" 
                			name="email" id="email" value="${loginMember.acc_email}">
                		</div>
                		<div>
                			<p class="subtitle fs-5">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</p>
                			<input type="text" class="info_box form-control d-inline" 
                			name="address" id="address" value="${loginMember.acc_address}">
                		</div>
                		<div class="btn_container container">
                			<button type="button" id="setRedunds" class="btn btn-success btn-sm">수정</button>
                			<button type="reset" class="btn btn-success btn-sm">취소</button>
                		</div>
                	</form>
                </div>    





            </div>
        </div>


    </section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>