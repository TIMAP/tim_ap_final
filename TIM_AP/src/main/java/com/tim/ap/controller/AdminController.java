package com.tim.ap.controller;



import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tim.ap.entity.AudioEntity;
import com.tim.ap.entity.AudioListViewEntity;
import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.MemberEntity;
import com.tim.ap.entity.PaginationInfoEntity;
import com.tim.ap.service.AudioService;
import com.tim.ap.service.MemberService;


@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AudioService audioService;

	@RequestMapping("/loginForm")
	public ModelAndView loginForm(Locale locale, boolean deleteResult) {
		System.out.println("admin로그인폼");
		logger.info("/admin/loginForm", locale);
		ModelAndView result = new ModelAndView();
		result.setViewName(	"/admin/adminlogin");
		return result;
	}
	
	/** 화이팅합시다
	 * 로그인 정보를 입력후 아이디와 비밀번호가 존재시 메인화면으로 넘어가고
	 * 없으면 다시 로그인폼으로 돌아가며 비밀번호나 아이디가 틀릴경우 알럿메세지를 가지고 돌아간다. 
	 */
	@RequestMapping(value="/adminlogin" , method=RequestMethod.POST)
	public @ResponseBody ModelAndView login(Locale locale,MemberEntity member,HttpSession session) {
		logger.info("/admin/adminlogin", locale);
		ModelAndView result = new ModelAndView();
		MemberEntity admin = memberService.getMember(member.getId());
		System.out.println(member.getId());
		if(admin == null){
			result.addObject("failed", "false");
			result.addObject("msg", "가입하지 않은 관리자 입니다.");
			result.setViewName("/admin/loginForm");
		}else{
//		try {
//			MessageDigest md = MessageDigest.getInstance("SHA-512"); 
//			md.update(member.getPw().getBytes()); 
//			byte byteData[] = md.digest();
//			
//			StringBuffer sb = new StringBuffer(); 
//			for(int i=0; i<byteData.length; i++) {
//				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
//			}
//			
//			String retVal = sb.toString();
//			System.out.println(retVal); 
//			member.setPw(retVal);
//		} catch(NoSuchAlgorithmException e){
//			e.printStackTrace(); 
//		}
		if(admin.getId()==member.getId()){
			if(member.getPw().equals(admin.getPw())){
				if(admin.getRole()=='Y'){
				System.out.println("맞음");
				String name = admin.getName_first()+admin.getName_last();
				session.setAttribute("id", admin.getId());
				session.setAttribute("name", name);
				result.addObject("name", name);
				result.setViewName("/admin/adminPage");
				}else{
					boolean msg = false;
					result.addObject("failed",msg);
					result.addObject("msg", "접근 권한이 없습니다 ");
					result.setViewName("/admin/loginForm");
				}
			}else{
				boolean msg = false;
				result.addObject("msg", "접근 권한이 없습니다");
				result.addObject("failed",msg);
				result.setViewName("/admin/loginForm");
			}
			}else{
				boolean msg = false;
				result.addObject("msg", "접근 권한이 없습니다");
				result.addObject("failed",msg);
				result.setViewName("/member/login");
			}
		}
		return result;
	}

	/**
	 * adminPage로 가는 컨트롤러
	 */
	@RequestMapping("/adminpage")
	public ModelAndView main(HttpSession session, RedirectAttributes redirectAttributes){
		ModelAndView result = new ModelAndView();
		result.addObject("failed", "true");
		int id = 0;
		if(session.getAttribute("id") != null){ //세션에 아이디가 있을 경우  id변수에 세션에 담긴 id를 담아준다.
			id = (int) session.getAttribute("id");
		}
		if(id == 0){//세션에 id가 담기지 않은 경우 id변수는 0이기 때문에, 로그인한 상태가 아니므로 로그인폼으로 보낸다 그리고 msg를 가지고 가서 alert를 띄어준다.
			boolean msg = false;
			redirectAttributes.addFlashAttribute("failed", msg);
			redirectAttributes.addFlashAttribute("msg", "로그인을 해주세요.");
			result.setViewName("redirect:/member/loginform");
		}else{
			System.out.println(session.getAttribute("name"));
			result.setViewName("admin/adminPage");// 로그인한 상태에서 main 즉 홈화면으로 가게 될경우 바로 보내주는 것.
		}
		return result;
	}
	
//	회원 리스트 
	@RequestMapping("/memList")
	public ModelAndView list(Locale locale,
	        @RequestParam(required=false) String searchType, 
	        @RequestParam(required=false) String searchWord,
			@RequestParam(required=false, defaultValue="1") int page) {
		logger.info("/admin/memList", locale);
		ModelAndView result = new ModelAndView();
		PaginationInfoEntity<MemberEntity> pagingEntity = new PaginationInfoEntity<MemberEntity>();
		pagingEntity.setCurrentPage(page);
		pagingEntity.setSearchType(searchType);
		if(searchWord == null){
			searchWord = "";
		}
		pagingEntity.setSearchWord(searchWord);
		
		List<MemberEntity> memberList = memberService.getMemberList(pagingEntity);
		pagingEntity.setDataList(memberList);
		pagingEntity.setTotalRecords(memberService.selectMemberListTotalCount(pagingEntity));
		result.addObject("result", pagingEntity);
		result.setViewName("member/list");

		return result;
	}
	
	
	/**
	 * 회원 정보 수정 폼 이동
	 */
	@RequestMapping("/memberInfo")
	public ModelAndView userInfo(MemberEntity member){
		ModelAndView result = new ModelAndView();
		MemberEntity mem = memberService.getMember(member.getId());
		result.addObject("mem", mem);
		result.setViewName("/admin/memberManagement");
		return result;
	}
	
	/**
	 * 회원 정보 수정 메서드(회원 쪽 자기 정보 수정과 같은 메서드 이용)
	 * @param member
	 * @return ModelAndView
	 */
	@RequestMapping("/memberManagement")
	public ModelAndView memberUpdate(MemberEntity member){
		ModelAndView result = new ModelAndView();
		memberService.managementMember(member);
		result.setViewName("redirect:/admin/memList");
		return result;
	}
}
