package com.tim.ap.service;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.tim.ap.dao.MemberDao;
import com.tim.ap.entity.MemberEntity;
import com.tim.ap.mapper.MemberMapper;
import com.tim.ap.util.ExcelRead;
import com.tim.ap.util.ExcelReadOption;

@Repository
public class MemberService implements MemberDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<MemberEntity> getMemberList() {
		ArrayList<MemberEntity> result = new ArrayList<MemberEntity>();
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);

		result = memberMapper.getMemberList();

		return result;
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
	public void excelUpload(File destFile){
		MemberMapper userMapper = sqlSession.getMapper(MemberMapper.class);
		ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H");
        excelReadOption.setStartRow(2);
        
        
        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
        List<MemberEntity> memberList = new ArrayList<MemberEntity>();
        
        
        for(Map<String, String> article: excelContent){
        	
        	MemberEntity memberEntity = new MemberEntity();
        	
        	memberEntity.setId(Integer.parseInt(article.get("A")));
        	memberEntity.setEmail(article.get("B"));
        	memberEntity.setPw(article.get("C"));
        	memberEntity.setName_last(article.get("D"));
        	memberEntity.setName_first(article.get("E"));
        	memberEntity.setRole(article.get("F").charAt(0));
        	memberEntity.setAuth(article.get("G").charAt(0));
        	memberEntity.setDisable(article.get("H").charAt(0));
        	
        	memberList.add(memberEntity);
            System.out.println("여기 오세요 ?");
        }
        
        userMapper.excelUpload(memberList);

}
}
