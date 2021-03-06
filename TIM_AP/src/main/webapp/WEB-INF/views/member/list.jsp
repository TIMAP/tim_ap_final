<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.tim.ap.entity.MemberEntity"%>
<div class="mainDiv">
	<div style="padding: 3% 5%;">
<!-- 		<button onclick="addMembers();" >등록</button> -->
		<form id="searchForm" action="/admin/memList">
			<div style="float: left; margin-left: 16.7%">
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
			</div>
			<input onclick="addMembers();" value="등록" type="button"class="btn btn-default loginButton joinButton conferenceSelect" style="float: right; margin-right: 16.7%;">
		</form>
	</div>
	
	<div>	
		<table class="table table-bordered table-hover" style="background: white; width: 60%; margin: 1.5% auto;">
			<tr style="background: silver;">
				<td style="text-align: center; width: 300px;">ID</td>
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
	</div>
</div>	
<script>
function addMembers(){
	location.href="/admin/addMemberForm";
}
</script>