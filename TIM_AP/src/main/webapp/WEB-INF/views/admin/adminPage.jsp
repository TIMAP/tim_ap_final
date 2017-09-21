<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="mainDiv">
<!-- 		<button type="button" class="btn btn-default loginButton" onclick="memberList();">회원 리스트</button> -->
<!-- 		<button type="button" class="btn btn-default loginButton" onclick="audioList();">오디오 리스트</button> -->
<!-- 		<button type="button" class="btn btn-default loginButton" onclick="conferList();">회의 리스트</button> -->
		<div class="amainDivOne" onclick="memberList();">
			<div class="auserInfoImgDiv"></div>		
			<h1>회원 리스트</h1>
		</div>
		
		<div class="amainDivTwo" onclick="conferList();">
			<div class="aconferenceImgDiv"></div>
			<h1>회의 리스트</h1>
		</div>
		
		<div class="amainDivThree" onclick="audioList();">
			<div class="aaudioImgDiv"></div>
			<h1>오디오 리스트</h1>
		</div>
</div>

<script>

	function memberList(){
		location.href="/admin/memList"
	}

	function audioList(){
		location.href="/audio/list"
	}
	
// 	회의
	function conferList() {
		location.href="/conference/conferencelist";
	}
	
</script>
