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
	<h1>apprDocWaitListByNo</h1>
	<!-- 결재자가 승인해야 할 문서 목록 출력 -->
	<table>
		<thead>
			<tr>
				<td>documentNo</td>
				<td>documentTitle</td>
				<!--<td>approvalDocumentCd</td>
				<td>modDtime</td>-->
				<!-- <td>결재이력</td> -->
			</tr>
		</thead>
		<tbody>
			<c:forEach var="adw" items="${apprDocList}">
				<tr>
					<td>${adw.documentNo}</td>
					<td>${adw.documentTitle}</td>
					<!-- <td>${adw.approvalDocumentCd}</td>
					<td>${adw.modDtime}</td> -->
				</tr>
			</c:forEach>
		</tbody>
	</table>	
	</div>
</body>
</html>