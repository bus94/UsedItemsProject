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
							<div id="input_box" class="container box">
								<p class="itemEnroll_subtitle fs-5">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_title" id="item_title" placeholder="제목">
							</div>
							<div id="input_box2" class="container box">
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
							<div id="input_box3" class="container box">
								<p class="itemEnroll_subtitle fs-5">가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</p>
								<input type="text" class="form-control item_input d-inline"
									name="item_price" id="item_price" placeholder="가격">
							</div>
							<div id="input_box4" class="container box">
								<p class="itemEnroll_subtitle fs-5">장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</p>
								<div id="input_address">
									<input type="text"
										class="form-control item_input d-inline input_addressIn"
										name="place_name" id="place_name" placeholder="장소" readonly />
									<input type="hidden" name="item_place" id="item_place"> 
									<input type="hidden" name="addressX" id="addressX"> <input
										type="hidden" name="addressY" id="addressY">
									<button type="button" id="selectPlaceButton"
										class="btn input_addressBtn">장소 선택</button>
								</div>
							</div>
							<div class="container input_thumbnail box">
								<p class="itemEnroll_subtitle fs-5">썸&nbsp;&nbsp;&nbsp;네&nbsp;&nbsp;&nbsp;일</p>
								<input style="width: 270px" type="file" name="item_thumb"
									id="item_thumb">
								<!-- <label class="btn fileBtn" for="item_thumb">파일선택</label> -->
							</div>
							<div id="input_box5" class="container">
								<p class="itemEnroll_subtitle fs-5">첨 부 파 일</p>
								<input style="width: 270px" type="file" name="item_image"
									id="item_image" multiple>
								<!-- <label class="btn fileBtn" for="item_image">파일선택</label> -->
							</div>
							<div id="input_box1" class="container box">
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
								<img id="preview" alt="썸네일 이미지 미리보기"> <img
									id="defaultview" alt="미리보기 파일 없음"
									src="${path}/resources/img/noimage.png">
								<!-- <p class="defaultP">썸네일 미리보기</p>
								<p class="defaultP">첨부된 파일이 없습니다.</p> -->
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
							<h5 class="modal-title" id="placeModalLabel">희망 거래 장소 선택</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div id="map" style="width: 100%; height: 400px;"></div>
						</div>
						<div class="modal-footer">
							<p style="font-size: 13px; color: rgb(187, 187, 187);">저희 세이프존에서 추천하는 희망거래장소입니다. 구체적인 거래장소는 채팅을 통해 상의 바랍니다.</p>
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="confirmPlace">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	
	<script>
		document.addEventListener('DOMContentLoaded', () => {
			const item_thumb = document.getElementById("item_thumb");
			const preview = document.getElementById("preview");
			const itemEnroll_form = document.getElementById("itemEnroll_form");
			const defaultview = document.getElementById("defaultview");
			const defaultP = document.getElementsByClassName('defaultP');
			
			item_thumb.addEventListener('change', () => {
				const file = item_thumb.files[0];
				if(file) {
					const reader = new FileReader();
					reader.onload = function(e) {
						preview.src = e.target.result;
						preview.style.display = 'block';
						defaultview.style.display = 'none';
						for (let i = 0; i < defaultP.length; i++) {
							defaultP[i].classList.add('defaultPcss');
						}
						itemEnroll_form.classList.remove('hidden');
					}
					reader.readAsDataURL(file);
				} else {
					preview.style.display = 'none';
					defaultview.style.display = "block";
					for (let i = 0; i < defaultP.length; i++) {
						defaultP[i].classList.remove('defaultPcss');
					}
					itemEnroll_form.classList.add('hidden');
				}
				
			});
			
			
			
			const placeButton = document.getElementById("selectPlaceButton"); // 장소 선택 버튼
	        const placeModal = new bootstrap.Modal(document.getElementById('placeModal'));
	        const mapContainer = document.getElementById('map');
	        const itemPlaceInput = document.getElementById('item_place');
	        const addressXInput = document.getElementById('addressX');
	        const addressYInput = document.getElementById('addressY');
	        const confirmPlaceButton = document.getElementById('confirmPlace');
	        const place_nameInput=document.getElementById('place_name');
	        let map; // 지도 객체
	        let markers = []; // 마커 배열
	        let selectedMarker = null;
	        let selectedLatLng = null;
	        let selectedAddress = null;
	        let selectedName = null; 
	        
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
	                                    selectedName = null;
	                                    confirmPlaceButton.disabled = true;
	                                } else {
	                                    // 새로운 마커를 선택한 경우
	                                    if (selectedMarker) {
	                                        selectedMarker.setImage(null);
	                                    }

	                                    marker.setImage(clickedImage);
	                                    selectedMarker = marker;

	                                    selectedLatLng = marker.getPosition();
	                                    selectedName = location.name;
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
	                    
	                    
	                // 지도에 표시할 원을 생성합니다
	               /*  var circle = new kakao.maps.Circle({
	                    center : new kakao.maps.LatLng(addressX, addressY),  // 원의 중심좌표 입니다 
	                    radius: 2000, // 미터 단위의 원의 반지름입니다 
	                    strokeWeight: 3, // 선의 두께입니다 
	                    strokeColor: '#75B8FA', // 선의 색깔입니다
	                    strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	                    strokeStyle: 'solid', // 선의 스타일 입니다
	                    fillColor: '#CFE7FF', // 채우기 색깔입니다
	                    fillOpacity: 0.3  // 채우기 불투명도 입니다   
	                });
	                circle.setMap(map); */
	               
	        

	        // 확인 버튼 클릭 시 선택된 위치 정보를 인풋 필드에 저장
	        confirmPlaceButton.addEventListener('click', () => {
	            if (selectedLatLng && selectedAddress) {
	                itemPlaceInput.value = selectedAddress;
	                place_nameInput.value=selectedName;
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