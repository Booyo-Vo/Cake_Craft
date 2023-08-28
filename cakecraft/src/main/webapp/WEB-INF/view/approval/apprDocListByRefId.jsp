<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<h1>참조문서</h1>
	<!-- 참조자로 지정된 문서 목록 시작 -->
	<table>
		<thead>
			<tr>
				<td>문서번호</td>
				<td>문서형식</td>
				<td>제목</td>
				<td>기안일자</td>
				<!-- <td>결재이력</td> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach var="adr" items="${apprDocListByRefId}">
				<tr>
					<td><a href="/cakecraft/approval/apprDocByNo?documentNo=${adr.documentNo}">${adr.documentNo}</a></td>
					<td>${adr.approvalDocumentCd}</td>
					<td>${adr.documentTitle}</td>
					<td>${adr.modDtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>