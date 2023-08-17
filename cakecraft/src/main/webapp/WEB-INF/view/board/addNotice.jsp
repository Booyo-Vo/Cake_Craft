<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addNotice.jsp</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<h1>공지사항 작성</h1>
<form action="/board/addNotice" method="post">
	<input type="hidden" name="id" value="${loginId} ">
	<table>
		<tr>
			<td>noticeTitle</td>
			<td>
				<input type="text" name="noticeTitle">
			</td>
		</tr>
		<tr>
			<td>noticeContent</td>
			<td>
				<textarea rows="3" cols="40" name="noticeContent"></textarea>
			</td>
		</tr>
	</table>
	<button type="submit">확인</button>
</form>
</body>
</html>