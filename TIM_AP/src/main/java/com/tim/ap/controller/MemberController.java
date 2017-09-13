package com.tim.ap.controller;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
	public ModelAndView loginForm(Locale locale, boolean deleteResult) {
		System.out.println("로그인폼");
		logger.info("/member/login", locale);
		ModelAndView result = new ModelAndView();
		if(deleteResult == true){
			boolean msg = false;
			result.addObject("failed", msg);
			result.addObject("msg", "정상적으로 탈퇴가 되었습니다.");
		}
		result.setViewName("/member/login");
		return result;
	}
	
	/**
	 * 로그인 정보를 입력후 아이디와 비밀번호가 존재시 메인화면으로 넘어가고
	 * 없으면 다시 로그인폼으로 돌아가며 비밀번호나 아이디가 틀릴경우 알럿메세지를 가지고 돌아간다. 
	 */
	@RequestMapping(value="/login" , method=RequestMethod.POST)
	public @ResponseBody ModelAndView login(Locale locale, MemberEntity member,HttpSession session) {
		logger.info("/member/login", locale);
		ModelAndView result = new ModelAndView();
		String yesOrNo = "";
		MemberEntity mem = memberService.getMember(member.getId());
		if(mem == null){
			result.addObject("failed", "false");
			result.addObject("msg", "가입하지 않은 회원 입니다.");
			result.setViewName("/member/login");
		}else{
			yesOrNo = mem.getDisabled()+"";
			if(yesOrNo.equals("N")){
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
						result.setViewName("/member/main");
						String name = mem.getName_first()+mem.getName_last();
						
						session.setAttribute("id", mem.getId());
						session.setAttribute("name", name);
						result.addObject("name", name);
					}else{
						result.addObject("failed", "false");
						result.addObject("msg", "아이디 또는 비밀번호가 틀렸습니다.");
						result.setViewName("/member/login");
					}
				}
			}else{
				result.addObject("failed", "false");
				result.addObject("msg", "탈퇴한 회원입니다.");
				result.setViewName("/member/login");
			}
		}
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
	
	/**
	 * 로그아웃
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session){
		ModelAndView result = new ModelAndView();
		session.invalidate();
		result.setViewName("redirect:/member/loginform");
		return result;
	}
	
	/**
	 * 메인화면으로 가는 컨트롤러
	 */
	@RequestMapping("/main")
	public ModelAndView main(HttpSession session, RedirectAttributes redirectAttributes){
		ModelAndView result = new ModelAndView();
		result.addObject("failed", "true");
		int id = 0;
		System.out.println("1");
		if(session.getAttribute("id") != null){ //세션에 아이디가 있을 경우  id변수에 세션에 담긴 id를 담아준다.
			System.out.println("2");
			id = (int) session.getAttribute("id");
		}
		if(id == 0){//세션에 id가 담기지 않은 경우 id변수는 0이기 때문에, 로그인한 상태가 아니므로 로그인폼으로 보낸다 그리고 msg를 가지고 가서 alert를 띄어준다.
			System.out.println("3");
			boolean msg = false;
			redirectAttributes.addFlashAttribute("failed", msg);
			redirectAttributes.addFlashAttribute("msg", "로그인을 해주세요.");
			result.setViewName("redirect:/member/loginform");
		}else{
			System.out.println("4");
			System.out.println(session.getAttribute("name"));
			result.setViewName("/member/main");// 로그인한 상태에서 main 즉 홈화면으로 가게 될경우 바로 보내주는 것.
		}
		return result;
	}
	
	/**
	 * 사용자 개인정보 수정폼
	 * header쪽에 있는 id를 클릭시 member객체로 받아와 id로 그 사용자의 정보를 갖고온뒤, modelandview에 담아서 jsp로 보내준다.
	 */
	@RequestMapping("/userInfo")
	public ModelAndView userInfo(MemberEntity member){
		ModelAndView result = new ModelAndView();
		MemberEntity mem = memberService.getMember(member.getId());
		result.addObject("mem", mem);
		result.setViewName("/member/memberInfo");
		return result;
	}
	
	/**
	 * 개인정보의 값을 받아서 Update를 해주는 컨트롤러
	 * jsp에서 모든 값을 받지만 실제 변경되는 값은 비밀번호 하나의 값만 변경될 것이기 때문에 service에 접근시 password만 가지고 갈것이다.
	 */
	@RequestMapping("/memberUpdate")
	public ModelAndView memberUpdate(MemberEntity member){
		ModelAndView result = new ModelAndView();
		memberService.updateMember(member);
		result.setViewName("/member/main");
		return result;
	}
	
	/**
	 * 회원탈퇴시 id의 값을 받은 뒤 해당 사용자의 테이블에 DISABLED의 값을 변경해준다.  
	 * 우선 수정하는 쿼리문은 만들어놨지만 삭제쿼리문으로 대체함.
	 */
	@RequestMapping("/memberDelete")
	public @ResponseBody Map<String,String> memberDelete(MemberEntity member, HttpSession session){
		Map<String,String> resultMap = new HashMap<String, String>();
		memberService.deleteMember(member);
		session.invalidate();
		boolean deleteResult = true;
		resultMap.put("uri", "/member/loginform?deleteResult="+deleteResult);
		return resultMap;
	}
	
	
	@RequestMapping("/excel")
	public ModelAndView excelForm() {
		
		ModelAndView result = new ModelAndView();
		
		result.setViewName("/member/excel");
		return result;
	}

	@ResponseBody
    @RequestMapping(value = "/excelUploadAjax", method = RequestMethod.POST)
    public ModelAndView excelUploadAjax(MultipartHttpServletRequest request)  throws Exception{
        MultipartFile excelFile =request.getFile("excelFile");
        System.out.println("엑셀 파일 업로드 컨트롤러");
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }
        
        File destFile = new File("D:\\"+excelFile.getOriginalFilename());
        try{
            excelFile.transferTo(destFile);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }
        
        memberService.excelUpload(destFile);
        
        
        ModelAndView view = new ModelAndView();
        view.setViewName("/member/excel");
        return view;
    }
	
	
}
