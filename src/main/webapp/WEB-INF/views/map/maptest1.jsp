<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 생성하기</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<style>
/* 모달 내 Daum Postcode API의 크기 조정 */
#postcode {
	width: 100%;
	height: 400px; /* 높이 조정 */
}
</style>
</head>
<body>
	<!-- 주소 입력 필드와 버튼 -->
	<input type="text" id="sample5_address" placeholder="주소" readonly>
	<input type="button" onclick="openAddressModal()" value="주소 검색">

	<!-- 지도 표시 영역 -->
	<div id="map"
		style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>

	<!-- 주소 검색 모달 -->
	<div class="modal fade" id="addressModal" tabindex="-1"
		aria-labelledby="addressModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<!-- 모달 크기를 키움 -->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addressModalLabel">주소 검색</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="postcode"></div>
					<!-- 여기에 Daum Postcode API가 삽입됨 -->
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bcb92e8b96f5a06c65f1c0e5308b488&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		mapOption = {
			center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};

		//지도를 미리 생성
		var map = new daum.maps.Map(mapContainer, mapOption);
		//주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new daum.maps.Marker({
			position : new daum.maps.LatLng(37.537187, 127.005476),
			map : map
		});
 
		// 모달을 열고 주소 검색을 실행하는 함수
		function openAddressModal() {
			var modal = new bootstrap.Modal(document.getElementById('addressModal'));
			modal.show();

			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.address; // 최종 주소 변수

					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("sample5_address").value = addr;

					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results, status) {
						//정상적으로 검색이 완료됐으면
						if (status === daum.maps.services.Status.OK) {

							var result = results[0]; // 첫번째 결과의 값을 활용

							//해당 주소에 대한 좌표를 받아서
							var coords = new daum.maps.LatLng(result.y, result.x);
							console.log("Latitude: " + coords.getLat() + ", Longitude: " + coords.getLng());
							//지도를 보여준다.
							mapContainer.style.display = "block";
							map.relayout();
							//지도 중심을 변경한다.
							map.setCenter(coords);
							//마커를 결과값으로 받은 위치로 옮긴다.
							marker.setPosition(coords); 

							//모달 닫기
							modal.hide();
						}
					});
				},
				width: '100%',
				height: '100%'
			}).embed(document.getElementById('postcode'));
		}
	</script>
</body>
</html>
