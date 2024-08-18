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
				<h2>물품 수정하기</h2>
			</div>
			<hr>
			<form id="itemEnrollForm" method="POST"
				action="${path}/item/itemUpdateOK.do?item_index="+item_index enctype="multipart/form-data">
				<input type="hidden" name="item_index" value="${item.item_index}">
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
									name="item_title" id="item_title" value="${item.item_title}"
									placeholder="제목">
							</div>
							<div id="input_box2" class="container box3">
								<p class="itemEnroll_subtitle fs-5">카 테 고 리</p>
								<select id="item_category" name="item_category"
									class="form-select item_input">
									<option>==========분류===========</option>
									<option value="상의"
										${item.item_category == '상의' ? 'selected' : ''}>상의</option>
									<option value="하의"
										${item.item_category == '하의' ? 'selected' : ''}>하의</option>
									<option value="신발"
										${item.item_category == '신발' ? 'selected' : ''}>신발</option>
									<option value="기타의류"
										${item.item_category == '기타의류' ? 'selected' : ''}>기타의류</option>
									<option value="지갑"
										${item.item_category == '지갑' ? 'selected' : ''}>지갑</option>
									<option value="피규어"
										${item.item_category == '피규어' ? 'selected' : ''}>피규어</option>
									<option value="전자기기"
										${item.item_category == '전자기기' ? 'selected' : ''}>전자기기</option>
									<option value="가구"
										${item.item_category == '가구' ? 'selected' : ''}>가구</option>
									<option value="식품"
										${item.item_category == '식품' ? 'selected' : ''}>식품</option>
									<option value="기타"
										${item.item_category == '기타' ? 'selected' : ''}>기타</option>
								</select>
							</div>
							<div id="input_box3" class="container">
								<p class="itemEnroll_subtitle fs-5">가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_price" id="item_price" value="${item.item_price}"
									placeholder="가격">
							</div>
							<div id="input_box4" class="container">
								<p class="itemEnroll_subtitle fs-5">장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_place" id="item_place" value="${item.item_place}"
									placeholder="장소" readonly /> <input type="hidden"
									name="addressX" id="addressX" value="${item.item_placeX}">
								<input type="hidden" name="addressY" id="addressY"
									value="${item.item_placeY}">
								<button type="button" id="selectPlaceButton">장소 선택</button>
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
									name="item_content" id="item_content" placeholder="내용을 입력해주세요">${item.item_content}</textarea>
							</div>
							<div class="container_btn">
								<button type="submit" id="itemEnroll_form"
									class="btn btn-success btn-sm">수정</button>
								<button type="reset" class="btn btn-success btn-sm">취소</button>
							</div>
						</td>
						<td>
							<div class="container_preview">
								<img id="preview1" alt="썸네일"
									src="${path}/resources/img/${item.item_thumbPath}">
							</div>
						</td>
					</tr>
				</table>
			</form>
			<div class="modal fade" id="placeModal" tabindex="-1"
				aria-labelledby="placeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="placeModalLabel">장소 선택</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div id="map" style="width: 100%; height: 400px;"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="confirmPlace">확인</button>
						</div>

					</div>
				</div>
			</div>
		</div>


	</c:if>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a41a4466a946b1b4af605da49e598032&libraries=services"></script>
	<script>
		document.addEventListener('DOMContentLoaded', () => {
			const item_thumb = document.getElementById("item_thumb");
			const preview = document.getElementById("preview1");
			const itemEnroll_form = document.getElementById("itemEnroll_form");
			const existingThumb = preview.src;
			let check= true;
			
			item_thumb.addEventListener('change', () => {
				console.log("파일");
				const file = item_thumb.files[0];
				if(file) {
					const reader = new FileReader();
					reader.onload = function(e) {
						preview.src = e.target.result;
						
						check= false;
						alert(check);
					}
					reader.readAsDataURL(file);
				} else {
					preview.src = existingThumb;
					check= true;
					alert(check);
				}
				
			});
			
		    itemEnroll_form.addEventListener('submit', (e) => {
		        const checkInput = document.createElement('input');
		        checkInput.type = 'hidden';
		        checkInput.name = 'check';
		        checkInput.value = check;
		        itemEnroll_form.appendChild(checkInput);
		    });
			
			
			
			const placeButton = document.getElementById("selectPlaceButton"); // 장소 선택 버튼
	        const placeModal = new bootstrap.Modal(document.getElementById('placeModal'));
	        const mapContainer = document.getElementById('map');
	        const itemPlaceInput = document.getElementById('item_place');
	        const addressXInput = document.getElementById('addressX');
	        const addressYInput = document.getElementById('addressY');
	        const confirmPlaceButton = document.getElementById('confirmPlace');
	        let map; // 지도 객체
	        let markers = []; // 마커 배열
	        let selectedMarker = null;
	        let selectedLatLng = null;
	        let selectedAddress = null;
	        
	        let isMarkerSelected = false;
	        confirmPlaceButton.disabled = true;

	        // 멤버 주소
	        const fullAddress = "${loginMember.acc_address}";

	        // AJAX 요청을 사용하여 주소를 서버로 전송
	        fetch('${path}/map/locations?fullAddress=' + encodeURIComponent(fullAddress))
	            .then(response => response.text())
	            .then(data => {
	                console.log('Server response:', data); // 서버에서 받은 응답을 콘솔에 출력
	            })
	            .catch(error => console.error('Error:', error));

	        // 클릭된 마커 이미지
	        const clickedImage = new kakao.maps.MarkerImage(
	            'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
	            new kakao.maps.Size(24, 35),
	            { offset: new kakao.maps.Point(12, 35) }
	        );

	        placeButton.addEventListener('click', (e) => {
	            e.preventDefault();
	            placeModal.show();

	            if (!map) {
	                const addressX = ${loginMember.acc_addressX}; 
	                const addressY = ${loginMember.acc_addressY}; 

	                const mapOption = {
	                    center: new kakao.maps.LatLng(addressX, addressY),
	                    level: 3 
	                };
	               

	                map = new kakao.maps.Map(mapContainer, mapOption);

	                const geocoder = new kakao.maps.services.Geocoder();
	                
	                fetch('${path}/map/locations?fullAddress=' + encodeURIComponent(fullAddress))
	                    .then(response => response.json())
	                    .then(data => {
	                        data.forEach(location => {
	                            const coords = new kakao.maps.LatLng(location.addressX, location.addressY);
	                            const marker = new kakao.maps.Marker({
	                                position: coords,
	                                map: map
	                            });

	                            // 마커 클릭 이벤트
	                            kakao.maps.event.addListener(marker, 'click', function () {
	                                if (selectedMarker === marker) {
	                                    // 이미 선택된 마커를 다시 클릭한 경우, 선택 취소
	                                    marker.setImage(null);
	                                    selectedMarker = null;
	                                    selectedLatLng = null;
	                                    selectedAddress = null;
	                                    confirmPlaceButton.disabled = true;
	                                } else {
	                                    // 새로운 마커를 선택한 경우
	                                    if (selectedMarker) {
	                                        selectedMarker.setImage(null);
	                                    }

	                                    marker.setImage(clickedImage);
	                                    selectedMarker = marker;

	                                    selectedLatLng = marker.getPosition();
	                                    geocoder.coord2Address(selectedLatLng.getLng(), selectedLatLng.getLat(), function (result, status) {
	                                        if (status === kakao.maps.services.Status.OK) {
	                                            selectedAddress = result[0].address.address_name;
	                                            confirmPlaceButton.disabled = false;
	                                        }
	                                    });
	                                }
	                            });
	                        });
	                    })
	                    .catch(error => console.error('Error:', error));
		                setTimeout(function() {
			                if (map) {
			                    map.relayout();
			                    map.setCenter(new kakao.maps.LatLng(addressX, addressY));
			                } else {
			                    console.error("Map object is not initialized yet.");
			                }
			            }, 500); 
	            }
	            
	        });
	                    
	        // 확인 버튼 클릭 시 선택된 위치 정보를 인풋 필드에 저장
	        confirmPlaceButton.addEventListener('click', () => {
	            if (selectedLatLng && selectedAddress) {
	                itemPlaceInput.value = selectedAddress;
	                addressXInput.value = selectedLatLng.getLat();
	                addressYInput.value = selectedLatLng.getLng();
	                placeModal.hide(); // 모달 닫기
	            }
	        });
	        confirmPlaceButton.disabled = true;
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
