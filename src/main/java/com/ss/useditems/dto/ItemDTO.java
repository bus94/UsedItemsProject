package com.ss.useditems.dto;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ItemDTO {
	
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
	private int repl_count;	//정일0807 Home.new5()
//	private List<ReplyDTO> replies;

}
