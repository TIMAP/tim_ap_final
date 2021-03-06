<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="/resources/js/boot/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="/resources/js/boot/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="/resources/js/boot/bootstrap.min.js"></script>
<!-- sweetalert js -->
<script src="/resources/js/sweetalert.min.js"></script>
<!-- jQuery -->
<link rel="stylesheet" href="/resources/js/boot/jquery-ui.css">
<script type="text/javascript" src="/resources/js/boot/jquery-3.2.1.min.js"></script>
<script src="/resources/js/boot/jquery-ui.js"></script>
<script src="/resources/js/jQuery.form.js"></script>
<script src="/resources/js/member/member.js"></script>
<style>
*{
	padding: 0;
	margin: 0;
}
/* 해더부분 */
div.headerImg{ 
	display: inline-block; 
} 
.textCenter {
	text-align : center;
}
.textRight {
	text-align : right;
}
.textLeft {
	text-align : left;
}
div #headerInfo{
	text-align : right;
	float: right;
	margin-right: 10%; 
	padding-top: 1%;
}

a{
	font-weight: bold;
}

.headerImg{
	padding-left: 3%;
}

/* 입력태그 */
input.memjoin{
	width: 300px;
}
/* 버튼 */
input.btn{
	width: 60px;
	height: 30px;
	margin: 0px 10px;
}
/* 회원가입 큰 div */
.joinDiv{
	text-align: center;
}

/* 어드민 조인 */

.ajoinDiv{
/* 	background: linear-gradient(-135deg, #E4A972, #9941D8) fixed;   */
	text-align: center;
	height: 90%;
}
div.adminLogin{
   margin-top: 1%;
   margin-right:35.5%;
   padding-bottom : 1%;
   float:right;
   width: 30%;
   border-radius:50px;
}

div.ajoinForm{
	background: rgba(255, 255, 255, 0.8);
	width:30%;
	padding-top: 3%;
	float: left;
	padding-bottom: 3%;
	border-radius:50px;
	margin-left: 34%;
	margin-top: 3%;
}

ul.ajoinUl{
	margin: 0 10%;
/* 	width:40%; */
	list-style: none;
}

div.aExcelCsv{
	margin-top: 3%;
	margin-right:36%;
  	background: rgba(123, 123, 123, 0.8);  
	float:right;
	width: 30%;
	height:397px;
	padding-top: 3%;
	border-radius:50px;
}

/* 회원가입시 라벨 */
.joinlabel{
	display: inline-block;
	width: 80px;
}
/* 회원가입시 라벨 왼쪽정렬 */
ul li label{
	text-align: left;
}

/* 메인화면 div들 */
div.mainDiv{
	width: 100%;
	height: 90%;
/* 	background: linear-gradient(-135deg, #E4A972, #9941D8) fixed;  	 */
	text-align: center;
}
div.mainDivOne{
	width: 20%;
	height: 50%;
	background: rgba(255, 255, 255, 0.8);
 	float: left; 
 	margin-left: 20%;
 	margin-top: 10%;
 	border-radius:50px;
 	 	cursor: pointer;
}
div.mainDivTwo{
	width: 20%;
	height: 50%;
	background: rgba(255, 255, 255, 0.8);
	float: left;
	margin-left: 20%;
	margin-top: 10%; 
 	border-radius:50px;
 	 	cursor: pointer;
}
/* 어드민 */
div.amainDivOne{
	width: 20%;
	height: 50%;
	background: rgba(255, 255, 255, 0.8);
 	float: left; 
 	margin-left: 10%;
 	margin-top: 10%;
 	border-radius:50px;
 	cursor: pointer;
}
div.amainDivTwo{
	width: 20%;
	height: 50%;
	background: rgba(255, 255, 255, 0.8);
	float: left;
	margin-left: 10%;
	margin-top: 10%; 
 	border-radius:50px;
 	cursor: pointer;
}
div.amainDivThree{
 	cursor: pointer;
	width: 20%;
	height: 50%;
	background: rgba(255, 255, 255, 0.8);
	float: left;
	margin-left: 10%;
	margin-top: 10%; 
 	border-radius:50px;
}
/* 로그인폼 */
div.loginForm,.joinDiv{
	width: 100%;
	height: 100%;
	text-align: center;
/* 	background-image : url('http://superkts.com/img/css/bg0426.gif'); */
/* 	background-color: black; */
/*   background: linear-gradient(-135deg, #E4A972, #9941D8) fixed;   */
/*   	background: radial-gradient(#F2B9A1, #EA6264) fixed;    */
/*  	background: radial-gradient(#EBCD22, #EA2132) fixed;   */
/*  	background: linear-gradient(-45deg, rgba(246, 255, 0, .8), rgba(255, 0, 161, .8)) fixed, url(http://www.webcreatorbox.com/sample/images/bg-cherrybrossam.jpg) fixed;  */
/*  	background-size: cover;  */

}
div.loginFormDiv{
	height: 100%;
	width: 100%;
	margin: auto auto;
	padding-top: 15%;
}
div.loginImgDiv{
	height: 20%;
	width: 25%;
	margin: 0 auto;
	background-image: url('/resources/images/TECHINMOTION1.png');
	background-repeat: no-repeat;
}
div.loginFromDiv{
/* 	border: 1px solid black; */
	height: 30%;
	width: 30%;
	margin: 0 auto;
}

