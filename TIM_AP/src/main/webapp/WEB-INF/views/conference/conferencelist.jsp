<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.tim.ap.entity.ConferenceEntity"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	var a = ${aaa};
	alert(a);
</script>
<style>
table {
	border: 1px solid #444444;
	text-align: center;
	border-collapse: collapse;
}
th, tr, td  {
	border: 1px solid #444444;
	padding: 10px;
}
</style>
<p>회의 리스트들을 보여줍니다.</p>

<div style="text-align: center;">
	<div>
		<form action="/conference/conferencelist">
			<select name="index">
				<option value="title" selected="selected">제목</option>
				<option value="date" >날짜</option>
			</select> 
			<input type="hidden" value="${select.index}"> 
			<input type="text" name="val" value="${select.val}" > 
			<input type="submit" value="검색" >
		</form>
	</div>
</div>
<br/>

<button><a href="/audio/form">회의 추가</a></button>
<table>
	<tr>
		<th>No.</th>
		<th>제목</th>
		<th>등록일</th>
		<th>참여권한</th>
		<th>참여자수</th>
	</tr>
<%-- 	<c:choose> --%>
<%-- 		<c:when test="${viewData.boardTotalCount > 0 }"> --%>
			<c:forEach items="${conferenceList }" var="confer" varStatus="i">
				<tr>
					<td><a href="/conference/join">${confer.id }</a></td>
					<td>${confer.title }</td>
					<td>${confer.date}</td>
					<td>${confer.role }</td>
					<td>${confer.entry }</td>
				</tr>
			</c:forEach>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<!-- 			<tr> -->
<!-- 				<td style="text-align: center;" colspan="5">내용이 없습니다.</td> -->
<!-- 			</tr> -->
<%-- 		</c:otherwise> --%>
<%-- 	</c:choose> --%>
</table>


<div id="pageNum">
	<c:if test="${beginPage > perPage}">
		<a href="<c:url value="/conference/conferencelist?page=${beginPage-1}&index=${select.index}&val=${select.val}"/>">이전</a>
	</c:if>
	<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
		<a href="<c:url value="/conference/conferencelist?page=${pno}&index=${select.index}&val=${select.val}" />">[${pno}]</a>
	</c:forEach>
	<c:if test="${endPage < viewData.getPageTotalCount()}">
		<a href="<c:url value="/conference/conferencelist?page=${endPage + 1}&index=${select.index}&val=${select.val}"/>">다음</a>
	</c:if>
</div>
