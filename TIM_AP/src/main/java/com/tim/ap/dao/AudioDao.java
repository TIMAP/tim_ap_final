package com.tim.ap.dao;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.AudioEntity;
import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferenceEntity;

public interface AudioDao {
	public ArrayList<AudioEntity> getAudioList(AudioEntity audioEntity);
    public void insertAudio(AudioEntity audioEntity);
    public void updateAudio(AudioEntity audioEntity);
    //public void deleteAudio(AudioEntity audioEntity);
    
    //오디오리스트 출력부분
	public int selectAudioTotalCount(ConferListSelectEntity select);//리스트의 전체 갯수를 구해주는 메서드
	public List<AudioEntity> selecAudiotList(int firstRow, int endRow, ConferListSelectEntity select);//검색될 리스트를 반환해주는 메서드
	public int selectAudioListCount(ConferListSelectEntity select);//검색된 갯수를 반환해주는 메서드
}
