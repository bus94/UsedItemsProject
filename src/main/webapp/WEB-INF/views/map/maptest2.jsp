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
<title>주소 거리 계산</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<style>
#postcode {
	width: 100%;
	height: 400px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>주소 거리 계산기</h2>

		<!-- 첫 번째 주소 입력 폼 -->
		<div class="mb-3">
			<label for="address1" class="form-label">주소 1</label>
			<input type="text" class="form-control" id="address1" name="address1" placeholder="주소 1" readonly>
			<button type="button" class="btn btn-secondary mt-2" onclick="openAddressModal('address1')">주소 검색</button>
		</div>

		<!-- 두 번째 주소 입력 폼 -->
		<div class="mb-3">
			<label for="address2" class="form-label">주소 2</label>
			<input type="text" class="form-control" id="address2" name="address2" placeholder="주소 2" readonly>
			<button type="button" class="btn btn-secondary mt-2" onclick="openAddressModal('address2')">주소 검색</button>
		</div>

		<!-- 숨겨진 폼 -->
		<form id="coordinateForm" method="post" action="${pageContext.request.contextPath}/map/calculateDistanceFromCoordinates">
			<input type="hidden" name="latitude1" id="latitude1">
			<input type="hidden" name="longitude1" id="longitude1">
			<input type="hidden" name="latitude2" id="latitude2">
			<input type="hidden" name="longitude2" id="longitude2">
			<button type="submit" class="btn btn-primary">Calculate Distance</button>
		</form>

		<!-- 결과 출력 -->
		<c:if test="${not empty result}">
			<div class="alert alert-info mt-3">
				<strong>Result:</strong> ${result}
			</div>
		</c:if>
	</div>

	<!-- 모달 -->
	<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addressModalLabel">주소 검색</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="postcode"></div>
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
		function openAddressModal(target) {
			var modal = new bootstrap.Modal(document.getElementById('addressModal'));
			modal.show();

			new daum.Postcode({
				oncomplete: function(data) {
					var addr = data.address;

					// 입력한 주소를 해당 필드에 설정
					document.getElementById(target).value = addr;

					// 좌표 변환 요청
					geocodeAddress(addr, target);
					
					// 모달 닫기
					modal.hide();
				},
				width: '100%',
				height: '100%'
			}).embed(document.getElementById('postcode'));
		}

		function geocodeAddress(address, target) {
			var geocoder = new daum.maps.services.Geocoder();
			geocoder.addressSearch(address, function(results, status) {
				if (status === daum.maps.services.Status.OK) {
					var result = results[0];
					var lat = result.y;
					var lon = result.x;
					console.log(lat);
					console.log(lon);
					
					if (target === 'address1') {
						document.getElementById('latitude1').value = lat;
						document.getElementById('longitude1').value = lon;
					} else if (target === 'address2') {
						document.getElementById('latitude2').value = lat;
						document.getElementById('longitude2').value = lon;
					}
				} else {
					console.error("Geocoding failed: " + status);
				}
			});
		}
	</script>
</body>
</html>
