<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>approvalDocumentList</title>
</head>
<body>
	<h1>approvalDocumentList</h1>
	<!-- 본인이 기안한 결재문서 리스트 시작 -->
	<table>
		<thead>
			<tr>
				<td>documentNo</td>
				<td>documentContent</td>
				<td>approvalDocumentCd</td>
				<td>modDtime</td>
				<!-- <td>결재이력</td> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach var="ad" items="${apprDocList}">
				<tr>
					<td>${ad.documentNo}</td>
					<td>${ad.documentContent}</td>
					<td>${ad.approvalDocumentCd}</td>
					<td>${ad.modDtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>