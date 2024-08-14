package com.ss.useditems.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/map")
public class MapController {
	
	
	@PostMapping("/calculateDistanceFromCoordinates")
    public String calculateDistanceFromCoordinates(
            @RequestParam("latitude1") double latitude1,
            @RequestParam("longitude1") double longitude1,
            @RequestParam("latitude2") double latitude2,
            @RequestParam("longitude2") double longitude2,
            Model model) {
		System.out.println(latitude1);
		System.out.println(longitude1);
		System.out.println(latitude2);
		System.out.println(longitude2);
        double distance = haversine(latitude1, longitude1, latitude2, longitude2);
        boolean isGreaterThan2km = distance <= 2.0;

        model.addAttribute("result", isGreaterThan2km ? "true" : "false");

        return "map/maptest2";  // 결과를 원래 폼 페이지에 보여줍니다.
    }

    private double haversine(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // 지구 반지름 (단위: km)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        System.out.println(R*c);
        return R * c; // 두 좌표 간의 거리 (단위: km)
    }
	
}
