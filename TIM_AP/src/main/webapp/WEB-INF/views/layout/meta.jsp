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
	height: 76%;
}
</style>