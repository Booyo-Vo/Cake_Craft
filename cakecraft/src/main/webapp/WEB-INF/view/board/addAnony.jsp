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
	<h1>게시글 작성</h1>
	<form action="${pageContext.request.contextPath}/board/addAnony" method="post">
		<input type="hidden" name="id" value="${loginId}">
		<table>
			<tr>
				<td>anonyTitle</td>
				<td>
					<input type="text" name="anonyTitle">
				</td>
			</tr>
			<tr>
				<td>anonyContent</td>
				<td>
					<textarea rows="3" cols="40" name="anonyContent"></textarea>
				</td>
			</tr>
		</table>
		<a href="${pageContext.request.contextPath}/board/anonyList"><button type="button">취소</button></a>
		<button type="submit">확인</button>
	</form>
</div>
</body>
</html>