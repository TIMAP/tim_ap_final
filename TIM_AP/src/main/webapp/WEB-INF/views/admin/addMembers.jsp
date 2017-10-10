<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
	$(function(){
		var msg = "${msg}";
		if(msg != "" && msg != null){
			alert(msg);
			msg = "";
		}
	});
	
$(function(){
// 		var result = $(":input:radio[name=ra]:checked").val();
// 		if(result == 1){
// 			$('.aExcelCsv').attr('class','ssss');
// // 			$('.aExcelCsv').addClass("ssss");

// // 			$(this).removeClass("class_name");
// 		}else{
// 			alert("2");
// 		}
// 	    $("input[type=radio]").change(function(){
// 			result = $(this).val();
// 			if(result == 1){
				
// 			}else{
				
// 			}
// 			alert(result);
// 	    });

  $( function() {
    $( "#tabs" ).tabs();
  } );

// 	 if($(":input:radio[name=ra]:checked").val() == "1" || $(":input:radio[name=ra]:checked").val() != "2"){
// 		 alert(this.val());
// 	 }
// 	$("#viewByOrg, #viewByProduct").bind(($.browser.msie ? "click" : "change"), function () {
//         $(".visibleOnLoad").show();
//         $(".hiddenOnLoad").hide();
//     });
})

// $("#mdName" ).prop( "disabled", true );


	
</script>    

<style>
.ssss{
	margin: 100px;
}
</style>

<div class="ajoinDiv">
	<div id="tabs" style="height: 0; background: none; border: 0;">
		<ul style="background: none; border: 0; margin-left: 45%; margin-top: 2%;">
			<li style="margin-right: 30px;"><a href="#tabs-1">개별</a></li>
			<li><a href="#tabs-2">단체</a></li>
		</ul>
		<div id="tabs-1">
			<div class="ajoinForm">
		<!-- 		<div class="joinImgDiv"></div>이미지 div -->
				<form action="/admin/addMember" method="post" class="ajoinForm" name="joinForm">
					<ul class="ajoinUl">
						<li>
							<label class="joinlabel">아 이 디  :</label><input type = "text" name = "id" class="memjoin form-control1" id="id" placeholder="10자 이내 숫자를 입력하세요" maxlength="10">
						</li>
						<li>
							<label class="joinlabel">비밀번호:</label><input type = "password" name = "pw" class="memjoin form-control1" id="pw" placeholder="8 - 16자 이내로 입력해주세요." maxlength="16">
						</li>
						<li>
							<label class="joinlabel">이 메 일  :</label><input type ="email" name = "email" class="memjoin form-control1" id="email" placeholder="이메일을 정확히 입력해주세요.">
						</li>
						<li>
							<label class="joinlabel">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_first" id="name_first" class="memjoin form-control1" placeholder="이름의 '성'을 적어주세요" maxlength="5">
						</li>
						<li>
							<label class="joinlabel">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_last" class="memjoin form-control1" id="name_last" placeholder="이름을 적어주세요." maxlength="5">
						</li>
						<li>
							<label class="joinlabel">권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "checkbox" name = "auth" class="memjoin form-control1" id="auth" value="auth" style="vertical-align: middle; height: 20px;">
						</li>
					</ul>
					<input type="button" class="btn btn-default loginButton joinButton" value="뒤로가기" onclick="history.back(-1);" class="btn" style="margin-top: 5%;"> 
					<input type="button" class="btn btn-default loginButton joinButton" value="추가" onclick="joinButton();" class="btn"style="margin-top: 5%;">
					<input type="reset"  class="btn btn-default loginButton joinButton" value="초기화" class="btn"style="margin-top: 5%;">
				</form>
			</div>
		</div>
		<div id="tabs-2">
		<div class="aExcelCsv">
		<form id="excelInsertForm" name="excelInsertForm" enctype="multipart/form-data" method="post"
															action= "${pageContext.request.contextPath}/member/excelInsertMember" style="border-bottom: 1px solid white; margin-bottom: 1%; padding-bottom: 1%;">
		    <div class="contents">
		        <div style="margin-top: -5%; margin-bottom: 3%;">첨부파일은 한개만 등록 가능합니다.</div>
		        <dl class="vm_name" style="width: 50%; margin: 0 auto; margin-bottom: 1%;">
		                <dt class="down w90">첨부 파일(Excel)</dt>
		                <dd><input id="excelFile" type="file" name="excelFile" class="form-control" style="height: 40px;"/></dd>
		        </dl>        
		    </div>
		    <div class="bottom">
		        <button type="button" id="addExcelImpoartBtn" class="btn" onclick="check()" ><span>추가</span></button> 
		    </div>
		</form>
		
		<div style="margin-top: 3%; margin-bottom: 4%; border-bottom: 1px solid white;">
			<p style="font-weight: bold;">첨부 파일(CSV)</p>
			<form id="csvInsertForm" name="csvInsertForm" enctype="multipart/form-data" method="post" style=" width: 50%; margin: 0 auto; margin-bottom: 1%;">
				<input id="csvFile" type="file" name="csvFile" class="form-control" style="height: 40px;"/>
				<button type="button" id="addCsvInsertBtn" onclick="checkCsv()" class="btn" style="margin-top: 4%;"><span>추가</span></button>
			</form>
		</div>
		
<!-- 		<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" -->
<%-- 							 action="${pageContext.request.contextPath}/member/excelUpload" > --%>
<!-- 				<div> -->
<!-- 					<p>양식 업로드</p> -->
<!-- 					<input id="f" type="file" name="f"> -->
<!-- 				</div> -->
<!-- 				<input type="submit" value="업로드"/> 			  -->
<!-- 		</form> -->

		<div style="margin-top: 10%; cursor: pointer; width: 200px; height: 40px; background: white; border-radius:30px; padding-top: 2%; margin: 0 auto;">
			<a href="${pageContext.request.contextPath}/member/excelDownload">양식 다운로드</a>
		</div>
	</div>
		</div>
	</div>

</div>
	
	
<script>
function joinButton(){
	var id = $('#id').val().trim();
	var pw = $('#pw').val().trim();
	var email = $('#email').val().trim();
	var name_first = $('#name_first').val().trim();
	var name_last = $('#name_last').val().trim();
	
	var idPattern = /^[0-9]{1,10}$/; //아이디패턴
	var pwPattern = /^[0-9a-zA-Z!@#$%^*+=-]{8,16}$/; //비밀번호패턴
	var emailPattern = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/; //비밀번호패턴
	var nfPattern = /^[가-힣|a-z|A-Z|]{1,5}$/; //성 패턴 이름패턴
	
	if($('#auth').prop('checked')==false){
		document.joinForm.auth.value='N';
	}else{
		document.joinForm.auth.value='Y';
	}
	
	if(!idPattern.test(id)){
		alert("10자 이내 숫자로 입력하세요.");
		$('#id').val("");
		$('#id').focus();
		return false;
	}else if(!pwPattern.test(pw)){
		alert("비밀번호를 8 - 16자 이내로 입력해주세요");
		$('#pw').val("");
		$('#pw').focus();
		return false;
	}else if(!emailPattern.test(email)){
		alert("이메일을 정확히 입력해주세요.");
		$('#email').val("");
		$('#email').focus();
		return false;
	}else if(!nfPattern.test(name_first)){
		alert("성을 입력해주세요");
		$('#name_first').val("");
		$('#name_first').focus();
		return false;
	}else if(!nfPattern.test(name_last)){
		alert("이름을 입력해주세요");
		$('#name_last').val("");
		$('#name_last').focus();
		return false;
	}else{
		 $('.joinForm').submit();
	}
}
</script>