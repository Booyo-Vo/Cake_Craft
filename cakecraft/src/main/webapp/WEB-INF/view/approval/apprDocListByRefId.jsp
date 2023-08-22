<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<h1>approvalDocumentListByRefId</h1>
	<!-- 참조자로 지정된 문서 목록 시작 -->
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
			<c:forEach var="adr" items="${apprDocListByRefId}">
				<tr>
					<td><a href="apprDocByNo?documentNo=${adr.documentNo}">${adr.documentNo}</a></td>
					<td>${adr.approvalDocumentCd}</td>
					<td>${adr.documentTitle}</td>
					<td>${adr.modDtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>