<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
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

<script src="${path}/resources/js/item/itemView.js"></script>

<!-- 아래의 명시된 날짜 이후가 되면 페이지가 캐싱되지 않는다. -->
<meta http-equiv="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">
<!-- 캐시된 페이지가 만료되어 삭제되는 시간 정의. 특별한 경우가 아니면 -1로 설정. -->
<meta http-equiv="Expires" content="-1">
<!-- 페이지 로드시마다 페이지를 캐싱하지 않습니다. (HTTP 1.0, 1.1) -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
</head>
<body>

	<div id="wrapper">
		<!-- 전체 페이지 wrapper -->

<!-- 챗 관련 모달, special position(navigator: fixed-top) 내부에 두면 문제가 생김!! -->
				 <!-- ChatRoom_List_Modal -->
<div class="modal fade" id="chatRoomListModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">거래 중인 매물</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
			 						<button class="btn btn-primary" data-bs-target="#chatRoomModal1" data-bs-toggle="modal">채팅방1</button>
        							<hr>
									<button class="btn btn-primary" data-bs-target="#chatRoomModal2" data-bs-toggle="modal">채팅방2</button>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

				 <!-- ChatRoom_Modal -->
<div class="modal fade" id="chatRoomModal1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">채팅방1</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
			 		<div class="chat-container">
	    	<div class="header">세이프챗</div>

    		<div class="chat-area" id="chatArea">
   
	    	</div>

    		<div class="input-area">
        		<input type="text" id="chatInput" placeholder="메시지입력">
        		<button id="sendButton">전송</button>
    		</div>
				</div>		
				
			<!-- 챗룸JS에 넘겨줄 로그인멤버 변수 -->
			<script>
				var chat_accIndex = "${loginMember.acc_index}";
				var chat_accId = "${loginMember.acc_id}";
				var chat_accNickname = "${loginMember.acc_nickname}";
				var chat_accProfile = "${loginMember.acc_profile}";
			</script>
			<script defer src="${path}/resources/js/chat/chatRoom.js">
			</script>
					
      </div>
      <div class="modal-footer">
      	<button class="btn btn-primary" data-bs-target="#chatRoomListModal" data-bs-toggle="modal">채팅방리스트로 돌아가기</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

				 <!-- ChatRoom_Modal -->
<div class="modal fade" id="chatRoomModal2" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">채팅방2</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
			 		<div class="chat-container">
	    	<div class="header">세이프챗</div>

    		<div class="chat-area" id="chatArea">
   
	    	</div>

    		<div class="input-area">
        		<input type="text" id="chatInput" placeholder="메시지입력">
        		<button id="sendButton">전송</button>
    		</div>
				</div>		 						
			 						
      </div>
      <div class="modal-footer">
      	<button class="btn btn-primary" data-bs-target="#chatRoomListModal" data-bs-toggle="modal">채팅방리스트로 돌아가기</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>




<!-- 네비게이터 (fixed-top!!!) -->
		<nav id="navigator"
			class="fixed-top navbar navbar-expand-lg bg-body-tertiary"
			style="background-color: white">
			<div id="nav_container" class="container-fluid">
				<a class="navbar-brand" href="${path}/"> <img id="brand_img"
					alt="SAFE MARKET" src="${path}/resources/img/logo.png">
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-lg-0">
						<a class="nav-link active" aria-current="page"
							href="${path}/item/itemList.do">
							<li class="nav-item"><img class="nav_icon" alt="매물 검색"
								src="${path}/resources/img/shop.png"> <span
								class="menu_text">매물검색</span></li>
						</a>
						<a class="nav-link" href="${path}/blacklist/complainList.do">
							<li class="nav-item"><img class="nav_icon" alt="신고 조회"
								src="${path}/resources/img/report.png"> <span
								class="menu_text">신고조회</span></li>
						</a>

						<c:if test="${loginMember == null}">
							<a class="nav-link" href="${path}/account/login.do">
								<li class="nav-item"><img class="nav_icon" alt="로그인"
									src="${path}/resources/img/login.png"> <span
									class="menu_text">로그인</span></li>
							</a>
							<a class="nav-link" href="${path}/account/signup.do">
								<li class="nav-item"><img class="nav_icon" alt="회원가입"
									src="${path}/resources/img/login2.png"> <span
									class="menu_text">회원가입</span></li>
							</a>
						</c:if>


						<c:if test="${loginMember != null}">
							<a class="nav-link" id="logout" href="">
								<li class="nav-item"><img class="nav_icon" alt="로그아웃"
									src="${path}/resources/img/logout.png"> <span
									class="menu_text">로그아웃</span></li>
							</a>
							<a class="nav-link" href="${path}/item/itemEnroll.do">
								<li class="nav-item"><img class="nav_icon" alt="매물 등록"
									src="${path}/resources/img/sale.png"> <span
									class="menu_text">매물등록</span></li>
							</a>
						</c:if>
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
					<form class="d-flex" role="search"
						action="${path}/item/itemList.do" method="get">
						<input
							class="form-control me-2 focus-ring focus-ring-success border border-success"
							type="search" placeholder="매물을 검색해보세요!" aria-label="Search"
							id="searchValue" name="searchValue" value="${searchValue}">
						<button class="btn btn-outline-success" type="submit">검색</button>
					</form>
				</div>
			</div>
			<c:if test="${loginMember != null}">
				<!-- 회원페이지 -->
				<a href="${path}/account/my_info.do" id="nav_user"
					class="nav_side_icon max992off"> <i
					class="fa-solid fa-circle-user"></i></a>
				<!-- 즐겨찾기 -->
				<a href="${path}/item/interest.do" id="nav_wish"
					class="nav_side_icon max992off"> <i
					class="fa-brands fa-gratipay"></i></a>
				<!-- 챗 -->
<%-- 				 <a href="${path}/chat/chat.do" id="nav_chat" class="nav_side_icon"> 
					<i class="fa-solid fa-circle-exclamation"></i>
				 </a>  --%>
				 
				 
				 <!-- Button trigger modal -->
				 <button type="button" id="nav_chat" class="nav_side_icon" data-bs-toggle="modal" data-bs-target="#chatRoomListModal">
					<i class="fa-solid fa-circle-exclamation"></i>
				 </button>
				


				
			</c:if>	<!-- 로그인되었을 때만 보일 부분 -->

			
			<!-- 위로가기 -->
			<a href="" id="nav_toTop" class="nav_side_icon"> <i
				class="fa-solid fa-circle-arrow-up"></i></a>
		</nav>



		<script>
			$(document).ready(function() {

				$('#logout').click(function() {

					if (confirm("정말 정말 로그아웃 하시겠습니까?ㅠ_ㅠ")) {
						console.log("logout");
						window.location.href = "${path}/account/logoutOK.do";
					}
				})

			});

			$('#nav_toTop').click(function() {
				console.log('TOP 클릭');

				$('html, body').animate({
					scrollTop : 0
				}, 50);
				return false;
			});

			$('.navbar-toggler').click(function() {
				console.log('Nav토글버튼 클릭');
				$('section').toggleClass('section_toggleOn');
				$('#nav_user').toggle();
				$('#nav_wish').toggle();
				$('.menu_text').toggle();
			});

			window.addEventListener('scroll', function() {
				//console.log(window.scrollY);

				// 스크롤 Y축 300 초과 시 실행
				if (window.scrollY > '300') {
					$('#nav_toTop').show();
				}

				// 스크롤 Y축 300 미만 시 실행
				if (window.scrollY < '300') {
					$('#nav_toTop').hide();
				}

			});
		</script>