<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.tim.ap.entity.ConferenceEntity"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>


	$(function(){
		//상태 변경 버튼 숨김	
		$("#closedBtn").hide();

		//전체선택 체크박스 클릭
		$("#allCheck").click(function() {
		
				//만약 전체 선택 체크박스가 체크된상태일경우 
				if ($("#allCheck").prop("checked")) {
					// 전체 선택시 상태 변경 버튼 보이게
					$("#closedBtn").show();
					//해당화면에 전체 checkbox들을 체크해준다 
					$("input[type=checkbox]").prop("checked", true);
					// 전체선택 체크박스가 해제된 경우
				} else {
					//전체 선택시 상태 변경 버튼 숨김
					$("#closedBtn").hide();
					//해당화면에 모든 checkbox들의 체크를해제시킨다. 
					$("input[type=checkbox]").prop("checked", false);
				}
			})
	})

	function conferUpdate() {
		var items=[];
		$('input[name="confer_chk"]:checkbox:checked').each(function(){items.push($(this).val());});
		alert(items);
		$.ajax({
			url : '/conference/conferenceUpdate',
			type : 'post',
			data :  {'confer_chk': items},
			success : function(result) {
				location.href=result.uri;
			},
			error : function() {
				
			},
			dataType : 'json'
		})
	}

	function check(){

		 if($("input:checkbox[name='confer_chk']").is(":checked")){
			//체크박스 선택시 상태 변경 버튼 보이게	
			 $("#closedBtn").show();
	        }
		 else{
			//체크박스 해제시 상태 변경 버튼 숨김	
			 $("#closedBtn").hide();
		 }
	}

</script>
<style>
table {
	border: 1px solid #444444;
	text-align: center;
	border-collapse: collapse;
	background: white;
}

th, tr, td {
	text-align: center;
	border: 1px solid #444444;
	padding: 10px;
}
</style>

<div style="text-align: center; padding-top: 5%" class="mainDiv">
	<div>
		<form action="/conference/conferencelist">
			<select name="index" class="btn btn-default loginButton joinButton conferenceSelect">
				<option value="title" selected="selected">제목</option>
				<option value="date">날짜</option>
			</select> 
			<input type="hidden" value="${select.index}"> 
			<input type="text" class="memjoin form-control1 conferenceSelect" name="val" value="${select.val}"> 
			<input type="submit" class="btn btn-default loginButton joinButton conferenceSelect" value="검색"> 
			<input type="button" class="btn btn-default loginButton joinButton conferenceSelect" value="회의 추가" 
			            onclick="location.href='/audio/form'" class="btn">
			<input type="button" class="btn btn-default loginButton joinButton conferenceSelect" value="뒤로 가기" 
			   	  	  	onclick="history.back(-1);" class="btn">
			<input type="button" id="closedBtn" class="btn btn-default loginButton joinButton conferenceSelect" value="상태변경"
						onclick="conferUpdate();">
		</form>
	</div>
	<table class="table table-bordered table-hover conferenceList"
		style="margin: 1% auto 1% auto;">
		<tr>
		<!-- 관리자 일때만 전체 선택 체크박스 보임-->	
			<c:if test="${id eq 1004 }">
			<th><input type="checkbox" id="allCheck" value="1"></th>
			</c:if>
			<c:if test="${id ne 1004 }">
			<th></th>
			</c:if>
			
			<th>No.</th>
			<th>제목</th>
			<th>등록일</th>
			<th>참여권한</th>
			<th>참여자수</th>
		</tr>
		<c:choose>
			<c:when test="${viewData.boardTotalCount > 0 }">
				<c:forEach items="${viewData.conferList }" var="confer" varStatus="i">
 					<tr>
						<!-- 작성자 이거나 관리자 일때만 체크박스 보임-->				
						<c:if test="${sessionScope.id == confer.u_id or id eq 1004}">
							<td><input type="checkbox" name="confer_chk"
							value="${confer.id}/${confer.closed}" onchange="check()"></td>
						</c:if>
						<!-- 작성자 이거나 관리자가 아닐때 공백 -->	
						<c:if test="${sessionScope.id != confer.u_id and id ne 1004}">
							<td></td>
						</c:if>
						<td>${confer.id }</td>
						<td><c:choose>
								<c:when test="${confer.closed eq 'N' }">
									<a href="/audio/list?c_id=${confer.id }"
										style="background: yellow; color: black;">${confer.title }</a>
								</c:when>
								<c:otherwise>
									<!-- 관리자나 작성자  일때만 보류상태떄 입장가능 -->	
									<c:if test="${sessionScope.id == confer.u_id or id eq 1004}">
										<a href="/audio/list?c_id=${confer.id }"
											style="background: red; color: white;">${confer.title} -
											(회의 보류)</a>
									</c:if>
									<!-- 관리자나 작성자  아닐때 보류상태떄 입장불가능 -->	
									<c:if test="${sessionScope.id != confer.u_id and id ne 1004 }">
										<a style="background: red; color: white;">${confer.title}
											- (회의 보류)</a>
									</c:if>
								</c:otherwise>
							</c:choose></td>
						<td>${confer.date}</td>
						<td>${confer.role }</td>
						<td>${confer.entry }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td style="text-align: center;" colspan="6">내용이 없습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>


	<div id="pageNum">
		<c:if test="${beginPage > perPage}">
			<a
				href="<c:url value="/conference/conferencelist?page=${beginPage-1}&index=${select.index}&val=${select.val}"/>">이전</a>
		</c:if>
		<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
			<a
				href="<c:url value="/conference/conferencelist?page=${pno}&index=${select.index}&val=${select.val}" />">[${pno}]</a>
		</c:forEach>
		<c:if test="${endPage < viewData.getPageTotalCount()}">
			<a
				href="<c:url value="/conference/conferencelist?page=${endPage + 1}&index=${select.index}&val=${select.val}"/>">다음</a>
		</c:if>
	</div>
</div>
