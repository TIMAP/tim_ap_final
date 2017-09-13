package com.tim.ap.entity;

import java.util.List;

public class AudioListViewEntity {

	private int boardTotalCount;
	private int currentPageNumber;
	private List<AudioEntity> audioList;
	private int pageTotalCount;
	private int boardCountPerPage;
	private int firstRow;
	private int endRow;
	
	public AudioListViewEntity(List<AudioEntity> audioList, int boardTotalCount,
			int currentPageNumber, int boardCountPerPage, int startRow,
			int endRow) {
		this.audioList = audioList;
		this.boardTotalCount = boardTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.boardCountPerPage = boardCountPerPage;
		this.firstRow = startRow;
		this.endRow = endRow;

		calculatePageTotalCount();
	}

	private void calculatePageTotalCount() {
		if (boardTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = boardTotalCount / boardCountPerPage;
			if (boardTotalCount % boardCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}

	public int getBoardTotalCount() {
		return boardTotalCount;
	}

	public void setBoardTotalCount(int boardTotalCount) {
		this.boardTotalCount = boardTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public void setCurrentPageNumber(int currentPageNumber) {
		this.currentPageNumber = currentPageNumber;
	}

	public List<AudioEntity> getAudioList() {
		return audioList;
	}

	public void setAudioList(List<AudioEntity> audioList) {
		this.audioList = audioList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public void setPageTotalCount(int pageTotalCount) {
		this.pageTotalCount = pageTotalCount;
	}

	public int getBoardCountPerPage() {
		return boardCountPerPage;
	}

	public void setBoardCountPerPage(int boardCountPerPage) {
		this.boardCountPerPage = boardCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
}
