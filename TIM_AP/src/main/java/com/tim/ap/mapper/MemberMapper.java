package com.tim.ap.mapper;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.MemberEntity;

public interface MemberMapper {
	    ArrayList<MemberEntity> getMemberList();
	    MemberEntity getMember(int id);
	    void insertMember(MemberEntity memberEntity);
	    void excelUpload(List<MemberEntity> memberList);
	    void updateMember(String id);
	    void deleteMember(String id);
}
