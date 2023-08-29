<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<h1>apprDocByNo</h1>
	<div>${apprDoc.documentContent}</div>
	
	<div>no : ${apprHist.approvalNo}</div>
	<div>작성자id : ${apprDoc.id}</div>
	<div>로그인한 사람 레벨 approvalLevel : ${apprHist.approvalLevel}</div>
	<div>로그인한 사람 결재여부 approvalStatusCd : ${apprHist.approvalStatusCd}</div>
	
	<br>
	
	<div>no-1 : ${apprHistPreLv.approvalNo}</div>
	<div>이전레벨 결재자 id : ${apprHistPreLv.approvalId}</div>
	<div>이전레벨 결재자 approvalLevel : ${apprHistPreLv.approvalLevel}</div>
	<div>이전레벨 결재여부 approvalStatusCd : ${apprHistPreLv.approvalStatusCd}</div>
	
	<br>
	
	<!-- 결재자로 지정된 경우 : 승인 / 반려 -->
	<c:if test="${(apprHist.approvalLevel == 2 && apprHist.approvalStatusCd == 1) 
				|| (apprHistPreLv.approvalStatusCd == 2	&& apprHist.approvalLevel == 3 && apprHist.approvalStatusCd == 1)}">
		<div>승인버튼</div>
		<div>반려버튼</div>
	</c:if>
	
	<!-- 작성자로 지정된 경우 : 기안회수 버튼 -->
	<c:if test="${apprDoc.id == loginId}">
		<div>회수버튼</div>
	</c:if>
	
	<!-- 참조자로 지정된 경우, 이미 결재를 승인한 경우 : 버튼 없음 -->
	
</body>
</html>