package com.tim.ap.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tim.ap.dao.MemberDao;
import com.tim.ap.entity.MemberEntity;
import com.tim.ap.entity.PaginationInfoEntity;
import com.tim.ap.mapper.MemberMapper;

@Repository
public class MemberService implements MemberDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<MemberEntity> getMemberList(PaginationInfoEntity pagingEntity) {
		ArrayList<MemberEntity> result = new ArrayList<MemberEntity>();
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);

		result = memberMapper.getMemberList(pagingEntity);

		return result;
	}
	
	@Override
	public int selectMemberListTotalCount(PaginationInfoEntity pagingEntity) {
		return sqlSession.selectOne("selectMemberListTotalCount",pagingEntity);

	}
	
	@Override
	public MemberEntity getMember(int id){
		MemberEntity result = new MemberEntity();
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		
		result = memberMapper.getMember(id);
		
		return result;
	}

	@Override
	public void insertMember(MemberEntity member) {
		try {
			//sha알고리즘 형태로 변환시켜주는것.
            MessageDigest md = MessageDigest.getInstance("SHA-512"); 
            md.update(member.getPw().getBytes()); 
            byte byteData[] = md.digest();
 
            StringBuffer sb = new StringBuffer(); 
            for(int i=0; i<byteData.length; i++) {
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
 
            String retVal = sb.toString();
            System.out.println(retVal); 
            member.setPw(retVal);
        } catch(NoSuchAlgorithmException e){
            e.printStackTrace(); 
        }
		sqlSession.insert("insertMember", member);
	}
	
	@Override
	public void updateMember(MemberEntity member) {
		try {
			//sha알고리즘 형태로 변환시켜주는것.
            MessageDigest md = MessageDigest.getInstance("SHA-512"); 
            md.update(member.getPw().getBytes()); 
            byte byteData[] = md.digest();
 
            StringBuffer sb = new StringBuffer(); 
            for(int i=0; i<byteData.length; i++) {
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
 
            String retVal = sb.toString();
            System.out.println(retVal); 
            member.setPw(retVal);
        } catch(NoSuchAlgorithmException e){
            e.printStackTrace(); 
        }
		sqlSession.insert("updateMember", member);
	}

	@Override
	public void deleteMember(MemberEntity member) {
		sqlSession.delete("deleteMember", member);
	}
	
	
	
	@Override
	public void excelUpload(List<MemberEntity> memberList){
		MemberMapper userMapper = sqlSession.getMapper(MemberMapper.class);
		
        userMapper.excelUpload(memberList);

	}

	@Override
	public void csvInsert(List<MemberEntity> memberList) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		
		memberMapper.csvInsert(memberList);
		
	}

	@Override
	public ArrayList<MemberEntity> checkExist(List<MemberEntity> memberList) {
		
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		
		ArrayList<MemberEntity> checkList = (ArrayList<MemberEntity>)memberMapper.checkExist(memberList);
		
		return checkList;
	}

	@Override
	public void managementMember(MemberEntity member) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		
			try {
				//sha알고리즘 형태로 변환시켜주는것.
	            MessageDigest md = MessageDigest.getInstance("SHA-512"); 
	            md.update(member.getPw().getBytes()); 
	            byte byteData[] = md.digest();
	 
	            StringBuffer sb = new StringBuffer(); 
	            for(int i=0; i<byteData.length; i++) {
	                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
	            }
	 
	            String retVal = sb.toString();
	            member.setPw(retVal);
	        } catch(NoSuchAlgorithmException e){
	            e.printStackTrace(); 
	        }
			memberMapper.managementMember(member);
	}
	
	@Override
	public void addMember(MemberEntity member) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		try {
			//sha알고리즘 형태로 변환시켜주는것.
            MessageDigest md = MessageDigest.getInstance("SHA-512"); 
            md.update(member.getPw().getBytes()); 
            byte byteData[] = md.digest();
 
            StringBuffer sb = new StringBuffer(); 
            for(int i=0; i<byteData.length; i++) {
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
 
            String retVal = sb.toString();
            System.out.println(retVal); 
            member.setPw(retVal);
        } catch(NoSuchAlgorithmException e){
            e.printStackTrace(); 
        }
		
		memberMapper.addMember(member);
	}
}
