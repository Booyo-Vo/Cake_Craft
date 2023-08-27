<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<h1>문의 상세보기</h1>
	<table>
		<tr>
			<td>questionTitle</td>
			<td>${questionByNo.questionTitle}</td>
		</tr>
		<tr>
			<td>questionContent</td>
			<td>${questionByNo.questionContent}</td>
		</tr>
		<tr>
			<td>secretYn</td>
			<td>${questionByNo.secretYn}</td>
		</tr>
		<tr>
			<td>reg_id</td>
			<td>${questionByNo.regId}</td>
		</tr>
		<tr>
			<td>mod_id</td>
			<td>${questionByNo.modId}</td>
		</tr>
		<tr>
			<td>reg_dtime</td>
			<td>${questionByNo.regDtime}</td>
		</tr>
		<tr>
			<td>mod_dtime</td>
			<td>${questionByNo.modDtime}</td>
		</tr>
	</table>
	<a href="${pageContext.request.contextPath}/board/questionList">취소</a>
	<a href="${pageContext.request.contextPath}/board/removeQuestion?questionNo=${questionByNo.questionNo}">삭제</a>
	<a href="${pageContext.request.contextPath}/board/modifyQuestion?questionNo=${questionByNo.questionNo}">수정</a>
</div>
</body>
</html>