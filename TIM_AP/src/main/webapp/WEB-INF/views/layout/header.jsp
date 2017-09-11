<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="container-fliud headerTopColor">
		<c:if test="${id != null }">	
			<div class="headerImg textLeft">
				<img src="/resources/images/TECHINMOTION1.png" width="300px" height="100px">
			</div>
			<div id="headerInfo" class="headerImg textRight">
				<a class="headerTop">
					<a href="/member/userInfo?id=${id}">${id}</a>(${name })님 안녕하세요. 
					<a href="/member/main" class="btn btn-default btn-header">
						<i class="fa-lg fa fa-home" aria-hidden="true"></i>Home
					</a>
					<a href="/member/logout" class="btn btn-default btn-header">
						<i class="fa-lg fa fa-sign-out" aria-hidden="true"></i>Logout
					</a>
				</a>
			</div>
		</c:if>
	</div>