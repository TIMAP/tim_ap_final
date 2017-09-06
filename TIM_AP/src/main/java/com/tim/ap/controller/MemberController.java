package com.tim.ap.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.tim.ap.entity.MemberEntity;
import com.tim.ap.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@RequestMapping("/list")
	public ModelAndView list(Locale locale) {
		logger.info("/member/list", locale);

		ModelAndView result = new ModelAndView();

		List<MemberEntity> memberList = memberService.getMemberList();

		result.addObject("result", memberList);
		result.setViewName("/member/list");

		return result;
	}

	@RequestMapping("/loginform")
	public ModelAndView loginForm(Locale locale) {
		System.out.println("로그인폼");
		logger.info("/member/login", locale);
		ModelAndView result = new ModelAndView();
		
		
		
		result.setViewName("/member/login");
		return result;
	}
	@RequestMapping(value="/login" , method=RequestMethod.POST)
	public ModelAndView login(Locale locale, MemberEntity member,HttpSession session) {
		logger.info("/member/login", locale);
		ModelAndView result = new ModelAndView();
		System.out.println("로그인");
		MemberEntity mem = memberService.getMember(member.getId());
		
		//sha알고리즘 형태로 변환시켜주는것.
		try {
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
		//
		result.addObject("failed", "true");
		if(mem != null){
			//member는 로그인폼에서 받아온 값이고, mem은 DB에 저장된 값을 가져온것.
			//비교후 넘어가거나 로그인이 안되있다면 다시 로그인창으로 보내는것.
			if(member.getPw().equals(mem.getPw())){
				result.setViewName("/audio/list");
				String name = mem.getName_first()+mem.getName_last();
				session.setAttribute("id", mem.getId());
				result.addObject("name", name);
			}
		}else{
			result.addObject("failed", "false");
			result.setViewName("/member/login");
		}
//		if(member.getId()==1&&member.getPw().equals("1")){
//			result.setViewName("/audio/list");
//		}else {
//			result.setViewName("/member/login");
//		}
//		MemberEntity mem = memberService.getMember(member.getId());
//		session.setAttribute("id", member.getId());
//		result.addObject("fname", mem.getName_first());
//		result.addObject("name", mem.getName_last());
//		result.addObject("email", mem.getEmail());
		//여기서 아이디 받아서 로그인하고 오디오 리스트페이지로
		return result;
	}
	
	/**
	 * 회원가입 폼으로 보내주는 컨트롤러
	 */
	@RequestMapping("/joinForm")
	public ModelAndView joinForm() {
		ModelAndView result = new ModelAndView();
		result.setViewName("/member/join");
		return result;
	}
	
	/**
	 *  회원가입 양식을 모두 쓴뒤 가입 버튼을 눌러 insert를 실행한뒤 다른 페이지로 넘어가는 컨트롤러 
	 */
	@RequestMapping("/join")
	public ModelAndView join(MemberEntity member) {
		ModelAndView result = new ModelAndView();
		memberService.insertMember(member);
		result.setViewName("redirect:/member/loginform");
		return result;
	}
}
