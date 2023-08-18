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
	<button type="submit">확인</button>
</form>
</body>
</html>