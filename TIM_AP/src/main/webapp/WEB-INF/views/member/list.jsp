<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.tim.ap.entity.MemberEntity"%>
<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg != "" && msg != null){
		alert(msg);
		msg = "";
	}
})
</script>

		<div>
		<form id="searchForm" action="/admin/memList">
			<select name="searchType"
				class="btn btn-default loginButton joinButton conferenceSelect">
				<option value="mail" selected="selected">메일</option>
				<option value="namelast">이름</option>
				<option value="namefirst">성</option>
				<option value="role">역활</option>
				<option value="auth">권한</option>
			</select>
			 <input type="hidden" value="${result.searchType}"> 
			 <input type="hidden" value="${result.searchWord}"> 
			 <input type="text" 
			 		class="memjoin form-control1 conferenceSelect"
					name="searchWord"
					value="${result.searchWord}"> 
			<input type="submit"
					class="btn btn-default loginButton joinButton conferenceSelect"
					value="검색"> 
			<input type="button"
					class="btn btn-default loginButton joinButton conferenceSelect"
					value="뒤로 가기" onclick="history.back(-1);" class="btn">
		</form>
		<hr>
		<form id="excelInsertForm" name="excelInsertForm" enctype="multipart/form-data" method="post"
															action= "${pageContext.request.contextPath}/member/excelInsertMember">
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
		<hr> 
		<form id="csvInsertForm" name="csvInsertForm" enctype="multipart/form-data" method="post">
			<input id="csvFile" type="file" name="csvFile"/>
			<button type="button" id="addCsvInsertBtn" onclick="checkCsv()"><span>추가</span></button>
		</form>
		<hr>
		<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post"
							 action="${pageContext.request.contextPath}/member/excelUpload" >
				<div>
					<p>양식 업로드</p>
					<input id="f" type="file" name="f">
				</div>
				<input type="submit" value="업로드"/> 			 
		</form>

		<div>
			<p>첨부파일</p>
			<a href="${pageContext.request.contextPath}/member/excelDownload">양식 다운로드</a>
		</div>
			<!-- 엑셀 양식 업로드 -->
			<!-- 엑셀 양식 다운로드 -->
			<!-- 사용자 일괄 추가 -->
			<a href="${pageContext.request.contextPath}/admin/addMemberForm">사용자 개별추가</a>
			</div>
			
		<table>
			<tr>
				<td style="text-align: center; width: 300px;">No.</td>
				<td style="text-align: center; width: 300px;">이메일</td>
				<td style="text-align: center; width: 200px;">이름</td>
				<td style="text-align: center; width: 200px;">성</td>
				<td style="text-align: center; width: 100px;">역할</td>
				<td style="text-align: center; width: 100px;">권한</td>
			</tr>
		
			<c:forEach items="${result.dataList}" var="memberEntity">
				<tr>
					<td style="text-align: center;"><a onclick="memberInfo('${memberEntity.id}');">${memberEntity.id}</a></td>
					<td style="text-align: center;">${memberEntity.email}</td>
					<td style="text-align: center;">${memberEntity.name_first}</td>
					<td style="text-align: center;">${memberEntity.name_last}</td>
					<td style="text-align: center;">${memberEntity.role}</td>
					<td style="text-align: center;">${memberEntity.auth}</td>
				</tr>
			</c:forEach>
		</table>
		<div id="pagingArea">${result.pagingHTML }</div>
