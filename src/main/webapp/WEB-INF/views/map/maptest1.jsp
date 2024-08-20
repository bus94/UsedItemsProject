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
</head>
<body>
    <input type="text" id="sample5_address" placeholder="주소" readonly>
    <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
    <br>
    <div id="map" style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>
    
    <p>선택된 주소: <span id="selectedAddress"></span></p>
    <p>X좌표: <span id="latitude"></span></p>
    <p>Y좌표: <span id="longitude"></span></p>
    <p>SQL Query: <span id="sqlQuery"></span></p>

    <script
        src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a41a4466a946b1b4af605da49e598032&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };
    
        // 지도를 미리 생성
        var map = new kakao.maps.Map(mapContainer, mapOption);
        // 주소-좌표 변환 객체를 생성
        var geocoder = new kakao.maps.services.Geocoder();
        // 마커를 미리 생성
        var marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(37.537187, 127.005476),
            map: map
        });
    
        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address; // 최종 주소 변수

                    // 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("sample5_address").value = addr;

                    // 주소로 상세 정보를 검색
                    geocoder.addressSearch(addr, function(results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === kakao.maps.services.Status.OK) {

                            var result = results[0]; // 첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표를 받아서
                            var coords = new kakao.maps.LatLng(result.y, result.x);
                            // 지도를 보여준다.
                            mapContainer.style.display = "block";
                            map.relayout();
                            // 지도 중심을 변경한다.
                            map.setCenter(coords);
                            // 마커를 결과값으로 받은 위치로 옮긴다.
                            marker.setPosition(coords);

                            // 선택된 주소 및 좌표를 표시
                            document.getElementById("selectedAddress").innerText = addr;
                            document.getElementById("latitude").innerText = result.y; // 위도 값
                            document.getElementById("longitude").innerText = result.x; // 경도 값

                            // SQL 문을 생성하여 표시
                            var sql = `insert into transaction_location values(location_SEQ.nextval, '${addr}', '${result.y}', '${result.x}');`;
                            document.getElementById("sqlQuery").innerText = sql;
                        } else {
                            console.error('Address search failed:', status);
                        }
                    });
                }
            }).open();
        }
    </script>
</body>
</html>
