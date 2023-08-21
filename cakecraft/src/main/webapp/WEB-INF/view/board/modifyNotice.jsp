<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craftjsp</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<h1>공지사항 수정</h1>
	<form action="${pageContext.request.contextPath}/board/modifyNotice" method="post">
		<input type="hidden" name="id" value="${loginId}">
		<input type="hidden" name="noticeNo" value="${noticeByNo.noticeNo}">
		<table>
			<tr>
				<td>noticeTitle</td>
				<td>
					<input type="text" name="noticeTitle" value="${noticeByNo.noticeTitle}">
				</td>
			</tr>
			<tr>
				<td>noticeContent</td>
				<td>
					<textarea rows="3" cols="40" name="noticeContent">${noticeByNo.noticeContent}</textarea>
				</td>
			</tr>
		</table>
		<a href="${pageContext.request.contextPath}/board/noticeByNo?noticeNo=${noticeByNo.noticeNo}"><button type="button">취소</button></a>
		<button type="submit">확인</button>
	</form>
</div>
</body>
</html>