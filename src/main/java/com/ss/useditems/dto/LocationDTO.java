package com.ss.useditems.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
// 위치 정보 DTO (위치 계산을 위한 DTO)
public class LocationDTO {
	
	private String name;		// 위치 이름
	private Double addressX;	// 경도
	private Double addressY;	// 위도
	
}
