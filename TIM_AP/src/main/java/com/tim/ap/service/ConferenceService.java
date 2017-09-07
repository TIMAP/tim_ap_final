package com.tim.ap.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tim.ap.dao.ConferenceDao;
import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferListViewEntity;
import com.tim.ap.entity.ConferenceEntity;
import com.tim.ap.mapper.ConferenceMapper;

@Repository
public class ConferenceService implements ConferenceDao {

	@Autowired
	private SqlSession sqlSession;
	private static final int BOARD_COUNT_PER_PAGE = 5;

	@Override
	public ArrayList<ConferenceEntity> getConferenceList() {
		ArrayList<ConferenceEntity> result = new ArrayList<ConferenceEntity>();
		ConferenceMapper conferenceMapper = sqlSession.getMapper(ConferenceMapper.class);

		result = conferenceMapper.getConferenceList();

		return result;
	}

	@Override
	public void updateConference(ConferenceEntity conferenceEntity) {
		ConferenceMapper conferenceMapper = sqlSession.getMapper(ConferenceMapper.class);

		conferenceMapper.updateConference(conferenceEntity);
	}

	@Override
	public int insertConference(ConferenceEntity conferenceEntity) {
		ConferenceMapper conferenceMapper = sqlSession.getMapper(ConferenceMapper.class);
		
		int result = conferenceMapper.insertConference(conferenceEntity);
		
		return result;
		
	}

	@Override
	public ConferenceEntity selectConference() {
		ConferenceMapper conferenceMapper = sqlSession.getMapper(ConferenceMapper.class);

		ConferenceEntity conferenceEntity = new ConferenceEntity();

		conferenceEntity = conferenceMapper.selectConference();

		return conferenceEntity;
	}
	
	
}
