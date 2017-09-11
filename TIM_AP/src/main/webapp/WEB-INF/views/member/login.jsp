<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="content">
	<div class="loginForm">
		<div class="loginFormDiv">
			<div class="loginImgDiv"></div><!-- 이미지 div -->
			<div class="loginFromDiv">
				<form action="<c:url value='/member/login'/>" method="post" class="loginFormInfo">
									<div class="form-group">
										<input type="text" id="id" class="id form-control" name="id" placeholder="아이디를 입력하세요."/>
									</div>
									<div class="form-group">
										<input type="password" id="pw" class="pw form-control" name="pw" placeholder="비밀번호를 입력하세요."/>
									</div>
									<button type="button" class="btn btn-default loginButton" onclick="loginButton();">로그인</button>
									<button type="button" class="btn btn-default loginButton" onclick="location.href='/login/searchForm'">정보 찾기</button>
									<button class="btn btn-default loginButton"><a href="/member/joinForm">회원가입</a></button>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	function loginButton(){
		var id = $('.id').val().trim();
		var pw = $('.pw').val().trim();
		if(id==""){
			alert("아이디를 입력해주세요");
			$('.id').focus();
			return false;
		}else if(pw==""){
			alert("비밀번호를 입력해주세요");
			$('.pw').focus();
			return false;
		}else{
			 $('.loginFormInfo').submit();
		}
	}
</script>
<script>
	$(function(){
		var result = ${failed};
		if(result == false){
			var msg = "${msg}";
			alert(msg);
			msg = "";
			result = true;
		}
	})
</script>