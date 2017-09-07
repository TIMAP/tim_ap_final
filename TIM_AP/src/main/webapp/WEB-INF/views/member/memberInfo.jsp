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
</script>
<div class="joinDiv">
	<form action="/member/memberUpdate" method="post">
		<ul>
			<li>
				<label class="joinlabel">아 이 디  :</label><input type = "text" name = "id" class="memjoin" value="${mem.id}" readonly>
			</li>
			<li>
				<label class="joinlabel">비밀번호:</label><input type = "password" name = "pw" class="memjoin" placeholder="변경할 비밀번호를 입력해주세요.">
			</li>
			<li>
				<label class="joinlabel">이 메 일  :</label><input type ="email" name = "email" class="memjoin" value="${mem.email}" readonly>
			</li>
			<li>
				<label class="joinlabel">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_first" class="memjoin" value="${mem.name_first}" readonly>
			</li>
			<li>
				<label class="joinlabel">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label><input type = "text" name = "name_last" class="memjoin" value="${mem.name_last}" readonly>
			</li>
		</ul>
	<input type="button" value="뒤로가기" onclick="history.back(-1);" class="btn"> 
	<input type="submit" value="수정" class="btn">
	<input type="reset" value="초기화" class="btn">
	<input type="button" value="회원탈퇴" class="btn" onclick="memberDelete(${mem.id});">
	</form>
</div>