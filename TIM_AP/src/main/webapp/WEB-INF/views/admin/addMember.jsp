<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="joinDiv">
	<div class="joinForm">
		<div class="joinImgDiv"></div><!-- 이미지 div -->
		<form action="/admin/addMember" method="post" class="joinForm" name="joinForm">
			<ul class="joinUl">
				<li>
					<label class="joinlabel">아 이 디  :</label><input type = "text" name = "id" class="memjoin form-control1" id="id" placeholder="10자 이내 숫자를 입력하세요" maxlength="10">
				</li>
				<li>
					<label class="joinlabel">비밀번호:</label><input type = "password" name = "pw" class="memjoin form-control1" id="pw" placeholder="8 - 16자 이내로 입력해주세요." maxlength="16">
				</li>
				<li>
					<label class="joinlabel">이 메 일  :</label><input type ="email" name = "email" class="memjoin form-control1" id="email" placeholder="이메일을 정확히 입력해주세요.">
				</li>
				<li>
					<label class="joinlabel">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_first" id="name_first" class="memjoin form-control1" placeholder="이름의 '성'을 적어주세요" maxlength="5">
				</li>
				<li>
					<label class="joinlabel">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_last" class="memjoin form-control1" id="name_last" placeholder="이름을 적어주세요." maxlength="5">
				</li>
				<li>
					<label class="joinlabel">권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "checkbox" name = "auth" class="memjoin form-control1" id="auth" value="auth">
				</li>
			</ul>
			<input type="button" class="btn btn-default loginButton joinButton" value="뒤로가기" onclick="history.back(-1);" class="btn"> 
			<input type="button" class="btn btn-default loginButton joinButton" value="추가" onclick="joinButton();" class="btn">
			<input type="reset"  class="btn btn-default loginButton joinButton" value="초기화" class="btn">
		</form>
	</div>
</div>
<script>
function joinButton(){
	var id = $('#id').val().trim();
	var pw = $('#pw').val().trim();
	var email = $('#email').val().trim();
	var name_first = $('#name_first').val().trim();
	var name_last = $('#name_last').val().trim();
	
	var idPattern = /^[0-9]{1,10}$/; //아이디패턴
	var pwPattern = /^[0-9a-zA-Z!@#$%^*+=-]{8,16}$/; //비밀번호패턴
	var emailPattern = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/; //비밀번호패턴
	var nfPattern = /^[가-힣|a-z|A-Z|]{1,5}$/; //성 패턴 이름패턴
	
	if($('#auth').prop('checked')==false){
		document.joinForm.auth.value='N';
	}else{
		document.joinForm.auth.value='Y';
	}
	
	if(!idPattern.test(id)){
		alert("10자 이내 숫자로 입력하세요.");
		$('#id').val("");
		$('#id').focus();
		return false;
	}else if(!pwPattern.test(pw)){
		alert("비밀번호를 8 - 16자 이내로 입력해주세요");
		$('#pw').val("");
		$('#pw').focus();
		return false;
	}else if(!emailPattern.test(email)){
		alert("이메일을 정확히 입력해주세요.");
		$('#email').val("");
		$('#email').focus();
		return false;
	}else if(!nfPattern.test(name_first)){
		alert("성을 입력해주세요");
		$('#name_first').val("");
		$('#name_first').focus();
		return false;
	}else if(!nfPattern.test(name_last)){
		alert("이름을 입력해주세요");
		$('#name_last').val("");
		$('#name_last').focus();
		return false;
	}else{
		 $('.joinForm').submit();
	}
}
</script>

