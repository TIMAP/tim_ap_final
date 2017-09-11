<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="content">
	<div class="loginForm">
		로그인 폼
		<form action="<c:url value='/member/login'/>" method="post" class="loginFormInfo">
							<div class="form-group">
								<input type="text" id="id" class="id" name="id" placeholder="아이디를 입력하세요."/>
							</div>
							<div class="form-group">
								<input type="password" id="pw" class="pw" name="pw" placeholder="비밀번호를 입력하세요."/>
							</div>
							<button type="button" onclick="loginButton();">로그인</button>
							<button type="button" class="btn btn-default" onclick="location.href='/login/searchForm'">아이디/비밀번호 찾기</button>
						</form>
		<button><a href="/member/joinForm">회원가입</a></button>
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