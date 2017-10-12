<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$( function() {
    $( "#tabs" ).tabs();
  } );
</script>
<div id="content">
   <div class="loginForm">
      <div class="loginFormDiv">
         <div class="loginImgDiv"></div><!-- 이미지 div -->
<!--          <div class="loginFromDiv"> -->
<%--             <form action="<c:url value='/member/login'/>" method="post" class="loginFormInfo" name="login"> --%>
<!--                            <div class="form-group" style="width: 400px; margin-left: 90px;"> -->
<!--                               <input type="text" id="id" class="id form-control" name="id" placeholder="아이디를 입력하세요."/> -->
<!--                            </div> -->
<!--                            <div class="form-group" style="width: 400px; margin-left: 90px;"> -->
<!--                               <input type="password" id="pw" class="pw form-control" name="pw" placeholder="비밀번호를 입력하세요."/> -->
<!--                            </div> -->
<!--                            <button type="button" class="btn btn-default loginButton" onclick="loginButton();" >로그인</button> -->
<!--                            <button type="button" class="btn btn-default loginButton" onclick="joinMember();">회원가입</button> -->
<!--                            <button type="button" class="btn btn-default loginButton" onclick="adminButton();">관리자 로그인</button> -->
<!--             </form> -->
<!--          </div> -->
         <div class="loginFormDivInfo">
            <div id="tabs" style="height: 0; background: none; border: 0;">
               <ul style="background: none; border: 0; margin-left: 45%; margin-top: 2%;">
                  <li style="margin-right: 30px; background: silver; border: none;"><a href="#tabs-1">사용자</a></li>
                  <li style="background: silver; border: none;"><a href="#tabs-2">관리자</a></li>
               </ul>
               <div id="tabs-1">
                  <div class="loginFromDiv" style="margin-top: 1%;">
                     <form id="memForm" action="<c:url value='/member/login'/>" method="post" class="loginFormInfo" name="login">
                        <div class="form-group" style="width: 400px; margin-left: 90px;">
                           <input type="text" id="id" class="id form-control" name="id" placeholder="아이디를 입력하세요." style="margin-left: -2.4%;"/>
                        </div>
                        <div class="form-group" style="width: 400px; margin-left: 90px;">
                           <input type="password" id="pw" class="pw form-control" name="pw" placeholder="비밀번호를 입력하세요."style="margin-left: -2.4%;"/>
                        </div>
                        <button type="button" class="btn btn-default loginButton" onclick="loginButton();" style="margin-left: -0.1%;">로그인</button>
                        <button type="button" class="btn btn-default loginButton" onclick="joinMember();">회원가입</button>
                     </form>
                  </div>
               </div>
               <div id="tabs-2">
                  <div class="adminLogin">
                     <form id="adForm" action="<c:url value='/admin/adminlogin'/>" method="post" class="aloginFormInfo" name="login">
                        <div class="form-group" style="width: 400px; margin-left: 90px;">
                           <input type="text" id="aid" class="aid form-control" name="id" placeholder="아이디를 입력하세요."/>
                        </div>
                        <div class="form-group" style="width: 400px; margin-left: 90px;">
                           <input type="password" id="apw" class="apw form-control" name="pw" placeholder="비밀번호를 입력하세요."/>
                        </div>
                        <button type="button" class="btn btn-default loginButton" onclick="adminLoginButton();" >로그인</button>
                     </form>
                  </div>
               </div>
            </div>
         </div>
         
      </div>
   </div>
</div>
<script>
   function joinMember(){
      location.href="/member/joinForm";
   }
   function adminButton(){
      swal("관리자 로그인화면으로 넘어 감니다.");
      location.href="/admin/loginForm";
   }
</script>
<script>
   $(function(){
	   
      var result = ${failed};
      alert("aaaaa")
      if(result == false){
    	  var msg = "${msg}";
         swal(msg);
         msg = "";
         result = true;
      }
   })
</script>
<script>
 function loginButton(){
//       var id = $('.id').val().trim();
//       var pw = $('.pw').val().trim();
//       if(id==""){
//     	  swal("warning", "아이디를 입력해주세요", "error");
//          $('.id').focus();
//          return false;
//       }else if(pw==""){
//     	  swal("warning", "비밀번호를 입력해주세요", "error");
//          $('.pw').focus();
//          return false;
//       }else{
//           $('.loginFormInfo').submit();
//       }
	var id = $('.id').val().trim();
    var pw = $('.pw').val().trim();
	var action = $("#memForm").attr('action');
	var form_data = {
		id: id,
		pw: pw,
		is_ajax: 1
	};
	if(id==""){
   	 swal("warning", "아이디를 입력해주세요", "error");
        $('.id').focus();
        return false;
     }else if(pw==""){
   	  swal("warning", "비밀번호를 입력해주세요", "error");
        $('.pw').focus();
        return false;
     }else{
		$.ajax({
			type: "POST",
			
			url: action,
			data: form_data,
			success: function(aa) {

					location.replace("/member/main")
			}
		});
		return false;
	}
 }
   
function adminLoginButton(){
//       var id = $('.aid').val().trim();
//       var pw = $('.apw').val().trim();
//       if(id==""){
//     	 swal("warning", "아이디를 입력해주세요", "error");
//          $('.aid').focus();
//          return false;
//       }else if(pw==""){
//     	  swal("warning", "비밀번호를 입력해주세요", "error");
//          $('.apw').focus();
//          return false;
//       }else{
//           $('.aloginFormInfo').submit();
//       }
   	var id = $('.aid').val().trim();
    var pw = $('.apw').val().trim(); 
  	var action = $("#adForm").attr('action');
	var form_data = {
		id: id,
		pw: pw,
		is_ajax: 1
	};
	$.ajax({
		type: "POST",
		url: action,
		data: form_data,
		success: function() {
				location.replace("/admin/adminpage");	
		}
	});
	return false;
   }
</script>