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
	<h1>결재수신문서</h1>
	<!-- 결재자로 지정된 문서 목록 시작 -->
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
			<c:forEach var="ada" items="${apprDocListByApprId}">
				<tr>
					<td><a href="/cakecraft/approval/apprDocByNo?documentNo=${ada.documentNo}">${ada.documentNo}</a></td>
					<td>${ada.approvalDocumentCd}</td>
					<td>${ada.documentTitle}</td>
					<td>${ada.modDtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>