package com.tim.ap.dao;

import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.MemberEntity;
import com.tim.ap.entity.PaginationInfoEntity;

public interface MemberDao {
	public ArrayList<MemberEntity> getMemberList(PaginationInfoEntity pagingEntity);
    public int selectMemberListTotalCount(PaginationInfoEntity pagingEntity);//리스트의 전체 갯수를 구해주는 메서드
    public void insertMember(MemberEntity member);
    //public void updateMember(MemberEntity member);
    //public void deleteMember(MemberEntity member);
    public void excelUpload(List<MemberEntity> memberList);
    public void csvInsert(List<MemberEntity> memberList);
    ArrayList<MemberEntity> checkExist(List<MemberEntity> memberList);
	public MemberEntity getMember(int id);
	public void deleteMember(MemberEntity member);
	public void updateMember(MemberEntity member);
	public void managementMember(MemberEntity member);
}