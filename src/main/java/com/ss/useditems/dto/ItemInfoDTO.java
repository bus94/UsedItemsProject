package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
// 물품 정보 DTO
public class ItemInfoDTO {
	
	private int item_index;				// DB. 물품 일련번호
	private int item_seller;			// DB. 판매자
	private String item_title;			// DB. 제목
	private String item_content;		// DB. 내용
	private String item_category;		// DB. 카테고리 (10가지)
	private int item_price;				// DB. 가격
	private String item_place;			// DB. 장소명
	private String item_place_name;		// DB. safe존 이름
	private String item_place_address;	// DB. 
	private String item_placeX;			// DB. 경도
	private String item_placeY;			// DB. 위도
	private String item_status;			// DB. 상태 (onsale: 판매 중 (채팅방 x), ondeal: 거래 중 (채팅방 o), donedeal: 판매 완료, drop: 거래 중지)
	private Date item_enrollDate;		// DB. 등록 날짜
	private int item_click;				// DB. 조회수
	private int item_interest;			// DB. 관심수 (찜 등록 수)
	private Date item_offDate;			// DB. 판매 날짜
	private int item_buyer;				// DB. 판매자
	private String acc_nickname;		// 판매자 닉네임
	private String acc_address;			// 판매자 주소
	private int acc_score;				// 판매자 매너등급
	private String repl_count;			// 댓글수
	private String show_thumb;			// 썸네일 파일명
	private String show_img1;			// 이미지1 파일명
	private String show_img2;			// 이미지2 파일명
	private String show_img3;			// 이미지3 파일명
	private String show_img4;			// 이미지4 파일명
	private String show_img5;			// 이미지5 파일명
	
	private String filePath;			// 해당 물품 폴더 경로 (물품 등록한 판매자 - 물품 일련번호)
	private String item_thumbPath;		// 썸네일 파일 경로
	private String item_img1Path;		// 이미지1 파일 경로
	private String item_img2Path;		// 이미지2 파일 경로
	private String item_img3Path;		// 이미지3 파일 경로
	private String item_img4Path;		// 이미지4 파일 경로
	private String item_img5Path;		// 이미지5 파일 경로
	
}
