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
	
	//closed 라디오  버튼 숨기기 
	$('#closedEdit').hide();
	
	
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
    //오디오 ad_text 수정 
    $('input[name=audioEdit]').click(function(){
    	var val= $(this).val();
		var parent=$(this).parent().parent();
      	var adtext= parent.find("td:eq(5)").children().val();
      	var id= parent.find("td:eq(0)").text();
//     	alert(parent);
    	if(val=="수정"){
	    	$(this).attr("value","저장");		
	    	parent.find("td:eq(5)").children().attr("readonly",false);

    	}
    	else{
	        $.ajax({
	             
	            type : "GET",
	            url : "updateAdText?id="+id+"&ad_text="+adtext,
	            error : function(){
	                alert('변경에 실패하였습니다 ');
	            },
	            success : function(data){
	          		alert("AD_TEXT를 변경하였습니다 ");
	            	
	            }
	             
	        });
	        $(this).attr("value","수정");		    		
	    	parent.find("td:eq(5)").children().attr("readonly",true);
    	}
    	
    });
    
    //회의 정보 변경
    $('#conferEdit').click(function(){
    	var p = getParams();
    	var val= $(this).val();
		var parent=$(this).parent().parent();
      	var title= parent.find("td:eq(0)").children().val();
      	var id = p["c_id"];
      	
      	if('${confer.closed }'=='N'){
      		 $("#open").attr("checked",true);
      	}else{
      		 $("#close").attr("checked",true);
      	}
      	var closed_val=$("input[name='closed']:checked").val();
//     	alert(parent);
    	if(val=="수정"){
	    	$(this).attr("value","저장");		
 	    	parent.find("td:eq(0)").children().attr("readonly",false);
 	   		$('#closedEdit').show();
 	   		$('#closedInfo').hide();
    	}
    	else{
	        $.ajax({
	             
	            type : "GET",
	            url : "../conference/update?id="+id+"&title="+title+"&closed="+closed_val,
	            error : function(){
	                alert('변경에 실패하였습니다 ');
	            },
	            success : function(data){
	          		alert("회의 정보를 변경하였습니다 ");
	          		location.href="/audio/list?c_id="+id;
	            }
	        });
	        $(this).attr("value","수정");		    		
	    	parent.find("td:eq(0)").children().attr("readonly",true);
 	   		$('#closedEdit').hide();
 	   		$('#closedInfo').show();
    	}
    	
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
				var confId = $('#c_id').val(); 
		    	var date = $('#date').val(); 
		  		var formData = new FormData();
		  		formData.append("multipartFile", blob,"temp.wav");
		  		formData.append('id', confId);
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
								location.href="/audio/list?c_id="+confId;
						}
					});
			  
			 }

		  function getParams() {
			    // 파라미터가 담길 배열
			    var param = new Array();
			 
			    // 현재 페이지의 url
			    var url = decodeURIComponent(location.href);
			    // url이 encodeURIComponent 로 인코딩 되었을때는 다시 디코딩 해준다.
			    url = decodeURIComponent(url);
			 
			    var params;
			    // url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
			    params = url.substring( url.indexOf('?')+1, url.length );
			    // 파라미터 구분자("&") 로 분리
			    params = params.split("&");

			    // params 배열을 다시 "=" 구분자로 분리하여 param 배열에 key = value 로 담는다.
			    var size = params.length;
			    var key, value;
			    for(var i=0 ; i < size ; i++) {
			        key = params[i].split("=")[0];
			        value = params[i].split("=")[1];

			        param[key] = value;
			    }

			    return param;
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
			<c:if test="${id ne 1004}">
			<input type="button" id="holdConfbtn" value="회의추가" class="btn btn-default loginButton joinButton conferenceSelect">
			</c:if>
		</form>
	</div>

	<div style="margin: 0 auto;">
	<c:if test="${!empty confer.title}">
		<table style="margin: 0 auto; background: white; width: 66%;" class="table table-bordered table-hover conferenceList" >
			<tr>
				<th style="text-align:center; width:100px;">회의명</th>
				<td style="text-align:center;"><input type="text" id="title" value="${confer.title }" readonly style="border: 0"></td>
				<th style="text-align:center; width:100px;">날짜 </th> 
				<td style="text-align:center;"><input type="text" id="date" name="date" readonly ></td>
				<th style="text-align:center; width:100px;">회의 상태</th>
				<td style="text-align:center;">
				<div id="closedInfo">
				<c:if test="${confer.closed eq 'N'}">
					Open
				</c:if>
				<c:if test="${confer.closed eq 'Y'}">
					Closed
				</c:if>
				</div>
				<div id="closedEdit">
					<input type="radio" name="closed" id="open" value="N">Open<br/>
					<input type="radio" name="closed" id="close" value="Y">Closed
				</div>
				</td>
				<td>
					<c:if test="${sessionScope.id == confer.u_id or id eq 1004}">
       					<input type="button" id="conferEdit" value="수정" class="btn btn-default loginButton joinButton conferenceSelect"/>
       					<input type="button" id="conferDel"  value="삭제" class="btn btn-default loginButton joinButton conferenceSelect"/>
   					</c:if>
				</td>
			</tr>
		</table>
</c:if>
		<br><br>
				<!-- 스타일을 위에서 잡아줘서 중복코딩 막는게 어떨지 생각됨 , 아니면 메타에 너어놔도..어차피 테이블 다똑같은 형식이니까 -->
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
				<th style="text-align:center; width:100px;">권한</th><!--  -->
			</tr>
		<c:choose>
		<c:when test="${!empty viewData.audioList}">
			<c:forEach items="${viewData.audioList}" var="audioEntity">
				<tr>
					<td style="text-align:center;">${audioEntity.id}</td>
					<td style="text-align:center;">${audioEntity.c_id}</td>
					<td style="text-align:center;">${audioEntity.m_email}</td>
					<td style="text-align:center;">${audioEntity.time_beg}</td>
					<td style="text-align:center;">${audioEntity.time_end}</td>
					<td style="text-align:center;" ><textarea id="${audioEntity.id}" rows="3" cols="30" style="resize:none; border: 0;" readonly>${audioEntity.ad_text}</textarea></td>
					<td style="text-align:center;"><textarea rows="3" cols="30" style="resize:none; border: 0;" readonly>${audioEntity.ad_wav_filepath}</textarea></td>
					<td style="text-align:center;">${audioEntity.ad_download_cnt}</td>
					<td style="text-align:center;"><a href="/audio/download?id=${audioEntity.id}"><img src="/resources/images/save.svg" style="cursor:pointer"></a></td>

					<td style="text-align:center;">
					<!-- 관리자 or 작성자 오디오 ad_text 정보 변경  -->
					<c:if test="${sessionScope.email == audioEntity.m_email or id eq 1004}">					
						<input type="button" value="수정" name="audioEdit"/>
					</c:if>
					</td>

				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="9">내용이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
			
		</table>
		<div id="pageNum" style="margin-top: 1%;">
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
	</div>
	
	<div id="voiceRecorder">
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

