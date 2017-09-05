<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="joinDiv">
	<form action="/member/join" method="post">
		<ul>
			<li>
				<label class="joinlabel">아 이 디  :</label><input type = "text" name = "id" class="memjoin" placeholder="휴대폰 번호를 '-'를 빼고 적어주세요.">
			</li>
			<li>
				<label class="joinlabel">비밀번호:</label><input type = "password" name = "pw" class="memjoin" placeholder="비밀번호를 입력해주세요.">
			</li>
			<li>
				<label class="joinlabel">이 메 일  :</label><input type ="email" name = "email" class="memjoin" placeholder="이메일을 정확히 입력해주세요.">
			</li>
			<li>
				<label class="joinlabel">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_first" class="memjoin" placeholder="이름의 '성'을 적어주세요">
			</li>
			<li>
				<label class="joinlabel">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_last" class="memjoin" placeholder="이름을 적어주세요.">
			</li>
		</ul>
	<input type="button" value="뒤로가기" onclick="history.back(-1);" class="btn"> 
	<input type="submit" value="가입" class="btn">
	<input type="reset" value="초기화" class="btn">
	</form>
</div>
</body>


