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
	<h1>게시글 상세보기</h1>
	<table>
		<tr>
			<td>anonyTitle</td>
			<td>${anonyByNo.anonyTitle}</td>
		</tr>
		<tr>
			<td>noticeContent</td>
			<td>${anonyByNo.anonyContent}</td>
		</tr>
		<tr>
			<td>likeCnt</td>
			<td>${anonyByNo.likeCnt}</td>
		</tr>
		<tr>
			<td>reg_id</td>
			<td>${anonyByNo.regId}</td>
		</tr>
		<tr>
			<td>mod_id</td>
			<td>${anonyByNo.modId}</td>
		</tr>
		<tr>
			<td>reg_dtime</td>
			<td>${anonyByNo.regDtime}</td>
		</tr>
		<tr>
			<td>mod_dtime</td>
			<td>${anonyByNo.modDtime}</td>
		</tr>
	</table>
	<a href="${pageContext.request.contextPath}/board/anonyList">취소</a>
	<a href="${pageContext.request.contextPath}/board/removeAnony?anonyNo=${anonyByNo.anonyNo}">삭제</a>
	<a href="${pageContext.request.contextPath}/board/modifyAnony?anonyNo=${anonyByNo.anonyNo}">수정</a>
</div>
</body>
</html>