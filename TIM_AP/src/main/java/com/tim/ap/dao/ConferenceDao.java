package com.tim.ap.dao;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferListViewEntity;
import com.tim.ap.entity.ConferenceEntity;

public interface ConferenceDao {
	public ArrayList<ConferenceEntity> getConferenceList();
	public int insertConference(ConferenceEntity conferenceEntity);
	public void updateConference(ConferenceEntity conferenceEntity);
	public ConferenceEntity selectConference();
	// public void deleteConference(String id);
	
	public int selectConferenceTotalCount();//리스트의 전체 갯수를 구해주는 메서드
	public List<ConferenceEntity> selectList(int firstRow, int endRow, ConferListSelectEntity select);//검색될 리스트를 반환해주는 메서드
	public int selectListCount(ConferListSelectEntity select);//검색된 갯수를 반환해주는 메서드
	
	////정보변경을 위한 메서드
	public void conferenceInfoUpdate(List<ConferenceEntity> conferList);
}
