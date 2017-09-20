package com.tim.ap.mapper;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.MemberEntity;
import com.tim.ap.entity.PaginationInfoEntity;

public interface MemberMapper {
		ArrayList<MemberEntity> getMemberList(PaginationInfoEntity pagingEntity);
		int selectConferenceTotalCount(PaginationInfoEntity pagingEntity);//리스트의 갯수를 반환하는 메서드
	    MemberEntity getMember(int id);
	    void insertMember(MemberEntity memberEntity);
	    void excelUpload(List<MemberEntity> memberList);
	    void csvInsert(List<MemberEntity> memberList);
	    ArrayList<MemberEntity> checkExist(List<MemberEntity> memberList);
	    void updateMember(String id);
	    void deleteMember(String id);
	    
	    
	    int selectConferenceTotalCount();//리스트의 갯수를 반환하는 메서드
}
