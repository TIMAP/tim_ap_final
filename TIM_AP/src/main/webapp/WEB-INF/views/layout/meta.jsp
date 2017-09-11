<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- jQuery -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tech In Motion Co., LTD</title>
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
}

/* 입력태그 */
input.memjoin{
	width: 250px;
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
	height: 100%;
}
div.mainDivOne{
	width: 30%;
	height: 80%;
	background: red;
	float: left;
}
div.mainDivTwo{
	width: 30%;
	height: 80%;
	background: yellow;
	float: left;
}
div.mainDivThree{
	width: 30%;
	height: 80%;
	background: blue;
	float: left;
}
/* 로그인폼 */
div.loginForm{
	width: 100%;
	height: 100%;
	text-align: center;
/* 	background-image : url('http://superkts.com/img/css/bg0426.gif'); */
/* 	background-color: black; */
  background: linear-gradient(-135deg, #E4A972, #9941D8) fixed;  
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
	width: 17%;
	margin: 0 auto;
}

input.id,.pw{
	min-height: 34px;
	padding-top: 7px;
	padding-bottom: 7px;
	margin-bottom: 0;
}
button.loginButton{
	margin: 2% 3%;
}
</style>