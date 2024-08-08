package com.ss.useditems.util;

import java.util.List;

import com.ss.useditems.dto.BlacklistDTO;
import com.ss.useditems.dto.ItemDTO;
import com.ss.useditems.dto.ItemInfoDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PageInfo {
	
	//DTO 컨테이너
	private List<BlacklistDTO> dtoContainer;
	
	private List<ItemDTO> dtoContainer2;
	
	private List<ItemInfoDTO> dtoContainerInfo;
	
	//현재 페이지
	private int currentPage;
	
	// 한 화면에 보여질 최대 페이지 수
	private int pagePerViewer; //5
	
	// 쿼리에서 받아온 총 데이터 수
	private int dtoTotal;
	
	// 한 페이지에 보여질 DTO 수
	private int dtoPerPage; //5
	
	
	public PageInfo(int currentPage, int pagePerViewer, int dtoTotal, int dtoPerPage) {
		
		this.currentPage=currentPage;
		this.pagePerViewer=pagePerViewer; //5
		this.dtoTotal=dtoTotal;
		this.dtoPerPage=dtoPerPage;  //5

	}
	
	//최종 페이지(총 페이지 수), 한 화면에 보이는 마지막 페이지가 아님
	public int getLastPage() {
		return (int)Math.ceil((double)this.dtoTotal/(double)this.dtoPerPage) ;
	}
	
	//한 화면에 보여질 시작페이지
	public int getFromPage() {
		return ((currentPage-1) / pagePerViewer) * pagePerViewer + 1;
	}
	
	//한 화면에 보여질 마지막페이지
	public int getTillPage() {
		int tillPage = ((currentPage-1) / pagePerViewer) * pagePerViewer + pagePerViewer;
		return getLastPage() < tillPage ? getLastPage() : tillPage;
	}
	
	public int getPrevPage() {
		int prevPage = this.currentPage-1;
		return prevPage < 1 ? 1 : prevPage;
	}
	
	public int getNextPage() {
		int nextPage = currentPage+1;
		return nextPage > getLastPage() ? getLastPage() : nextPage;
	}
	
	//한 페이지에서 시작 dto인덱스
	public int getFromIndex() {
		int fromIndex = (currentPage - 1) * dtoPerPage + 1 - 1;//개수 -> 인덱스
		return fromIndex;
	}
	
	//한 페이지에서 마지막 dto인덱스
	public int getTillIndex() {
		int tillIndex = currentPage*dtoPerPage;//마지막 번호로 미포함(-1 + 1)
		return tillIndex > dtoTotal ? dtoTotal : tillIndex;
	}
	
}
