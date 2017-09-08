package com.tim.ap.mapper;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.ConferenceEntity;
import com.tim.ap.entity.MemberEntity;

public interface MemberMapper {
	    ArrayList<MemberEntity> getMemberList();
	    MemberEntity getMember(int id);
	    void insertMember(MemberEntity memberEntity);
	    void excelUpload(List<MemberEntity> memberList);
	    void updateMember(String id);
	    void deleteMember(String id);
	    
	    
	    int selectConferenceTotalCount();//리스트의 갯수를 반환하는 메서드
}
