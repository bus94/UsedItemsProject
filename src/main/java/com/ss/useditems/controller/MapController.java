package com.ss.useditems.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ss.useditems.dto.LocationDTO;
import com.ss.useditems.service.MapService;

@Controller
@RequestMapping("/map")
public class MapController {
	@Autowired
	MapService service;

	
	@RequestMapping("/map/maptest1")
	public String mapTest(Model model) {
		System.out.println("maptest 페이지");
		return "map/maptest1";
	}

	@RequestMapping("/map/maptest2")
	public String mapTest2(Model model) {
		System.out.println("maptest 페이지");
		return "map/maptest2";
	}

	@PostMapping("/calculateDistanceFromCoordinates")
	public String calculateDistanceFromCoordinates(@RequestParam("latitude1") double latitude1,
			@RequestParam("longitude1") double longitude1, @RequestParam("latitude2") double latitude2,
			@RequestParam("longitude2") double longitude2, Model model) {
		System.out.println(latitude1);
		System.out.println(longitude1);
		System.out.println(latitude2);
		System.out.println(longitude2);
		double distance = haversine(latitude1, longitude1, latitude2, longitude2);
		boolean isGreaterThan2km = distance <= 2.0;

		model.addAttribute("result", isGreaterThan2km ? "true" : "false");

		return "map/maptest2"; // 결과를 원래 폼 페이지에 보여줍니다.
	}

	private double haversine(double lat1, double lon1, double lat2, double lon2) {
		final int R = 6371; // 지구 반지름 (단위: km)
		double dLat = Math.toRadians(lat2 - lat1);
		double dLon = Math.toRadians(lon2 - lon1);
		double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Math.toRadians(lat1))
				* Math.cos(Math.toRadians(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		System.out.println(R * c);
		return R * c; // 두 좌표 간의 거리 (단위: km)
	}

	@GetMapping("/locations")
	@ResponseBody
	public List<Map<String, Double>> getMarkers(@RequestParam("fullAddress") String fullAddress) {
		System.out.println("controller");
		String add = parseAddress(fullAddress);
		System.out.println(add);
		List<LocationDTO> marker=service.getMarkers(add);
		
		  // LocationDTO 리스트를 가져옴
	    List<LocationDTO> locations = service.getMarkers(add);
	    
	    // LocationDTO 리스트를 좌표로 변환
	    List<Map<String, Double>> markerCoordinates = locations.stream()
	        .map(location -> Map.of(
	            "addressX", Double.parseDouble(location.getAddressX()),
	            "addressY", Double.parseDouble(location.getAddressY())
	        ))
	        .collect(Collectors.toList());
	    
	    // 좌표를 출력
	    markerCoordinates.forEach(coord -> {
	        System.out.println("Latitude: " + coord.get("addressX") + ", Longitude: " + coord.get("addressY"));
	    });
	    
	    // JSON 형태로 반환
	    return markerCoordinates;
		
	}

	public static String parseAddress(String fullAddress) {
		String result="";// [0]: city, [1]: district

		if (fullAddress == null || fullAddress.isEmpty()) {
			return result;
		}

		String[] addressParts = fullAddress.split(" ");
		
		if (addressParts.length > 1) {
			if (addressParts[0].equals("서울") || addressParts[0].equals("인천")) {
				// 서울특별시 또는 인천광역시의 경우
				result += addressParts[0]; // 서울, 인천
				result +=" " +addressParts[1]; // 서초구, 서구 등
			} else if (addressParts[0].equals("경기")) {
				// 경기도의 경우
				if (addressParts.length > 2) {
					result = addressParts[0] + " " + addressParts[1]; // 경기 수원시
					if(addressParts[2].endsWith("구")||addressParts[2].endsWith("군")) {
						result +=" "+ addressParts[2]; // 팔달구 등
					}
				}
			} else {
				// 그 외 다른 경우
				result = addressParts[0]; // 시
				result = addressParts[1]; // 구
			}
		}
		

		return result;
	}
	
	
	


}
