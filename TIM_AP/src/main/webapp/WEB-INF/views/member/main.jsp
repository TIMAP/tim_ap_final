<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
// 	로그인유저 개인정보
	function loginUserInfo() {
		location.href="/member/userInfo?id=${id}";
	}
	
// 	회의
	function conference() {
		location.href="/conference/conferencelist";
	}
	
// 	오디오
	function audio() {
		location.href="/audio/form";
	}
	
</script>

<div class="mainDiv">
	<div class="mainDivOne" onclick="loginUserInfo();">
		<div class="userInfoImgDiv"></div>		
		<h1>개인정보</h1>
	</div>
	
	<div class="mainDivTwo" onclick="conference();">
		<div class="conferenceImgDiv"></div>
		<h1>회의</h1>
	</div>
</div>
