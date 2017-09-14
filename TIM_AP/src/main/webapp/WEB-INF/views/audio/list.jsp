<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.tim.ap.entity.AudioEntity"%>
<script src="/resources/js/audio/audioplay.js"></script>
<script src="/resources/js/audio/main.js"></script>
	
<script>

//날짜+요일만들기
var d = new Date();
var today = getFormatDate(d);

//날짜 포멧 변환
function getFormatDate(date){
	var year = date.getFullYear();                                 //yyyy
	var month = (1 + date.getMonth());                     //M
	month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
	var day = date.getDate();                                        //d
	day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
	return  year + '-' + month + '-' + day;
}

// 날짜 패턴
var datePattern = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;


$(document).ready(function() {
	
	//날짜 정보 입력
	$('input[name="date"]').val(today);
	
	//녹음기 숨기기
	$('#voiceRecorder').hide();
	
	
	$('#addFile').click(function() {
		var fileIndex = $('#fileListTable tr').children().length;      
		$('#fileListTable').append('<tr><td>'+'<input type="file" name="multipartFile" required="required"/>'+'</td></tr>');
    });
    
    $('#holdConfbtn').click(function() {
    	var confTitle = $('#title').val(); 
    	var date = $('#date').val(); 
    	if(confTitle == null ||  confTitle == "" || date == null || date =="") {
    		alert("회의 정보를 입력하세요")
    	}else{
    		$('#voiceRecorder').show();
    	}
    });
    
    $('#closeConf').click(function() {
    	$('#title').val("");
    	location.reload();
    });
   
    $('#hideConfbtn').click(function(){
    	$('#voiceRecorder').hide();
    });
});
	//작성자 : 홍기훈 오디오 녹음을 위한객체
	
	  var WORKER_PATH = '/resources/js/audio/recorderWorker.js';

	  var Recorder = function(source, cfg){
		    var config = cfg || {};
		    var bufferLen = config.bufferLen || 4096;
		    this.context = source.context;
		    if(!this.context.createScriptProcessor){
		       this.node = this.context.createJavaScriptNode(bufferLen, 2, 2);
		    } else {
		       this.node = this.context.createScriptProcessor(bufferLen, 2, 2);
		    }
		   
		    var worker = new Worker(config.workerPath || WORKER_PATH);
		    worker.postMessage({
		      command: 'init',
		      config: {
		        sampleRate: this.context.sampleRate
		      }
		    });
		    var recording = false,
		      currCallback;

		    this.node.onaudioprocess = function(e){
		      if (!recording) return;
		      worker.postMessage({
		        command: 'record',
		        buffer: [
		          e.inputBuffer.getChannelData(0),
		          e.inputBuffer.getChannelData(1)
		        ]
		      });
		    }

		    this.configure = function(cfg){
		      for (var prop in cfg){
		        if (cfg.hasOwnProperty(prop)){
		          config[prop] = cfg[prop];
		        }
		      }
		    }

		    this.record = function(){
		      recording = true;
		    }

		    this.stop = function(){
		      recording = false;
		    }

		    this.clear = function(){
		      worker.postMessage({ command: 'clear' });
		    }

		    this.getBuffers = function(cb) {
		      currCallback = cb || config.callback;
		      worker.postMessage({ command: 'getBuffers' })
		    }

		    this.exportWAV = function(cb, type){
		      currCallback = cb || config.callback;
		      type = type || config.type || 'audio/wav';
		      if (!currCallback) throw new Error('Callback not set');
		      worker.postMessage({
		        command: 'exportWAV',
		        type: type
		      });
		    }

		    this.exportMonoWAV = function(cb, type){
		      currCallback = cb || config.callback;
		      type = type || config.type || 'audio/wav';
		      if (!currCallback) throw new Error('Callback not set');
		      worker.postMessage({
		        command: 'exportMonoWAV',
		        type: type
		      });
		    }

		    worker.onmessage = function(e){
		      var blob = e.data;
		      currCallback(blob);
		    }

		    source.connect(this.node);
		    this.node.connect(this.context.destination);   // if the script node is not connected to an output the "onaudioprocess" event is not triggered in chrome.
		  };

		  Recorder.setupDownload = function(blob, filename){
		    var url = (window.URL || window.webkitURL).createObjectURL(blob);
		    var link = document.getElementById("save");
		    link.href = url;
		    
		    link.download = filename || 'output.wav';
		alert(url);
		    uploadWav(blob);
		    
		  }
		  
		  
		  function uploadWav(blob){
				var confTitle = $('#title').val(); 
		    	var date = $('#date').val(); 
		  		var formData = new FormData();
		  		formData.append("multipartFile", blob,"temp.wav");
		  		formData.append('title', confTitle);
		  		formData.append('date', date);
		  		
					$.ajax({
						type : 'POST',
						url : 'update',
						data : formData,
						processData:false,
						contentType:false,
						enctype: "multipart/form-data",
						success : function(result){
								alert("성공적으로 회의가 저장되었습니다.");
								location.href="/audio/list?c_id="+confTitle;
						}
					});
			  
			 }
		  
		  window.Recorder = Recorder;
		  
	
	</script>

	<style>
	
	html { overflow: hidden; }
	#voiceRecorder { 
