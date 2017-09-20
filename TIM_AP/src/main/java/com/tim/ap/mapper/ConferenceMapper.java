package com.tim.ap.mapper;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferenceEntity;

public interface ConferenceMapper {
	    ArrayList<ConferenceEntity> getConferenceList();
	    int insertConference(ConferenceEntity conferenceEntity);
	    void updateConference(ConferenceEntity conferenceEntity);
	    ConferenceEntity selectConference();
	    int selectConferCount();
	    //void deleteConference(String id);
	    int selectConferenceTotalCount();//리스트의 갯수를 반환하는 메서드
	    List<ConferenceEntity> selectConferenceList(int firstRow, int endRow,
				ConferListSelectEntity select);
	    int selectListCount(ConferListSelectEntity select);
	    ////정보변경을 위한 메서드
		void conferenceInfoUpdate(ConferenceEntity conferenceEntity);
		ConferenceEntity conferenceFind(String c_id);
}
