package com.tim.ap.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
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

	//전체 갯수를 반환하는 메서드
	@Override
	public int selectConferenceTotalCount() {
		return sqlSession.selectOne("selectConferenceTotalCount");
	}
	
	//검색될 리스트를 반환해주는 메서드
	@Override
	public List<ConferenceEntity> selectList(int firstRow, int endRow,
			ConferListSelectEntity select) {
		int offset = firstRow - 1;
		int limit = endRow - firstRow + 1;
		RowBounds rowBounds = new RowBounds(offset, limit);
		System.out.println(select.getIndex());
		System.out.println(select.getVal());
		List<ConferenceEntity> boardList = sqlSession.selectList("selectConferenceList",select,rowBounds);
		return boardList;
	}

	@Override
	public int selectListCount(ConferListSelectEntity select) {
		return sqlSession.selectOne("selectListCount",select);
	}

	@Override
	public void conferenceInfoUpdate(List<ConferenceEntity> conferList) {
		ConferenceMapper conferenceMapper = sqlSession.getMapper(ConferenceMapper.class);
		for(int i = 0; i < conferList.size(); i++){
			conferenceMapper.conferenceInfoUpdate(conferList.get(i));
		}
	}

	@Override
	public ConferenceEntity conferenceFind(int c_id) {
		ConferenceMapper conferenceMapper = sqlSession.getMapper(ConferenceMapper.class);
		
		ConferenceEntity conferenceEntity = conferenceMapper.conferenceFind(c_id);
		
		return conferenceEntity;
	}
	
	
}
