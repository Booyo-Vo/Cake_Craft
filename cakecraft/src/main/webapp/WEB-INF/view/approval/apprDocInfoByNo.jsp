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
	<h1>apprDocByNo</h1>
	<div>${apprDoc.documentContent}</div>
	
	<br>
	
	<!-- 작성자 본인인 경우 : 임시저장/제출하기 버튼 -->
	<c:if test="${apprDoc.id == loginId}">
		<div>임시저장</div>
		<div>제출하기</div>
	</c:if>
</div>
</body>
</html>