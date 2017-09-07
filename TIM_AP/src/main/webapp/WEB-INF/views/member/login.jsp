<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function(){
		var result = true;
		result = ${failed};
		if(result == false){
			var msg = "${msg}";
			alert(msg);
			msg = "";
			result = true;
		}
	})
</script>
	<div id="content">
		로그인 폼
		<form action="<c:url value='/member/login'/>" method="post">
							<div class="form-group">
								<input type="text" id="id" name="id" placeholder="아이디를 입력하세요."/>
							</div>
							<div class="form-group">
								<input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요."/>
							</div>
							<button type="submit">로그인</button>
							<button type="button" class="btn btn-default" onclick="location.href='/login/searchForm'">아이디/비밀번호 찾기</button>
						</form>
		<button><a href="/member/joinForm">회원가입</a></button>
	</div>
