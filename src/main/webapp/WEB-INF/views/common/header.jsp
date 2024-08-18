<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세잎마켓</title>

<!-- JQuery -->
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<!-- 슬릭 css-->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css?v=${systemProperties['timestamp']}" />
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css?v=${systemProperties['timestamp']}" />
<!-- 슬릭js -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- 개별 css, js 포함 -->
<link rel="stylesheet"
	href="${path}/resources/css/main.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/home/home.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/login/login.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/login/signup.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/item/itemList.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/item/interest.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/item/itemEnroll.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/item/itemView.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/acc/acc_info.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/acc/acc_alter.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/blacklist/list.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/blacklist/complain.css?v=${systemProperties['timestamp']}">
<link rel="stylesheet"
	href="${path}/resources/css/chat/chatRoom.css?v=${systemProperties['timestamp']}">

<script defer src="${path}/resources/js/header.js"></script>

<!-- 아래의 명시된 날짜 이후가 되면 페이지가 캐싱되지 않는다. -->
<meta http-equiv="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">
<!-- 캐시된 페이지가 만료되어 삭제되는 시간 정의. 특별한 경우가 아니면 -1로 설정. -->
<meta http-equiv="Expires" content="-1">
<!-- 페이지 로드시마다 페이지를 캐싱하지 않습니다. (HTTP 1.0, 1.1) -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
</head>
<body>

	<div id="wrapper">		<!-- 전체 페이지 wrapper -->
		

<!-- JS에 넘겨줄 변수 선언 -->
<script>
	var serverName =  "${pageContext.request.serverName}";
	var serverPort =  "${pageContext.request.serverPort}";
	var project = "${pageContext.request.contextPath}";
			
	var loginMember_accIndex = "${loginMember.acc_index}";
	var loginMember_accId = "${loginMember.acc_id}";
	var loginMember_accNickname = "${loginMember.acc_nickname}";
	var loginMember_accProfile = "${loginMember.acc_profile}";
</script>


<!-- 챗 관련 모달, special position(navigator: fixed-top) 내부에 두면 문제가 생김!! -->
<!-- ChatRoom_List_Modal -->
<div class="modal fade" id="chatRoomListModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div id="chatList_header" class="modal-header">
        <!-- <h5 class="modal-title">거래 중인 매물</h5> -->
        <img id="brand_img_chatList" alt="SAFE MARKET" src="${path}/resources/img/logo.png">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div id="chatList" class="modal-body">
      					
      					<!-- <div class="chatRoom_box container">
      						<p>매물 제목(임시)</p>
      						<span>판매자(임시)</span><span>생성일자(임시)</span>
			 				<button class="btn btn-success btn-sm" id="chatList1" data-bs-target="#chatRoomModal1" data-bs-toggle="modal">채팅방 보기</button>
			 				<button class="btn btn-warning btn-sm" >거래 중단하기</button>
      					</div> -->
        				
						

      </div>
      <div id="chatList_footer" class="modal-footer">
        <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> -->
      	<h5 id="chatList_notice" class="modal-title">Safe Chat</h5>
      </div>
    </div>
  </div>
</div>



<div id="ChatRoom_Modal_reservoir">
<!-- ChatRoom_Modal -->
<!-- <div class="modal fade" id="chatRoomModal1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">SafeChat_채팅방#1</h5>
        <button class="btn btn-primary" data-bs-target="#chatRoomListModal" data-bs-toggle="modal">돌아가기</button>
        <button type="button" class="unlink-chat btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div id="chat-viewer" class="modal-body">
			채팅글 div가 추가되는 곳




					
      </div>
      <div id="chat-footer" class="modal-footer">
          	<div class="input-area w-100">
        		<input type="text" id="chat-input" class="w-75" onkeyup="keyCheck(event)" placeholder="메시지 입력">
        		<button id="chat-sendBtn">전송</button>
    		</div>
      </div>
    </div>
  </div>
</div>
 -->

</div>	<!-- ChatRoom_Modal_reservoir -->

				 




<!-- 네비게이터 (fixed-top!!!) -->
		<nav id="navigator" class="fixed-top navbar navbar-expand-lg bg-body-tertiary">
			<div id="nav_container" class="nav_container">
				<a class="navbar-brand" href="${path}/"> <img id="brand_img"
					alt="SAFE MARKET" src="${path}/resources/img/logo.png">
				</a>
<!-- 				<button id="navbar-toggler" class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button> -->
				<ul class="navbar_list">
					<li>
						<form class="searchForm d-flex" role="search"
							action="${path}/item/itemList.do" method="get">
							<input
								class="form-control me-2 focus-ring focus-ring-success border border-success"
								type="search" placeholder="매물을 검색해보세요!" aria-label="Search"
								id="searchValue" name="searchValue" value="${searchValue}">
							<button class="searchFormBtn" type="submit" style="cursor: pointer; z-index: 10;">
								<img alt="" src="${path}/resources/img/search.png">
							</button>
						</form>
					</li>
					
					<li class="nav-item">
						<a><img class="nav_icon" alt="마이페이지"
						src="${path}/resources/img/user.png"></a>
						<ul>
							<li style="height: 22px;">
								<a></a>
							</li>
							<c:if test="${loginMember == null}">
								<li>
									<a href="${path}/account/login.do">로그인</a>
								</li>
							</c:if>
							<c:if test="${loginMember != null}">
								<li id="logout">
									<a href="">로그아웃</a>
								</li>
							</c:if>
							<li>
								<a href="${path}/item/interest.do">찜목록</a>
							</li>
							<li>
								<a href="${path}/account/my_info.do">마이페이지</a>
							</li>
						</ul>
					</li>
					<li class="nav-item" id="shopImg"><a>
						<img class="nav_icon" alt="메뉴"
						src="${path}/resources/img/shop.png"></a>
						<ul>
							<li style="height: 22px;">
								<a></a>
							</li>
							<li>
								<a href="${path}/item/itemList.do">물품보기</a>
							</li>
							<li>
								<a href="${path}/item/itemEnroll.do">물품등록</a>
							</li>
							<li>
								<a href="${path}/blacklist/complainList.do">신고조회</a>
							</li>
						</ul>
						
					</li>

					<c:if test="${loginMember.acc_status == 'admin'}">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 더보기 </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="${path}">뭐 넣지?</a></li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li><a class="dropdown-item" href="#">Something else
										here</a></li>
							</ul></li>
					</c:if>
				</ul>
			</div>


			<!-- 로그인되었을 때만 보일 부분 -->
			<c:if test="${loginMember != null}">
				<!-- 채팅방 리스트 -->
				<!-- Button trigger modal -->
				<button type="button" id="nav_chat" class="nav_side_icon"
					data-bs-toggle="modal" data-bs-target="#chatRoomListModal">
					<i class="fa-solid fa-comment-dots fa-flip-horizontal"></i>
				</button>

			</c:if>

			<!-- 위로가기 -->
			<a href="" id="nav_toTop" class="nav_side_icon"> <i
				class="fa-solid fa-circle-arrow-up"></i></a>
		</nav>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('.searchForm');
    const input = document.querySelector('#searchValue');
    const button = document.querySelector('.searchFormBtn');
    
    let isSearchActive = false;

    button.addEventListener('click', function(event) {
    	// 버튼 클릭하면 폼이 제출되는거 방지
      event.preventDefault();
      
      if (!isSearchActive) {
        form.classList.add('active');
        input.focus();
        isSearchActive = true;
      } else {
        form.submit();
      }
    });
  });
</script>