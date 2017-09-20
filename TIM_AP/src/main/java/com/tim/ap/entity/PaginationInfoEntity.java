package com.tim.ap.entity;

import java.util.List;

/**
 * 페이징 처리에 필요한 프로퍼티를 가진 VO
 * setTotalRecords 와 setCurrentPage 를 호출하여 페이징 연산 수행.
 */

public class PaginationInfoEntity<T> {
	private int screenSize   = 3  ;//한창에 띄울 화면수 
	private int blockSize    = 5  ;//보여질 페이징 개수
	private int totalRecords   ;//총 목록수
	private int currentPage    ;//현제 페이지
	private int totalPage      ;//전체 페이지
	private int startRow       ;
	private int endRow         ;
	private int startPage      ;
	private int endPage        ;
	private String searchType;
	private String searchWord;
	private List<T> dataList;
	
	public PaginationInfoEntity() {
		this(3, 5);		
	}

	public int getScreenSize() {
		return screenSize;
	}

	public void setScreenSize(int screenSize) {
		this.screenSize = screenSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public List<T> getDataList() {
		return dataList;
	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

	public int getTotalRecords() {
		return totalRecords;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public PaginationInfoEntity(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
		setCurrentPage(1);
	}

	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
		totalPage = (totalRecords +(screenSize - 1)) / screenSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		endPage = ((currentPage + (blockSize - 1))/blockSize)*blockSize;
		startPage = endPage - (blockSize - 1);
	}
	
	public String getPagingHTML(){
		StringBuffer sb = new StringBuffer();
		String ptrn = "<a href='?page=%d&searchType=%s&searchWord=%s'>[%s]</a>";
		if(startPage > 1){
			sb.append(String.format(ptrn, (startPage-1),searchType,searchWord, "이전"));
		}
		endPage = endPage > totalPage ? totalPage : endPage;
		for( int pageNO = startPage ; pageNO<=endPage ; pageNO ++){
			if(pageNO==currentPage){
				sb.append("["+pageNO+"]");
			}else{
				sb.append(String.format(ptrn, pageNO,searchType,searchWord,  pageNO));
			}
		}
		if(endPage < totalPage){
			sb.append(String.format(ptrn, (endPage+1),searchType,searchWord,  "다음"));
		}
		
		return sb.toString();
	}
}
















