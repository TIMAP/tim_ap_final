package com.tim.ap.mapper;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.AudioEntity;
import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferenceEntity;

public interface AudioMapper {
		ArrayList<AudioEntity> getAudioList(AudioEntity audioEntity);
	    void insertAudio(AudioEntity audioEntity);
	    void updateAudio(AudioEntity audioEntity);
	    //void deleteAudio(AudioEntity audioEntity);
	    
	    int selectAudioTotalCount(ConferListSelectEntity select);//리스트의 갯수를 반환하는 메서드
	    List<AudioEntity> selecAudiotList(int firstRow, int endRow,
				ConferListSelectEntity select);
	    int selectAudioListCount(ConferListSelectEntity select);
}
