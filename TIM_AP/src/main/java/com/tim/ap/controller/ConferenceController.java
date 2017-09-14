package com.tim.ap.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferListViewEntity;
import com.tim.ap.entity.ConferenceEntity;
import com.tim.ap.service.ConferenceService;

@Controller
@RequestMapping("/conference")
public class ConferenceController {
	private static final Logger logger = LoggerFactory.getLogger(ConferenceController.class);

	@Autowired
	private ConferenceService conferenceService;

	private static final int BOARD_COUNT_PER_PAGE = 5;//뿌려질 리스트갯수
	private static final int PAGE_NUMBER_COUNT_PER_PAGE = 5; //뿌려질 번호의 갯수
	
	@RequestMapping(value = "/join")
	public String loginForm() {
		return "/conference/join";
	}

	@RequestMapping("/create")
	public String createForm() {
		return "/conference/create";
	}

	@RequestMapping(value = "/list", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public @ResponseBody String list(Locale locale) {
		logger.info("/conference/list", locale);

		List<ConferenceEntity> conferenceList = conferenceService.getConferenceList();

		return new com.google.gson.Gson().toJson(conferenceList);
	}

	@RequestMapping(value = "/update", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public @ResponseBody String update(Locale locale, @RequestParam("id") int id) {
		logger.info("/conference/update", locale);

		ConferenceEntity conferenceEntity = new ConferenceEntity();

		conferenceEntity.setId(id);
		conferenceEntity.setClosed("Y");

		conferenceService.updateConference(conferenceEntity);

		return new com.google.gson.Gson().toJson(conferenceEntity);
	}
	
	@RequestMapping("/conferencelist")
	public @ResponseBody ModelAndView conferencelist(@RequestParam(value="page",defaultValue="1")int pageNumber,
			String val, String index) {
		ModelAndView result = new ModelAndView();
//		List<ConferenceEntity> conferenceList = conferenceService.getConferenceList();
		
		ConferListSelectEntity select = new ConferListSelectEntity();//검색조건과 값을 가진 Entity
		if(val!=null && !val.equals("")){// 처음 들어간 화면이 아닌 검색조건에 값을 입력한 경우 Entity에게 값을 넣어준다.
			select.setIndex(index);
			select.setVal(val);
		}
		ConferListViewEntity viewData = returnViewEntity(pageNumber, select);
		if(viewData.getPageTotalCount()>0){
			int beginPageNumber = (viewData.getCurrentPageNumber()-1)/PAGE_NUMBER_COUNT_PER_PAGE*PAGE_NUMBER_COUNT_PER_PAGE+1;
			int endPageNumber = beginPageNumber+ PAGE_NUMBER_COUNT_PER_PAGE-1;
			if(endPageNumber > viewData.getPageTotalCount()){
				endPageNumber = viewData.getPageTotalCount();
			}
			result.addObject("perPage", PAGE_NUMBER_COUNT_PER_PAGE);	//페이지 번호의 갯수
			result.addObject("end", viewData.getConferList().size()-1);//마지막 페이지getBoardList
			result.addObject("beginPage", beginPageNumber);	//보여줄 페이지 번호의 시작
			result.addObject("endPage", endPageNumber);		//보여줄 페이지 번호의 끝
		}
		result.addObject("select", select);//그리고 값을 가진 것으 ㄹ넣어준다.
		result.addObject("viewData", viewData);
		result.setViewName("/conference/conferencelist");
		return result;
	}
	
	/**
	 * 게시판의 값을 반환해주는 메서드 
	 */
	public ConferListViewEntity returnViewEntity(int pageNumber, ConferListSelectEntity select){
//		final int BOARD_COUNT_PER_PAGE = 3;
		int currentPageNumber = pageNumber; //페이지의 넘버를 갖고 있는 아이

		int selectConferenceTotalCount = conferenceService.selectConferenceTotalCount(); //총 갯수를 갖고 있는 아이
		System.out.println(select.getIndex());
		System.out.println(select.getVal());
		List<ConferenceEntity> boardList = null;
		int firstRow = 0;
		int endRow = 0;
		if (selectConferenceTotalCount > 0) {
			firstRow = (pageNumber - 1) * BOARD_COUNT_PER_PAGE + 1;
			endRow = firstRow + BOARD_COUNT_PER_PAGE - 1;
			boardList = conferenceService.selectList(firstRow, endRow, select);
			System.out.println("첫번째이프문"+selectConferenceTotalCount);
			if (select.getVal() != null && !select.getVal().equals("")) {
				selectConferenceTotalCount = conferenceService.selectListCount(select);
				System.out.println("두번째이프문"+selectConferenceTotalCount);
			}
		} else {
			currentPageNumber = 0;
			boardList = Collections.emptyList();
		}
		return new ConferListViewEntity(boardList, selectConferenceTotalCount,
				currentPageNumber, BOARD_COUNT_PER_PAGE, firstRow, endRow);
	}
	
	@RequestMapping("/conferenceUpdate")
	public @ResponseBody Map<String,Object> conferenceUpdate(@RequestParam(value="confer_chk[]")List<String> confer_chk){
		Map<String,Object> map = new HashMap<String,Object>();
		List<ConferenceEntity> conferenceList = new ArrayList<ConferenceEntity>();
		String[] value = null;
		for(int i = 0; i < confer_chk.size(); i++){
			ConferenceEntity confer = new ConferenceEntity();
			value = confer_chk.get(i).split("/");
			for(int j = 0; j < value.length; j++){
				System.out.println(value[j]);
				if(j%2 == 0){
					confer.setId(Integer.parseInt(value[j]));
					if(value[j+1].equals("N")){
						confer.setClosed("Y");
					}else{
						confer.setClosed("N");
					}
				}
			}
			conferenceList.add(confer);
		}
		for(int i = 0; i < conferenceList.size(); i++){
			System.out.println(conferenceList.size());
			System.out.println(conferenceList.get(i).getId()+"리스트에온 아이디");
			System.out.println(conferenceList.get(i).getClosed()+"리스트에온 상태");
		}
		conferenceService.conferenceInfoUpdate(conferenceList);
		map.put("uri", "/conference/conferencelist");
		return map;
	}
	
	@RequestMapping("/conferClosedUpdate")
	public void conferClosedUpdate(@RequestParam(value="c_id")String c_id){
		System.out.println(c_id+"값이들어오나?");
	}
}
