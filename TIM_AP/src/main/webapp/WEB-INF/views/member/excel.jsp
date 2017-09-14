<%@page import="com.tim.ap.entity.MemberEntity"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="/resources/js/member/member.js"></script>
<script type="text/javascript">
$(function(){
	var result = ${result};
	var msg = "";
	if(result == false){
		msg = "${checkId}";
		alert(msg);
		msg = "";
		result = true;
	}else if(result == true){
		msg = "${msg}";
		alert(msg);
		msg="";
	}
})
</script>
<title>Insert title here</title>
</head>
<body>
	<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" 
                                action= "${pageContext.request.contextPath}/member/excelUploadAjax">
	    <div class="contents">
	        <div>첨부파일은 한개만 등록 가능합니다.</div>
	 
	        <dl class="vm_name">
	                <dt class="down w90">첨부 파일</dt>
	                <dd><input id="excelFile" type="file" name="excelFile" /></dd>
	        </dl>        
	    </div>
	            
	    <div class="bottom">
	        <button type="button" id="addExcelImpoartBtn" class="btn" onclick="check()" ><span>추가</span></button> 
	    </div>
	</form> 

<form id="excelInsertForm" name="excelInsertForm" enctype="multipart/form-data" method="post"
							 action="${pageContext.request.contextPath}/member/excelInsert" >
				<div>
					<p>양식 업로드</p>
					<input type="file" name="f"	>
				</div>			 
		<input type="submit" value="업로드"/>
</form>

<div>
	<p>첨부파일</p>
	<a href="${pageContext.request.contextPath}/member/excelDownload">양식 다운로드</a>
</div>

	<form id="csvInsertForm" name="csvInsertForm" enctype="multipart/form-data" method="post">
		<input id="csvFile" type="file" name="csvFile"/>
		<button type="button" id="addCsvInsertBtn" onclick="checkCsv()"><span>추가</span></button>
	</form>

</body>