input.id,.pw{
	min-height: 34px;
	padding-top: 7px;
	padding-bottom: 7px;
	margin-bottom: 0;
}

button.loginButton{
	margin: 2% 2.5%;
}

input.joinButton{
	width: 90px;
}
div.joinForm{
	padding-top: 5%;
}
ul.joinUl{
	margin: 2% auto;
}

ul li{
	margin: 1% auto;
}
div.joinImgDiv{
	height: 12%;
	width: 25%;
	margin: 0 auto;
	background-image: url('/resources/images/TECHINMOTION1.png');
	background-repeat: no-repeat;
}
.form-control1{
/*     display: block; */
    width: 30%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
/*     -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
/*     box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
div.userInfoImgDiv{
	width:32%;
	height:30%;
	margin: 25% auto 15% auto;
	background-image: url('/resources/images/if_Padlock_User_Control_88832.png');
	background-repeat: no-repeat;
}
div.conferenceImgDiv{
	width:32%;
	height:30%;
	margin: 25% auto 15% auto;
	background-image: url('/resources/images/if_Group_Meeting_Light_80844.png');
	background-repeat: no-repeat;
}
/* 어드민 */
div.auserInfoImgDiv{
	width:32%;
	height:30%;
	margin: 25% auto 15% auto;
	background-image: url('/resources/images/96af815283e9d78b1f3e7aa744ec8cb0-users.png');
	background-size: 121px;
	background-repeat: no-repeat;
}
div.aconferenceImgDiv{
	width:32%;
	height:30%;
	margin: 25% auto 15% auto;
	background-image: url('/resources/images/if_Group_Meeting_Light_80844.png');
	background-repeat: no-repeat;
}
div.aaudioImgDiv{
	width:32%;
	height:30%;
	margin: 25% auto 15% auto;
	background-image: url('/resources/images/if_shared-music_31284.png');
	background-repeat: no-repeat;
}

form.updateForm{
	padding-top: 10%;
}

form.updateForm ul{
	margin-bottom: 3%;
}

table.conferenceList{
	text-align: center;
	width: 40%;
}

.conferenceSelect{
	height: 30px;
}

.multipartFile1 { 
/* display: inline-block;  */
/* padding: .5em .75em;  */
/* color: #999;  */
font-size: inherit; 
/* line-height: normal;  */
/* vertical-align: middle;  */
background-color: #fdfdfd; 
cursor: pointer; 
border: 1px solid #ebebeb; 
/* border-bottom-color: #e2e2e2;  */
/* border-radius: .25em;  */
} 
input.multipartFile[type="file"] { 
/* 파일 필드 숨기기 */ 
 position: absolute;   
 width: 1px;   
 height: 1px;  
 padding: 0;  
 margin: -1px;  
 overflow: hidden;   
 clip:rect(0,0,0,0);  
 border: 0;  
}

div#conferenceInfo{
	padding-top: 5%;
	margin-bottom: 2%;
}

a,i {
	color: black;
}

textarea:focus{
    outline: none;
}


</style>