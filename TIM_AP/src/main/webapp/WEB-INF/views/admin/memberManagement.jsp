<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="/resources/js/member/member.js"></script>

<div class="joinDiv">
	<form action="/admin/memberManagement" method="post" class="managementForm">
		<ul>
			<li>
				<label class="joinlabel">아 이 디  :</label><input type = "text" name = "id" class="memjoin form-control1" value="${mem.id}" readonly>
			</li>
			<li>
				<label class="joinlabel">비밀번호:</label><input type = "password" name = "pw" id="pw" class="memjoin form-control1" placeholder="비밀번호는 변경 할 수 없습니다." readonly>
			</li>
			<li>
				<label class="joinlabel">이 메 일  :</label><input type ="email" name = "email" class="memjoin form-control1" value="${mem.email}">
			</li>
			<li>
				<label class="joinlabel">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_first" class="memjoin form-control1" value="${mem.name_first}">
			</li>
			<li>
				<label class="joinlabel">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_last" class="memjoin form-control1" value="${mem.name_last}">
			</li>
			<li>
				<label class="joinlabel">역할&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "role" class="memjoin form-control1" value="${mem.role}">
			</li>
			<li>
				<label class="joinlabel">권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "auth" class="memjoin form-control1" value="${mem.auth}">
			</li>
		</ul>
	<input type="button" value="뒤로가기" onclick="history.back(-1);" class="btn btn-default loginButton joinButton"> 
	<input type="button" onclick="memberMg();" value="수정" class="btn btn-default loginButton joinButton">
	<input type="reset" value="초기화" class="btn btn-default loginButton joinButton">
	</form>
</div>