<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container"> 
	<h1>기안서</h1>
	<form action="/cakecraft/approval/addApprDoc" method="post" name="requestForm" id="requestForm">
	<div id="tableTempY">
		<table border="1">
			<tr>
				<th>문서번호</th>
				<td>${documentNo}</td>
				<th rowspan="3">결<br>재</th>
				<th>담당자</th>
				<th>결재자1</th>
				<th>결재자2</th>
			</tr>
			<tr>
				<th>문서구분</th>
				<td>
					<select name="approvalDocumentNm" id="approvalDocumentNm">
						<option value="">=== 선택하세요 ===</option>
						<option value="업무">업무</option>
						<option value="인사">인사</option>
					</select>
				</td>
				<td rowspan="2"><input type="text" name="approvalIdLv1" id="approvalIdLv1" value="${loginId}" readonly="readonly"></td>
				<td rowspan="2"><input type="text" name="approvalIdLv2" id="approvalIdLv2" value=""></td>
				<td rowspan="2"><input type="text" name="approvalIdLv3" id="approvalIdLv3" value=""></td>
			</tr>
			<tr>
				<th>항목구분</th>
				<td>
					<select name="Nm" id="Nm">
						<option value="">=== 선택하세요 ===</option>
						<option value="연차">연차</option>
						<option value="반차">반차</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>기 안 자</th>
				<td><input type="text" name="loginId" id="loginId" value="${loginId}" readonly="readonly"></td>
				<th>참<br>조</th>
				<td colspan="3"><input type="text" name="refId" id="refId" value=""></td>
			</tr>
			<tr>
				<th>기안일자</th>
				<td colspan="5"><input type="text" name="crntDT" id="crntDT" value="${currentDate}" readonly="readonly"></td>
			</tr>
			<tr>
				<th>시행일자</th>
				<td colspan="5">
					<input type="datetime-local" name="startDT" id="startDT">
					~
					<input type="datetime-local" name="endDT" id="endDT">
				</td>
			</tr>
			<tr>
				<th>제 &nbsp; &nbsp; 목</th>
				<td colspan="5"><input type="text" name="documentTitle" id="documentTitle" value=""></td>
			</tr>
			<tr>
				<th>내 &nbsp; &nbsp; 용</th>
				<td colspan="5"><input type="text" name="content" id="content" size="100" value=""></td>
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
    <br>
    
    <br>
    
    <div id="tableTempN">      
	    <table border="1" id="submitTable">
			<tr>
				<th>문서번호</th>
				<td>${documentNo}</td>
				<th rowspan="3">결<br>재</th>
				<th>담당자</th>
				<th>결재자1</th>
				<th>결재자2</th>
			</tr>
			<tr>
				<th>문서구분</th>
				<td><div id="hidapprovalDocumentNm"></div></td>
				<td rowspan="2"><div id="hidApprIdLv1"></div></td>
				<td rowspan="2"><div id="hidApprIdLv2"></div></td>
				<td rowspan="2"><div id="hidApprIdLv3"></div></td>
			</tr>
			<tr>
				<th>항목구분</th>
				<td><div id="hidNm"></div></td>
			</tr>
			<tr>
				<th>기 안 자</th>
				<td><div id="hidloginId"></div></td>
				<th>참<br>조</th>
				<td colspan="3"><div id="hidRefId"></div></td>
			</tr>
			<tr>
				<th>기안일자</th>
				<td colspan="5"><div id=hidCrntDT></div></td>
			</tr>
			<tr>
				<th>시행일자</th>
				<td colspan="5">
					<div id="hidStartDT"></div>
					~
					<div id="hidEndDT"></div>
				</td>
			</tr>
			<tr>
				<th>제 &nbsp; &nbsp; 목</th>
				<td colspan="5"><div id="hidTitle"></div></td>
			</tr>
			<tr>
				<th>내 &nbsp; &nbsp; 용</th>
				<td colspan="5"><div id="hidcontent"></div></td>
			</tr>
			<tr>
				<th>파 &nbsp; &nbsp; 일</th>
				<td colspan="5"></td>
			</tr>
		</table>
	</div>
</form>
</div>
<script>
	// 임시저장 버튼을 눌렀을 때 호출되는 함수
	function tempSaveAndSubmit() {
	    $("#tempSave").val('Y'); // tempSave 값을 Y로 설정
	    
		var documentContent = $("#tableTempY table").prop('outerHTML');  // TempY 임시저장할 테이블 내용을 가져옴
		$("#documentContent").val(documentContent);
	
		$("#requestForm").submit();
			
		
	}
	// 제출하기 버튼을 눌렀을 때 호출되는 함수
	function submitForm() {
		$('#hidapprovalDocumentNm').html($("#approvalDocumentNm").val());
		$('#hidApprIdLv1').html($("#approvalIdLv1").val());
		$('#hidApprIdLv2').html($("#approvalIdLv2").val());
		$('#hidApprIdLv3').html($("#approvalIdLv3").val());
		$('#hidNm').html($("#Nm").val());
		$('#hidloginId').html($("#loginId").val());
		$('#hidRefId').html($("#refId").val());
		$('#hidCrntDT').html($("#crntDT").val());
		$('#hidStartDT').html($("#startDT").val());
		$('#hidEndDT').html($("#endDT").val());
		$('#hidTitle').html($("#documentTitle").val());
		$('#hidcontent').html($("#content").val());
		
		var documentContent = $("#tableTempN table").prop('outerHTML');  // TempN 제출할 테이블 내용을 가져옴
		$("#documentContent").val(documentContent);
	
		$("#requestForm").submit();
			
	}
</script>
</body>
</html>