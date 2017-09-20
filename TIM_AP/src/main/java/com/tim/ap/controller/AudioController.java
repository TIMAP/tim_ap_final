package com.tim.ap.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.apache.commons.fileupload.FileUploadException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tim.ap.CommendProcess;
import com.tim.ap.OutputString;
import com.tim.ap.entity.AudioEntity;
import com.tim.ap.entity.AudioListViewEntity;
import com.tim.ap.entity.ConferListSelectEntity;
import com.tim.ap.entity.ConferListViewEntity;
import com.tim.ap.entity.ConferenceEntity;
import com.tim.ap.entity.MemberEntity;
import com.tim.ap.service.AudioService;
import com.tim.ap.service.ConferenceService;
import com.tim.ap.service.MemberService;
import com.tim.ap.util.FileTool;
import com.tim.ap.util.UniqueFileIdGenerator;

@Controller
@RequestMapping("/audio")
public class AudioController {
	private static final Logger logger = LoggerFactory.getLogger(AudioController.class);

	@Autowired
	private AudioService audioService;

	@Autowired
	private ConferenceService conferenceService;

	@Autowired
	private MemberService memberService;

	private static final int BOARD_COUNT_PER_PAGE = 3;// 한번에 보여줄 갯수
	private static final int PAGE_NUMBER_COUNT_PER_PAGE = 5; // 번호의 갯수

	// 서버 프로세스 구동에 필요한 변수
	public String filetemppath = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/converter/wavtemp";
	public String uploadpath = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/converter/wavfile/";
	public String downloadpath = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/converter/wavInfo/";
	public String command = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/converter/conv.sh";
	public String mlfpath = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/result/TEST_MT_N1_n0.mlf2.org";
	public String run = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/11_MT_list.dnn_gpu.sh";
	public String clean = "/home/speech/20161012/2016Jul06_ASR_Package_8k_DNN_support/STT/clean.sh";

	@RequestMapping("/form")
	public ModelAndView main(Locale locale) {
		logger.info("/audio/form", locale);

		ModelAndView result = new ModelAndView();

		result.setViewName("/audio/form");
		return result;
	}

	@RequestMapping("/update")
	public ModelAndView update(Locale locale, @RequestParam("multipartFile") List<MultipartFile> multipartFiles,
			ConferenceEntity conferenceEntity, HttpSession session) throws IOException, UnsupportedAudioFileException {
		logger.info("/audio/upload", locale);

		File file = convert(multipartFiles.get(0));

		AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(file);
		AudioFormat format = audioInputStream.getFormat();
		long audioFileLength = file.length();
		int frameSize = format.getFrameSize();
		float frameRate = format.getFrameRate();
		float durationInSeconds = (audioFileLength / (frameSize * frameRate));
		int playTime = (int) durationInSeconds;
		System.out.println("몇초? ->" + playTime + "초");

		int conferenceId = conferenceService.selectConference().getId();

		try {
			if (multipartFiles != null && multipartFiles.size() != 0) {
				// 경로 설정을 직접 정해 주었습니다.
				String uploadTempRootPath = "C:/tim/tim_ap_final/TIM_AP/src/main/webapp/resources/audio";
				System.out.println(uploadTempRootPath);

				if (!FileTool.isExistsDirectory(uploadTempRootPath)) {
					FileTool.makeDirectory(uploadTempRootPath);
				}

				String uploadTempFilePath = uploadTempRootPath + File.separator
						+ UniqueFileIdGenerator.getUniqueFileId();
				FileTool.makeDirectory(uploadTempFilePath);
				String lastPath = "";
				for (int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);

					if (!multipartFile.isEmpty()) {
						AudioEntity audioDataEntity = new AudioEntity();

						audioDataEntity.setMultipartFile(multipartFile);

						byte[] bytes = multipartFile.getBytes();

						// tepFileName을 회의 아이디와 날짜로 저장
						String tempFileName = conferenceId + " " + dateMaker() + " "
								+ UniqueFileIdGenerator.getUniqueFileId() + ".wav";

						File uploadFile = new File(uploadTempFilePath + File.separator + tempFileName);
						lastPath = uploadTempFilePath + File.separator + tempFileName;
						BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadFile));

						stream.write(bytes);
						stream.close();

						logger.info("/audio/upload : Upload File Location : " + uploadFile.getAbsolutePath());
					} else {
						throw new FileUploadException();
					}
				}
				// 오디오 파일 업로드
				AudioEntity audioEntity = new AudioEntity();