/* 		font: 14pt Arial, sans-serif;  */
		background: lightgrey;
		display: flex;
		flex-direction: row;
		align-items: center;
		height: 15vh;
		width: 50vh;
/* 		margin: 0 0; */
		margin: 1% auto;
	}
	canvas { 
		display: inline-block; 
		background: #202020; 
		width: 95%;
		height: 45%;
		box-shadow: 0px 0px 10px blue;
	}
	#controls {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-around;
		height: 70%;
		width: 10%;
	}
	#record { height: 5vh; }
	#record.recording { 
		background: red;
		background: -webkit-radial-gradient(center, ellipse cover, #ff0000 0%,lightgrey 75%,lightgrey 100%,#7db9e8 100%); 
		background: -moz-radial-gradient(center, ellipse cover, #ff0000 0%,lightgrey 75%,lightgrey 100%,#7db9e8 100%); 
		background: radial-gradient(center, ellipse cover, #ff0000 0%,lightgrey 75%,lightgrey 100%,#7db9e8 100%); 
	}
	#save, #save img { height: 5vh; }
	#save { opacity: 0.25;}
	#save[download] { opacity: 1;}
	#viz {
		height: 80%;
		width: 60%;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
	}
	@media (orientation: landscape) {
		body { flex-direction: row;}
		#controls { flex-direction: column; height: 40%; width: 30%;}
		#viz { height: 70%; width: 80%;}
	}

	</style>
<style>
table {
	border: 1px solid #444444;
	text-align: center;
	border-collapse: collapse;
}
th, tr, td  {
	border: 1px solid #444444;
	padding: 10px;
}
</style>
<div class="mainDiv">
	<div id="conferenceInfo">
		<form action="/audio/list">
			<select name="index" class="btn btn-default loginButton joinButton conferenceSelect">
				<option value="M_EMAIL" selected="selected">Email</option>
				<option value="AD_TEXT">내용</option>
				<option value="AD_WAV_FILEPATH">경로</option>
			</select> 
			<input type="hidden" value="${select.index}"> 
			<input type="hidden" name="c_id" value="${c_id}"> 
			<input type="text" class="memjoin form-control1 conferenceSelect" name="val" value="${select.val}"> 
			<input type="submit" class="btn btn-default loginButton joinButton conferenceSelect" value="검색"> 
			<input type="button" id="holdConfbtn" value="회의추가" class="btn btn-default loginButton joinButton conferenceSelect">
			<input type="button" id="hideConfbtn" value="추가취소" class="btn btn-default loginButton joinButton conferenceSelect">
		</form>
	</div>

	<div style="margin: 0 auto;">
		<table  style="margin: 0 auto; background: white;" class="table table-bordered table-hover conferenceList">
			<tr>
				<th style="text-align:center; width:100px;">ID</th> <!-- (오디오ID) -->
				<th style="text-align:center; width:100px;">C_ID</th> <!-- (회의번호) -->
				<th style="text-align:center; width:100px;">M_EMAIL</th><!-- (작성자 이메일) -->
				<th style="text-align:center; width:100px;">TIME_BEG</th><!--  -->
				<th style="text-align:center; width:100px;">TIME_END</th><!--  -->
				<th style="text-align:center; width:100px;">AD_TEXT</th><!-- (텍스트로변환된것) -->
				<th style="text-align:center; width:100px;">AD_WAV_FILEPATH</th><!-- (경로) -->
				<th style="text-align:center; width:100px;">AD_DOWNLOAD_CNT</th><!-- (횟수) -->
				<th style="text-align:center; width:100px;">다운로드</th><!--  -->
			</tr>
		
			<c:forEach items="${viewData.audioList}" var="audioEntity">
				<tr>
					<td style="text-align:center;">${audioEntity.id}</td>
					<td style="text-align:center;">${audioEntity.c_id}</td>
					<td style="text-align:center;">${audioEntity.m_email}</td>
					<td style="text-align:center;">${audioEntity.time_beg}</td>
					<td style="text-align:center;">${audioEntity.time_end}</td>
					<td style="text-align:center;"><textarea rows="3" cols="30" style="resize:none; border: 0;" readonly>${audioEntity.ad_text}</textarea></td>
					<td style="text-align:center;"><textarea rows="3" cols="30" style="resize:none; border: 0;" readonly>${audioEntity.ad_wav_filepath}</textarea></td>
					<td style="text-align:center;">${audioEntity.ad_download_cnt}</td>
					<td style="text-align:center;"><img src="/resources/images/save.svg" style="cursor:pointer"></td>
				</tr>
			</c:forEach>
		</table>
		<div id="pageNum">
			<c:if test="${beginPage > perPage}">
				<a
					href="<c:url value="/audio/list?page=${beginPage-1}&index=${select.index}&val=${select.val}&c_id=${c_id}"/>">이전</a>
			</c:if>
			<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
				<a
					href="<c:url value="/audio/list?page=${pno}&index=${select.index}&val=${select.val}&c_id=${c_id}" />">[${pno}]</a>
			</c:forEach>
			<c:if test="${endPage < viewData.getPageTotalCount()}">
				<a
					href="<c:url value="/audio/list?page=${endPage + 1}&index=${select.index}&val=${select.val}&c_id=${c_id}"/>">다음</a>
			</c:if>
		</div>
<!-- 		<table  style="margin: 0 auto; background: white;" class="table table-bordered table-hover conferenceList"> -->
<!-- 			<tr> -->
<!-- 				<th style="text-align:center; width:100px;">ID</th> (오디오ID) -->
<!-- 				<th style="text-align:center; width:100px;">C_ID</th> (회의번호) -->
<!-- 				<th style="text-align:center; width:100px;">M_EMAIL</th>(작성자 이메일) -->
<!-- 				<th style="text-align:center; width:100px;">TIME_BEG</th> -->
<!-- 				<th style="text-align:center; width:100px;">TIME_END</th> -->
<!-- 				<th style="text-align:center; width:100px;">AD_TEXT</th>(텍스트로변환된것) -->
<!-- 				<th style="text-align:center; width:100px;">AD_WAV_FILEPATH</th>(경로) -->
<!-- 				<th style="text-align:center; width:100px;">AD_DOWNLOAD_CNT</th>(횟수) -->
<!-- 				<th style="text-align:center; width:100px;">다운로드</th> -->
<!-- 			</tr> -->
		
<%-- 			<c:forEach items="${result}" var="audioEntity"> --%>
<!-- 				<tr> -->
<%-- 					<td style="text-align:center;">${audioEntity.id}</td> --%>
<%-- 					<td style="text-align:center;">${audioEntity.c_id}</td> --%>
<%-- 					<td style="text-align:center;">${audioEntity.m_email}</td> --%>
<%-- 					<td style="text-align:center;">${audioEntity.time_beg}</td> --%>
<%-- 					<td style="text-align:center;">${audioEntity.time_end}</td> --%>
<%-- 					<td style="text-align:center;"><textarea rows="3" cols="30" style="resize:none; border: 0;" readonly>${audioEntity.ad_text}</textarea></td> --%>
<%-- 					<td style="text-align:center;"><textarea rows="3" cols="30" style="resize:none; border: 0;" readonly>${audioEntity.ad_wav_filepath}</textarea></td> --%>
<%-- 					<td style="text-align:center;">${audioEntity.ad_download_cnt}</td> --%>
<!-- 					<td style="text-align:center;"><img src="/resources/images/save.svg" style="cursor:pointer"></td> -->
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->
	</div>
	
	<div id="voiceRecorder">
		<div id="conferenceInfo">
			회의명 : <input type="text" id="title" name="title" class="memjoin form-control1 conferenceSelect placeholder" value="${c_id }"> 
			날짜 : <input type="text" id="date" name="date" value="date" readonly class="memjoin form-control1 conferenceSelect">
		</div>
		<br> 녹음영역
		<div id="viz">
			<canvas id="analyser" width="300" height="200"></canvas>
			<canvas id="wavedisplay" width="300" height="200"></canvas>
		</div>
		<div id="controls">
			<img id="record" src="/resources/images/mic1.png" onclick="toggleRecording(this);" width="50px" height="50px"> 
			<a id="save" href="#"> 
				<img src="/resources/images/save.svg" width="50px" height="50px">
			</a>
		</div>
		<input type="button" id="closeConf" value="회의종료" class="btn btn-default loginButton joinButton conferenceSelect">
	</div>
</div>

<script>
	$("#record").click(function() {
		var c_id = '${c_id}';
		alert(c_id);
		$.ajax({
				url : '/conference/conferenceUpdate',
				type : 'post',
				data :   c_id ,
				success : function(result) {
					alert("성공");
				},
				error : function() {
					alert("실패");
				},
				dataType : 'json'
		});
	});
</script>