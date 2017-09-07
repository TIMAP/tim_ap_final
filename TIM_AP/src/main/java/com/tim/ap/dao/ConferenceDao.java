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
}
