<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
	// 문서구분 선택이 변경되었을 때 실행
	$('select[name="documentNm"]').change(function() {
		var selectedDoc = $(this).val();
		var docSubSelect = $('select[name="documentSubNm"]');

		if (selectedDoc !== '') {
			docSubSelect.prop('disabled', false);
			
			// AJAX 요청을 통해, 문서구분에 따른 하위 항목 리스트를 가져온다
			$.get('/cakecraft/stStdCd/getDocSubListByDoc?docNm=' + selectedDoc, function(docSubs) {
				docSubSelect.empty();
				$.each(docSubs, function(index, docSub) {
					docSubSelect.append($('<option>', {
						value: docSub.cdNm,
						text: docSub.cdNm
						}));
				});
			});
		} else {
			docSubSelect.prop('disabled', true);
			docSubSelect.empty();
		}
	});
	
	// 페이지 로드 시에 기본 선택된 부서에 해당하는 팀 목록을 표시
	var initialSelectedDoc = $('select[name="documentNm"]').val();
	if (initialSelectedDoc !== '') {
		var initialDocSubSelect = $('select[name="documentSubNm"]');
		$.get('/cakecraft/stStdCd/getDocSubListByDoc?docNm=' + initialSelectedDoc, function(docSubs) {
			initialDocSubSelect.empty();
			$.each(docSubs, function(index, docSub) {
				initialDocSubSelect.append($('<option>', {
					value: docSub.cdNm,
					text: docSub.cdNm
				}));
			});
			initialDocSubSelect.prop('disabled', false);
		});
	}
});
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
<!-- 모달창 -->
<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="exampleModalLabel">사원이름검색</h3>
			</div>
			<div class="modal-body">
				<!-- 모달 내용에 선택 값을 입력하는 입력란 -->
				<div style="display: inline-block">
					<input type="text" id="selectedValue" class="form-control" placeholder="선택한 값을 입력하세요">
				</div>
				<div style="display: inline-block">
					<button type="button" class="btn btn-primary" id="selectedValueBtn">검색</button>
				</div>
				<table id="employeeTable" border="1">
				</table>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="modalValue">
					<a class="btn" id="modalY">선택</a>
					<button class="btn" type="button" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
	<h1>기안서</h1>
	<form action="/cakecraft/approval/addApprDoc" method="post" name="requestForm" id="requestForm">
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
				<th>문서구분</th>
				<td>
					<select name="documentNm" id="documentNm">
						<c:forEach items="${docCodeList}" var="dc">
							<option value="${dc.cdNm}">${dc.cdNm}</option>
						</c:forEach>
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
					<select name="documentSubNm" id="documentSubNm">
						<c:forEach items="${docSubCodeList}" var="dsc">
							<option value="${dsc.cdNm}">${dsc.cdNm}</option>
						</c:forEach>
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
					<input type="datetime-local" name="startDay" id="startDay">
					~
					<input type="datetime-local" name="endDay" id="endDay">
				</td>
			</tr>
			<tr>
				<th>제 &nbsp; &nbsp; 목</th>
				<td colspan="5"><input type="text" name="documentTitle" id="documentTitle" value=""></td>
			</tr>
			<tr>
				<th>내 &nbsp; &nbsp; 용</th>
				<td colspan="5"><input type="text" name="documentContent" id="documentContent" size="100" value=""></td>
			</tr>
			<tr>
				<th>파 &nbsp; &nbsp; 일</th>
				<td colspan="5"></td>
			</tr>
		</table>
	<!-- 기본값을 N으로 설정 -->
	<input type="hidden" name="tempSave" id="tempSave" value="N">
	<button type="button" class="btn btn-primary" onclick="tempSaveAndSubmit()">임시저장</button>
	<button type="button" class="btn btn-primary" id="submitBtn" onclick="submitForm()">제출하기</button>
</form>
</div>
<script>
	// 임시저장 버튼을 눌렀을 때 호출되는 함수
	function tempSaveAndSubmit() {
		$("#tempSave").val('Y'); // tempSave 값을 Y로 설정	
		$("#requestForm").submit();		
	}
	
	// 제출하기 버튼을 눌렀을 때 호출되는 함수
	function submitForm() {
		$("#requestForm").submit();
	}

	// 모달창 호출 	
	function modalcall(value){
		console.log(value);
		
		 // 테이블 초기화 (모든 검색 결과 삭제)
		$('#employeeTable').empty();
		// 선택한 값을 입력하는 입력란 초기화
		$('#selectedValue').val("");
		//window.document.preventDefault();
		$('#modalValue').val(value);
		$('#testModal').modal("show");
	}

	// 검색 결과
	$('#selectedValueBtn').click(function() {
		// 테이블 초기화 (모든 검색 결과 삭제)
		$('#employeeTable').empty();
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