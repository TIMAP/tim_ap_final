package com.tim.ap.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tim.ap.dao.AudioDao;
import com.tim.ap.entity.AudioEntity;
import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.mapper.AudioMapper;

@Repository
public class AudioService implements AudioDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<AudioEntity> getAudioList(AudioEntity audioEntity) {
		ArrayList<AudioEntity> result = new ArrayList<AudioEntity>();
		AudioMapper audioMapper = sqlSession.getMapper(AudioMapper.class);

		result = audioMapper.getAudioList(audioEntity);

		return result;
	}

	@Override
	public void insertAudio(AudioEntity audioEntity) {
		AudioMapper audioMapper = sqlSession.getMapper(AudioMapper.class);

		audioMapper.insertAudio(audioEntity);
	}

	@Override
	public void updateAudio(AudioEntity audioEntity) {
		AudioMapper audioMapper = sqlSession.getMapper(AudioMapper.class);

		audioMapper.updateAudio(audioEntity);	
	}

	@Override
	public int selectAudioTotalCount(ConferListSelectEntity select) {
//		AudioMapper audioMapper = sqlSession.getMapper(AudioMapper.class);
//		return audioMapper.selectAudioTotalCount(select);
		System.out.println(select.getC_id());
		return sqlSession.selectOne("selectAudioTotalCount", select);
	}

	@Override
	public List<AudioEntity> selecAudiotList(int firstRow, int endRow,
			ConferListSelectEntity select) {
		int offset = firstRow - 1;
		int limit = endRow - firstRow + 1;
		RowBounds rowBounds = new RowBounds(offset, limit);
		System.out.println(select.getIndex());
		System.out.println(select.getVal());
		List<AudioEntity> audioList = sqlSession.selectList("selecAudiotList",select,rowBounds);
		System.out.println(audioList.size());
		return audioList;
	}

	@Override
	public int selectAudioListCount(ConferListSelectEntity select) {
		AudioMapper audioMapper = sqlSession.getMapper(AudioMapper.class);
		return audioMapper.selectAudioListCount(select);
	}

}
