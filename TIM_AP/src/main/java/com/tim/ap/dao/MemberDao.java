package com.tim.ap.dao;

import java.io.File;
import java.util.ArrayList;

import org.springframework.web.servlet.ModelAndView;

import com.tim.ap.entity.MemberEntity;

public interface MemberDao {
    public ArrayList<MemberEntity> getMemberList();
    public void insertMember(MemberEntity member);
    //public void updateMember(MemberEntity member);
    //public void deleteMember(MemberEntity member);
    public void excelUpload(File destFile);

	public MemberEntity getMember(int id);
}
