<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<h1>공지 상세보기</h1>
	<table>
		<tr>
			<td>noticeTitle</td>
			<td>${noticeByNo.noticeTitle}</td>
		</tr>
		<tr>
			<td>noticeContent</td>
			<td>${noticeByNo.noticeContent}</td>
		</tr>
		<tr>
			<td>reg_id</td>
			<td>${noticeByNo.regId}</td>
		</tr>
		<tr>
			<td>mod_id</td>
			<td>${noticeByNo.modId}</td>
		</tr>
		<tr>
			<td>reg_dtime</td>
			<td>${noticeByNo.regDtime}</td>
		</tr>
		<tr>
			<td>mod_dtime</td>
			<td>${noticeByNo.modDtime}</td>
		</tr>
	</table>
	<a href="${pageContext.request.contextPath}/board/noticeList">취소</a>
	<!-- 작성자만 수정,삭제버튼 출력 -->
	<c:if test="${loginId == noticeByNo.id}">
		<a href="${pageContext.request.contextPath}/board/removeNotice?noticeNo=${noticeByNo.noticeNo}">삭제</a>
		<a href="${pageContext.request.contextPath}/board/modifyNotice?noticeNo=${noticeByNo.noticeNo}">수정</a>
	</c:if>
</div>
</body>
</html>