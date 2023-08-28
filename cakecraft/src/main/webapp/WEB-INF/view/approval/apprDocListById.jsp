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
	<h1>기안문서</h1>
	<!-- 본인이 기안한 결재문서 리스트 시작 -->
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
			<c:forEach var="ad" items="${apprDocListById}">
				<tr>
					<td><a href="/cakecraft/approval/apprDocByNo?documentNo=${ad.documentNo}">${ad.documentNo}</a></td>
					<td>${ad.approvalDocumentCd}</td>
					<td>${ad.documentTitle}</td>
					<td>${ad.modDtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<a href="/cakecraft/approval/addApprDoc">기안문작성</a>
	</div>
</div>
</body>
</html>