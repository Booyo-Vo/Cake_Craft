<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<h1>공지 게시판</h1>
<!-- 작성자, 공지내용 검색 -->
<form action="${pageContext.request.contextPath}/board/noticeList" method="get">
	<div>
		<input type="text" name="searchRegId" placeholder="작성자 입력">
		<input type="text" name="searchWord" placeholder="공지내용 입력">
		
		<button type="submit">검색</button>
	</div>
</form>
<div>
	<a href="${pageContext.request.contextPath}/board/addNotice"><button type="button">공지사항 작성</button></a>
</div>
<!-- 공지 목록 -->
<table>
	<thead>
		<tr>
			<td>noticeNo</td>
			<td>noticeTitle</td>
			<td>regDtime</td>
			<td>regId</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="n" items="${noticeList}">
			<tr>
				<td>${n.noticeNo}</td>
				<td>
					<a href="${pageContext.request.contextPath}/board/noticeByNo?noticeNo=${n.noticeNo}">${n.noticeTitle}</a>
				</td>
				<td>${n.regDtime}</td>
				<td>${n.regId}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>