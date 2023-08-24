<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
<meta charset="UTF-8">
</head>
<body>  
	<h1>기안서</h1>
	<form action="/cakecraft/approval/addApprDoc" method="post" name = "requestForm" id ="requestForm">
	<div id="testid">
		<table border="1">
			<tr>
				<th>문서번호</th>
				<td></td>
				<th rowspan="3">결<br>재</th>
				<th>담당자</th>
				<th>결재자1</th>
				<th>결재자2</th>
			</tr>
			<tr>
				<th>문서형식</th>
				<td>
					<select name="approvalDocumentNm">
						<option value="">=== 선택하세요 ===</option>
						<option value="업무">업무</option>
						<option value="인사">인사</option>
						<option value="품의">품의</option>
					</select>
				</td>
				<td rowspan="2"><input type="text" name="approvalIdLv1" value="${loginId}" readonly="readonly"></td>
				<td rowspan="2"><input type="text" name="approvalIdLv2" value="232211558"></td>
				<td rowspan="2"><input type="text" name="approvalIdLv3" value="232227088"></td>
			</tr>
			<tr>
				<th>기안일자</th>
				<td></td>
			</tr>
			<tr>
				<th>기 안 자</th>
				<td><input type="text" name="loginId" value="${loginId}" readonly="readonly"></td>
				<th>참<br>조</th>
				<td colspan="3"></td>
			</tr>
			<tr>
				<th>제 &nbsp; &nbsp; 목</th>
				<td colspan="5"><input type="text" name="documentTitle" id ="documentTitle" value=""></td>
			</tr>
			<tr>
				<th>내 &nbsp; &nbsp; 용</th>
				<td colspan="5"><input type="text" name="content" id ="content" size="100" value=""></td>
			</tr>
			<tr>
				<th>파 &nbsp; &nbsp; 일</th>
				<td colspan="5"></td>
			</tr>
		</table>
	</div>
	<!-- 기본값을 N으로 설정 -->
	<input type="hidden" name="tempSave" id="tempSave" value="N">
	<input type="hidden" name="documentContent" id="documentContent" value="">
	<button onclick="tempSaveAndSubmit()">임시저장</button>
          
    <button type="button" id="submitBtn" onclick="submitForm()">제출하기</button>
    
    <table border="1" style="display : none" id="ddddd">
			<tr>
				<th>문서번호</th>
				<td></td>
				<th rowspan="3">결<br>재</th>
				<th>담당자</th>
				<th>결재자1</th>
				<th>결재자2</th>
			</tr>
			<tr>
				<th>문서형식</th>
				<td>
					<select name="approvalDocumentNm">
						<option value="">=== 선택하세요 ===</option>
						<option value="업무">업무</option>
						<option value="인사">인사</option>
						<option value="품의">품의</option>
					</select>
				</td>
				<td rowspan="2"><input type="text" name="approvalIdLv1" value="${loginId}" readonly="readonly"></td>
				<td rowspan="2"><input type="text" name="approvalIdLv2" value="232211558"></td>
				<td rowspan="2"><input type="text" name="approvalIdLv3" value="232227088"></td>
			</tr>
			<tr>
				<th>기안일자</th>
				<td></td>
			</tr>
			<tr>
				<th>기 안 자</th>
				<td><input type="text" name="loginId" value="${loginId}" readonly="readonly"></td>
				<th>참<br>조</th>
				<td colspan="3"></td>
			</tr>
			<tr>
				<th>제 &nbsp; &nbsp; 목</th>
				<td colspan="5"><input type="text" name="documentTitle" id ="documentTitle" value=""></td>
			</tr>
			<tr>
				<th>내 &nbsp; &nbsp; 용</th>
				<td colspan="5"><div name="hidcontent" id ="hidcontent"></div></td>
			</tr>
			<tr>
				<th>파 &nbsp; &nbsp; 일</th>
				<td colspan="5"></td>
			</tr>
		</table>
    
</form>
<script>
	// 임시저장 버튼을 눌렀을 때 호출되는 함수
	function tempSaveAndSubmit() {
	    $("#tempSave").val('Y'); // tempSave 값을 Y로 설정
	    
	    submitForm(); // submitForm 함수 호출하여 데이터 전송
	}
	// 제출하기 버튼을 눌렀을 때 호출되는 함수
	function submitForm() {
		$('#hidcontent').html($("#content").val());
		/*
		var documentContent = $("#testid table").prop('outerHTML');  // 테이블 내용을 가져옴
		$("#documentContent").val(documentContent);
	
		$("#requestForm").submit();*/	
	}
	
</script>
</body>
</html>