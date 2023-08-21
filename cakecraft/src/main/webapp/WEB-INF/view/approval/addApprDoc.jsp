<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addApprDoc</title>
<script>
	function setTempSave(value) {
	    document.getElementById("tempSaveField").value = value;
	}
</script>
</head>
<body>	
	<h1>기안서</h1>
	<form action="/cakecraft/approval/addApprDoc" method="post">
		<input type="hidden" name="approvalDocumentCd" value="품의"> <!-- 문서 분류 코드 입력 -->
        <input type="hidden" name="id" value="${loginId}">
        <input type="text" name="documentTitle"><br>
        <textarea name="documentContent" rows="4" cols="50"></textarea><br>
        <input type="text" name="approvalIdLv2" value="232211558"><br>
        <input type="text" name="approvalIdLv3" value="232227088"><br>
		<input type="hidden" name="tempSave" id="tempSaveField" value="N">
    	<button type="submit" onclick="setTempSave('Y')">임시저장</button>
		
		<button type="submit">제출하기</button>
	</form>
	
	<br>
	
	<div id="documentContent">
		<table border="1">
			<tr>
				<th>문서번호</th>
				<td><input type="text"></td>
				<th rowspan="3">결<br>재</th>
				<th>담당자</th>
				<th>결재자1</th>
				<th>결재자2</th>
			</tr>
			<tr>
				<th>문서형식</th>
				<td><input type="text"></td>
				<td rowspan="2"></td>
				<td rowspan="2"></td>
				<td rowspan="2"></td>
			</tr>
			<tr>
				<th>기안일자</th>
				<th><input type="text"></th>
			</tr>
			<tr>
				<th>기 안 자</th>
				<td><input type="text" name="id" value="${loginId}"></td>
				<th>참<br>조</th>
				<td colspan="3"><input type="text"></td>
			</tr>
			<tr>
				<th>제 &nbsp; &nbsp; 목</th>
				<td colspan="5"><input type="text"></td>
			</tr>
			<tr>
				<th>내 &nbsp; &nbsp; 용</th>
				<td colspan="5"><textarea name="content" rows="10" cols="50"></textarea></td>
			</tr>
			<tr>
				<th>파 &nbsp; &nbsp; 일</th>
				<td colspan="5"><input type="file"></td>
			</tr>
		</table>
		</div>	
	
	

<!-- 임시저장 목록 모달창 시작 -->
	<button type="button" data-bs-toggle="modal" data-bs-target="#addFcltModal">임시저장</button>
<!-- 임시저장 목록 모달창 끝 -->
		<button type="button">취소</button>
</body>
</html>