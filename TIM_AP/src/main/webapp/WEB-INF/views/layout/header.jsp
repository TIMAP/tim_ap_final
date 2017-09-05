<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="header">
<!-- 	Tiles - Header Area -->
	<img src="/resources/images/TECHINMOTION1.png" width="470px" height="124px">
</div>
<div class="container-fliud headerTopColor">
	<div class="container textRight">
		<p class="headerTop">
			${name } 님 안녕하세요. 
			<a href="/homeMain/main" class="btn btn-default btn-header">
				<i class="fa-lg fa fa-home" aria-hidden="true"></i>홈으로
			</a>
			<a href="/user/logout" class="btn btn-default btn-header">
				<i class="fa-lg fa fa-sign-out" aria-hidden="true"></i>로그아웃
			</a>
			<a href="">
			
			</a>
		</p>
	</div>
</div>