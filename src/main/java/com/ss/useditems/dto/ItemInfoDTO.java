package com.ss.useditems.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ItemInfoDTO {
	private int item_index;
	private int item_seller;
	private String item_title;
	private String item_content;
    private String item_image;
	private String item_category;
	private int item_price;
	private String item_place;
	private String item_status;
	private Date item_enrollDate;
	private int item_click;
	private int item_interest;
	private Date item_offDate;
	private int item_buyer;
	private String acc_nickname;
	private String acc_address;
	private String acc_level;
	private String show_thumb;
	private String show_img1;
	private String show_img2;
	private String show_img3;
	private String show_img4;
	private String show_img5;
	private String item_thumbPath;
	private String item_imgPath;
}
