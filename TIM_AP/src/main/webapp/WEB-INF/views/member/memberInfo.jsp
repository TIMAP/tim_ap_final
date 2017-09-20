<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	function memberDelete(id) {
		var con_test = confirm("정말 회원 탈퇴 하시겠습니까?");
	      
	      if(con_test==true){
	          $.ajax({
	                type : "POST",
	                url : "/member/memberDelete",
	                data : {'id' : id},
	                success : function(result){
	                   location.href=result.uri;
	               }, 
	               error : function(){
	               },
	                dataType : 'json' 
	          });
	      }
	}
	
	function memberUpdate() {
		var pw = $('#pw').val().trim();
		var pwPattern = /^[0-9a-zA-Z!@#$%^*+=-]{8,16}$/; //비밀번호패턴
		
		if(!pwPattern.test(pw)){
			alert("비밀번호를 8 - 16자리로 입력해주세요.");
			$('#pw').val("");
			$('#pw').focus();
			return false;
		}else{
			$('.updateForm').submit();
		}
	}
</script>
<div class="joinDiv">
	<form action="/member/memberUpdate" method="post" class="updateForm">
		<ul>
			<li>
				<label class="joinlabel">아 이 디  :</label><input type = "text" name = "id" class="memjoin form-control1" value="${mem.id}" readonly>
			</li>
			<li>
				<label class="joinlabel">비밀번호:</label><input type = "password" name = "pw" id="pw" class="memjoin form-control1" placeholder="변경할 비밀번호를 입력해주세요.">
			</li>
			<li>
				<label class="joinlabel">이 메 일  :</label><input type ="email" name = "email" class="memjoin form-control1" value="${mem.email}" readonly>
			</li>
			<li>
				<label class="joinlabel">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_first" class="memjoin form-control1" value="${mem.name_first}" readonly>
			</li>
			<li>
				<label class="joinlabel">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_last" class="memjoin form-control1" value="${mem.name_last}" readonly>
			</li>
			
		</ul>
	<input type="button" value="뒤로가기" onclick="history.back(-1);" class="btn btn-default loginButton joinButton"> 
	<input type="button" onclick="memberMg();" value="수정" class="btn btn-default loginButton joinButton">
	<input type="reset" value="초기화" class="btn btn-default loginButton joinButton">
	<input type="button" value="회원탈퇴" class="btn btn-default loginButton joinButton" onclick="memberDelete(${mem.id});">
	</form>
</div>