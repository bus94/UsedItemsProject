<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section id="content" class="container acc_alt_page" style="padding-top: 100px;">
	<c:if test="${loginMember != null}"> </c:if>
	
        <div class="container whole_container">

            <div id="acc_detail" class="container d-flex flex-column">
                
                <div id="profile_box" class="container d-flex flex-column align-items-center">
                    <label for="profile">${loginMember.acc_id}</label>
                    <img id="profile" src="${path}/resources/img/login.png" alt="프로필사진">
                    <button type="button" id="alt_profile" class="btn btn-success btn-sm">프로필 사진 변경</button>
                </div>
				
                <div id="pw_box" class="container">
                    <h4 class="d-inline">비밀번호</h4>
                    <button type="button" id="alt_PW" class="btn btn-success btn-sm">수정</button>
   
                    <form id="alt_pw" method="post">
                        <input type="password" class="form-control w-50" name="currPW" id="currPW"
                            placeholder="현재 비밀번호" required="required" disabled>
                        <input type="password" class="form-control w-50" name="neoPW" id="neoPW"
                            placeholder="새 비밀번호" required="required" disabled>
                        <input type="password" class="form-control w-50 d-inline" name="neoPWc" id="neoPWc"
                            placeholder="새 비밀번호 확인" required="required" disabled>
                        <button type="button" id="setPW" class="btn btn-success btn-sm">비밀번호 변경</button>
                    </form>
                </div>
                
                <div id="nickname_box" class="container">
                	<h4 class="d-inline">별명</h4>
                	<input type="text" class="form-control w-50 d-inline" 
                	name="nickname" id="nickname" value="${loginMember.acc_nickname}">
                    <button type="button" id="setNickname" class="btn btn-success btn-sm">수정</button>
                </div>
                <div id="phone_box" class="container">
                	<h4 class="d-inline">전화번호</h4>
                	<input type="text" class="form-control w-50 d-inline" 
                	name="phone" id="phone" value="${loginMember.acc_phone}">
                    <button type="button" id="setPhone" class="btn btn-success btn-sm">수정</button>
                </div>
                        
                <div id="redundant_box" class="container">
                
                          <!--이름 생년월일 이메일 주소 -->
                
                </div>    





            </div>
        </div>


    </section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>