				String playTimeFormatter = String.format("%06d", playTime);

				audioEntity.setC_id(conferenceId);
				MemberEntity member = memberService.getMember((Integer) session.getAttribute("id"));
				audioEntity.setM_email(member.getEmail());
				audioEntity.setTime_beg("000000");
				audioEntity.setTime_end(playTimeFormatter);
				audioEntity.setAd_text("리눅스안들리고 그냥 셈플로 너어놈");
				audioEntity.setAd_wav_filepath(lastPath);
				audioEntity.setAd_download_cnt(0);

				audioService.insertAudio(audioEntity);
				System.out.println(file.lastModified());

			}
		} catch (FileUploadException fe) {
			fe.printStackTrace();
			logger.error("/audio/upload", "File Upload Error");
		} catch (Exception e) {
			logger.error("/audio/upload", "Error");
			e.printStackTrace();
		}
		return done(locale);
	}

	@RequestMapping("/upload")
	public ModelAndView upload(Locale locale, @RequestParam("multipartFile") List<MultipartFile> multipartFiles,
			ConferenceEntity conferenceEntity, HttpSession session) throws IOException, UnsupportedAudioFileException {
		logger.info("/audio/upload", locale);

		System.out.println(
				"FileSize = " + multipartFiles.get(0).getSize() + " // FileName = " + multipartFiles.get(0).getName());
		System.out.println(conferenceEntity);

		File file = convert(multipartFiles.get(0));

		AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(file);
		AudioFormat format = audioInputStream.getFormat();
		long audioFileLength = file.length();
		int frameSize = format.getFrameSize();
		float frameRate = format.getFrameRate();
		float durationInSeconds = (audioFileLength / (frameSize * frameRate));
		int playTime = (int) durationInSeconds;
		System.out.println("몇초? ->" + playTime + "초");

		conferenceService.insertConference(conferenceEntity);

		int conferenceId = conferenceService.selectConference().getId();

		try {
			if (multipartFiles != null && multipartFiles.size() != 0) {

				// 경로 설정을 직접 정해 주었습니다.
				String uploadTempRootPath = "C:/tim/tim_ap_final/TIM_AP/src/main/webapp/resources/audio";
				System.out.println(uploadTempRootPath);

				if (!FileTool.isExistsDirectory(uploadTempRootPath)) {
					FileTool.makeDirectory(uploadTempRootPath);
				}

				String uploadTempFilePath = uploadTempRootPath + File.separator
						+ UniqueFileIdGenerator.getUniqueFileId();
				FileTool.makeDirectory(uploadTempFilePath);
				String lastPath = "";
				for (int i = 0; i < multipartFiles.size(); i++) {
					MultipartFile multipartFile = multipartFiles.get(i);

					if (!multipartFile.isEmpty()) {
						AudioEntity audioDataEntity = new AudioEntity();

						audioDataEntity.setMultipartFile(multipartFile);

						byte[] bytes = multipartFile.getBytes();

						// tepFileName을 회의 아이디와 날짜로 저장
						String tempFileName = conferenceId + " " + dateMaker() + " "
								+ UniqueFileIdGenerator.getUniqueFileId() + ".wav";

						File uploadFile = new File(uploadTempFilePath + File.separator + tempFileName);
						lastPath = uploadTempFilePath + File.separator + tempFileName;
						BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadFile));

						stream.write(bytes);
						stream.close();

						logger.info("/audio/upload : Upload File Location : " + uploadFile.getAbsolutePath());
					} else {
						throw new FileUploadException();
					}
				}

				// 오디오 파일 업로드
				AudioEntity audioEntity = new AudioEntity();

				String playTimeFormatter = String.format("%06d", playTime);
				audioEntity.setC_id(conferenceId);
				MemberEntity member = memberService.getMember((Integer) session.getAttribute("id"));
				System.out.println(member.getEmail());
				audioEntity.setM_email(member.getEmail());
				audioEntity.setTime_beg("000000");
				audioEntity.setTime_end(playTimeFormatter);
				audioEntity.setAd_text("리눅스안들리고 그냥 셈플로 너어놈");
				audioEntity.setAd_wav_filepath(lastPath);
				audioEntity.setAd_download_cnt(0);

				audioService.insertAudio(audioEntity);
				System.out.println(file.lastModified());
				// ==============================test=======================

				File uploadTempDirectory = new File(uploadTempFilePath);

				if (!uploadTempDirectory.isDirectory()) {
					throw new FileUploadException();
				}

				String uploadRealRootPath = "/usr/local/ap/data/";

				File[] uploadTempFileList = uploadTempDirectory.listFiles();

				for (int i = 0; i < uploadTempFileList.length; i++) {
					File uploadTempFile = uploadTempFileList[i];
					String uploadTempFileName = uploadTempFile.getName().substring(0,
							uploadTempFile.getName().lastIndexOf("."));
					String uploadTempFileExtention = uploadTempFile.getName()
							.substring(uploadTempFile.getName().lastIndexOf(".") + 1);
					String uploadRealFilePath = uploadRealRootPath;

					if ("WAV".equals(uploadTempFileExtention.toUpperCase())) {
						String uploadTempFileNameArray[] = uploadTempFileName.split("_");

						for (int j = 0; j < uploadTempFileNameArray.length - 1; j++) {
							uploadRealFilePath = uploadRealFilePath + uploadTempFileNameArray[j] + File.separator;

							if (!FileTool.isExistsDirectory(uploadRealFilePath)) {
								FileTool.makeDirectory(uploadRealFilePath);
							}
						}

						String sttPath = uploadpath;

						// 프로세스 생성 후 클린(이전파일 데이터 삭제)
						CommendProcess cp = new CommendProcess();
						cp.commend(clean);

						FileTool.copy(uploadTempFile.getAbsolutePath(), sttPath + uploadTempFile.getName());
						FileTool.copy(uploadTempFile.getAbsolutePath(), uploadRealRootPath + uploadTempFile.getName());

						logger.info("/audio/upload : Move File Location : " + uploadRealFilePath
								+ uploadTempFile.getName());

						cp.commend(command);
						cp.commendSTT(run);

						OutputString out = new OutputString();
						String output = out.output(mlfpath);

						System.out.println(output);

						audioEntity.setC_id(conferenceId);
						audioEntity.setM_email("sysadmin");
						audioEntity.setTime_beg("000000");
						audioEntity.setTime_end(playTimeFormatter);
						audioEntity.setAd_text(output);
						audioEntity.setAd_wav_filepath(uploadTempFile.getName());
						audioEntity.setAd_download_cnt(0);

						audioService.insertAudio(audioEntity);
					}
				}
			}
		} catch (FileUploadException fe) {
			fe.printStackTrace();
			logger.error("/audio/upload", "File Upload Error");
		} catch (Exception e) {
			logger.error("/audio/upload", "Error");
			e.printStackTrace();
		}

		return done(locale);
	}

	public ModelAndView done(Locale locale) {
		logger.info("/audio/done", locale);
		List<AudioEntity> AudioDataList = null;

		ModelAndView result = new ModelAndView();

		result.addObject("result", AudioDataList);
		result.setViewName("/audio/done");

		return result;
	}

	// jsp로 만듬
	@RequestMapping(value = "/list", produces = "text/plain;charset=UTF-8", method = RequestMethod.GET)
	public @ResponseBody ModelAndView listPost(Locale locale, @RequestParam(value="c_id" ,defaultValue="0") int c_id,
			@RequestParam(value = "page", defaultValue = "1") int pageNumber, String val, String index) {
		logger.info("/audio/list", locale);

		AudioEntity audioEntity = new AudioEntity();
		audioEntity.setC_id(c_id);

		ModelAndView result = new ModelAndView();
		ConferListSelectEntity select = new ConferListSelectEntity();// 검색조건과 값을 가진 Entity
		select.setC_id(c_id);
		if (val != null && !val.equals("")) {// 처음 들어간 화면이 아닌 검색조건에 값을 입력한 경우 Entity에게 값을 넣어준다.
			select.setIndex(index);
			select.setVal(val);
			select.setC_id(c_id);
		}
		AudioListViewEntity viewData = returnViewEntity(pageNumber, select);
		if (viewData.getPageTotalCount() > 0) {
			int beginPageNumber = (viewData.getCurrentPageNumber() - 1) / PAGE_NUMBER_COUNT_PER_PAGE
					* PAGE_NUMBER_COUNT_PER_PAGE + 1;
			int endPageNumber = beginPageNumber + PAGE_NUMBER_COUNT_PER_PAGE - 1;
			if (endPageNumber > viewData.getPageTotalCount()) {
				endPageNumber = viewData.getPageTotalCount();
			}
			result.addObject("perPage", PAGE_NUMBER_COUNT_PER_PAGE); // 페이지 번호의 갯수
			result.addObject("end", viewData.getAudioList().size() - 1);// 마지막 페이지getBoardList
			result.addObject("beginPage", beginPageNumber); // 보여줄 페이지 번호의 시작
			result.addObject("endPage", endPageNumber); // 보여줄 페이지 번호의 끝
		}
		result.addObject("select", select);// 그리고 값을 가진 것으 ㄹ넣어준다.
		result.addObject("viewData", viewData);

		result.addObject("c_id", c_id);
		result.setViewName("/audio/list");

		return result;
	}

	/**
	 * 게시판의 값을 반환해주는 메서드
	 */
	public AudioListViewEntity returnViewEntity(int pageNumber, ConferListSelectEntity select) {
		int currentPageNumber = pageNumber; // 페이지의 넘버를 갖고 있는 아이

		int selectConferenceTotalCount = audioService.selectAudioTotalCount(select); // 총 갯수를 갖고 있는 아이
		List<AudioEntity> audioList = null;
		int firstRow = 0;
		int endRow = 0;
		if (selectConferenceTotalCount > 0) {
			firstRow = (pageNumber - 1) * BOARD_COUNT_PER_PAGE + 1;
			endRow = firstRow + BOARD_COUNT_PER_PAGE - 1;
			audioList = audioService.selecAudiotList(firstRow, endRow, select);
			if (select.getVal() != null && !select.getVal().equals("")) {
				selectConferenceTotalCount = audioService.selectAudioListCount(select);
			}
		} else {
			currentPageNumber = 0;
			audioList = Collections.emptyList();
		}
		return new AudioListViewEntity(audioList, selectConferenceTotalCount, currentPageNumber, BOARD_COUNT_PER_PAGE,
				firstRow, endRow);
	}


	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public void download(Locale locale, HttpServletResponse response, @RequestParam("id") int id) throws IOException {
		logger.info("/audio/download", locale);

		AudioEntity audioEntity = new AudioEntity();
		audioEntity.setId(id);

		List<AudioEntity> audioList = audioService.getAudioList(audioEntity);
		audioEntity = audioList.get(0);
		audioEntity.setAd_download_cnt(1);

		audioService.updateAudio(audioEntity);

		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + audioEntity.getAd_wav_filepath() + "\"");

		// String filePath = "C:\\Users\\JunHyuk\\Desktop\\wav_file\\wav_data";
		String filePath = "/usr/local/ap";

		OutputStream outPutStream = response.getOutputStream();
		FileInputStream fileInputStream = new FileInputStream(
				// filePath + << 리눅스안들리기에 빼놓았습니다.
				File.separator + audioEntity.getAd_wav_filepath());

		int n = 0;
		byte[] b = new byte[512];

		while ((n = fileInputStream.read(b)) != -1) {
			outPutStream.write(b, 0, n);
		}

		fileInputStream.close();
		outPutStream.close();
	}
	
	@RequestMapping(value = "/updateAdText", method = RequestMethod.GET)
	public String updateAdText(Locale locale, @RequestParam("id") int id ,@RequestParam("ad_text") String ad_text){
		logger.info("/audio/updateAdText", locale);
		System.out.println("asdasd");
		AudioEntity audioEntity = new AudioEntity();
		audioEntity.setId(id);
		audioEntity.setAd_text(ad_text);

		audioService.updateAdText(audioEntity);
		
		return "audio/list";
	
	}

	public String dateMaker() {
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
		Date currentTime = new Date();
		String mTime = mSimpleDateFormat.format(currentTime);
		return mTime;
	}

	public File convert(MultipartFile file) throws IOException {
		File convFile = new File(file.getOriginalFilename());
		convFile.createNewFile();
		FileOutputStream fos = new FileOutputStream(convFile);
		fos.write(file.getBytes());
		fos.close();
		return convFile;
	}

}
