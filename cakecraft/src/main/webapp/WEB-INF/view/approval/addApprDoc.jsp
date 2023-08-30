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
<!-- 모달창 -->
<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
         	<!--  
            <button class="close" type="button" data-dismiss="modal" aria-label="Close"></button>
            <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           	-->
            <br>
            <h3 class="modal-title" id="exampleModalLabel">모달테스트</h3>
         </div>
         <div class="modal-body">
         <!-- 모달 내용에 선택 값을 입력하는 입력란 -->
            <input type="text" id="selectedValue" class="form-control" placeholder="선택한 값을 입력하세요">
         	<button type="button" id="selectedValueBtn">검색</button>
         	<table id="employeeTable">
         	</table>
         </div>
         <div class="modal-footer">
         <input type="hidden" id="modalValue">
            <a class="btn" id="modalY">예</a>
            <button class="btn" type="button" data-dismiss="modal">아니요</button>
         </div>
      </div>
   </div>
</div>
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
						<option value="">== 선택하세요 ==</option>
						<option value="업무">업무</option>
						<option value="인사">인사</option>
					</select>
				</td>
				<td rowspan="2"><input type="text" name="approvalIdLv1" id="approvalIdLv1" value="${loginId}" readonly="readonly"></td>
				<td rowspan="2">
					<input type="text" name="approvalIdLv2" id="approvalIdLv2" value="" readonly="readonly">
					<button type="button" class="btn btn-primary" onClick="modalcall('approvalIdLv2')">검색</button>
				</td>
				<td rowspan="2">
					<input type="text" name="approvalIdLv3" id="approvalIdLv3" value="" readonly="readonly">
					<button type="button" class="btn btn-primary" onClick="modalcall('approvalIdLv3')">검색</button>
				</td>
			</tr>
			<tr>
				<th>항목구분</th>
				<td>
					<select name="Nm" id="Nm">
						<option value="">== 선택하세요 ==</option>
						<option value="연차">연차</option>
						<option value="반차">반차</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>기 안 자</th>
				<td><input type="text" name="loginId" id="loginId" value="${loginId}" readonly="readonly"></td>
				<th>참<br>조</th>
				<td colspan="3">
					<input type="text" name="refId" id="refId" value="" readonly="readonly">
					<button type="button" class="btn btn-primary" onClick="modalcall('refId')">검색</button>
				</td>
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
	// 모달창 호출 	
	function modalcall(value){
		console.log(value);
		$('#selectedValue').val("");
		//window.document.preventDefault();
		$('#modalValue').val(value);
		$('#testModal').modal("show");
	}
	
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
		
		/*
		var documentContent = $("#tableTempN table").prop('outerHTML');  // TempN 제출할 테이블 내용을 가져옴
		$("#documentContent").val(documentContent);
	
		$("#requestForm").submit();
		*/
	}
	
	// 검색 결과
	$('#selectedValueBtn').click(function() {
		let empName = $('#selectedValue').val();
		console.log('empName param : ' + empName);
		$.ajax({
			url : '${pageContext.request.contextPath}/searchEmpListByNm',
			type : 'post',
			data : {empName : empName},	// json배열{키 : 값}
			success: function(data) {
				console.log('성공');
		        // 서버로부터 받은 데이터(data)를 사용하여 DOM을 조작
		        for (var i = 0; i < data.length; i++) {
		            var employee = data[i];
		            var newRow = '<tr>' +
		                         '<td><input type="radio" name="selectNm" value="' + employee.id + '"></td>' +
		                         '<td>' + employee.id + '</td>' +
		                         '<td>' + employee.empName + '</td>' +
		                         '<td>' + employee.deptNm + '</td>' +
		                         '<td>' + employee.teamNm + '</td>' +
		                         '<td>' + employee.positionNm + '</td>' +
		                         '</tr>';
		            $('#employeeTable').append(newRow); // 예시로 데이터를 테이블에 추가
		        }
		    },
		    error: function(error) {
		        console.log('Error:', error);
		    }
		});
	});
	
	$('#modalY').click(function() {
  	  let modalValue = $('#modalValue').val();
  	  
       // 모달 내의 입력란에서 값 가져오기
       var selectedValue = $('input[name="selectNm"]:checked').val();
       
       // 부모 창의 입력란에 값 설정
       $('#'+modalValue).val(selectedValue);
       
       // 모달 창 닫기
       $('#testModal').modal("hide");
    });
</script>
</body>
</html>