<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="mainDiv">
		<button type="button" class="btn btn-default loginButton" onclick="memberList();">회원 리스트</button>
</div>

<script>

	function memberList(){
		location.href="/admin/memList"
	}
</script>