<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
// 	로그인유저 개인정보
	function loginUserInfo() {
		alert("로그인유저");
		location.href="/member/loginform";
	}
	
// 	회의
	function conference() {
		alert("회의");
		location.href="/conference/conferencelist";
	}
	
// 	오디오
	function audio() {
		alert("오디오");
		location.href="/audio/form";
	}
	
</script>

<div class="mainDiv">
	<h1>메인이고</h1>
	<div class="mainDivOne" onclick="loginUserInfo();">
		<h1>개인정보</h1>
	</div>
	
	<div class="mainDivTwo" onclick="conference();">
		<h1>회의</h1>
	</div>
	
<!-- 	<div class="mainDivThree" onclick="audio();"> -->
<!-- 		<h1>오디오페이퍼</h1> -->
<!-- 	</div> -->
</div>
