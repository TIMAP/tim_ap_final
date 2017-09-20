package com.tim.ap.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.tim.ap.entity.MemberEntity;

public interface MemberDao {
    public ArrayList<MemberEntity> getMemberList();
    public void insertMember(MemberEntity member);
    //public void updateMember(MemberEntity member);
    //public void deleteMember(MemberEntity member);
    public void excelUpload(List<MemberEntity> memberList);
    public void csvInsert(List<MemberEntity> memberList);
    ArrayList<MemberEntity> checkExist(List<MemberEntity> memberList);
	public MemberEntity getMember(int id);
	public void deleteMember(MemberEntity member);
	public void updateMember(MemberEntity member);
}
