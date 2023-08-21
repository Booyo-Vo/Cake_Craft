<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>approvalDocumentListByApprId</title>
</head>
<body>
	<h1>approvalDocumentListByApprId</h1>
	<!-- 결재자로 지정된 문서 목록 시작 -->
	<table>
		<thead>
			<tr>
				<td>documentNo</td>
				<td>approvalDocumentCd</td>
				<td>documentTitle</td>
				<td>modDtime</td>
				<!-- <td>결재이력</td> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach var="ada" items="${apprDocListByApprId}">
				<tr>
					<td>${ada.documentNo}</td>
					<td>${ada.approvalDocumentCd}</td>
					<td>${ada.documentTitle}</td>
					<td>${ada.modDtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<a href="/cakecraft/approval/addApprDoc">기안문작성</a>
	</div>
	
</body>
</html>