<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>

<form action="${pageContext.request.contextPath}/facility/facilityList" method="get">
	<div>
		<select name="categoryCd">
			<option value="A">전체</option>
			<option value="11">회의실</option>
			<option value="21">노트북</option>
			<option value="22">빔프로젝터</option>
			<option value="23">마이크</option>
		</select>
		<select name="useYn">
			<option value="A">전체</option>
			<option value="Y">사용가능</option>
			<option value="N">사용불가</option>
		</select>
		<button type="submit">검색</button>
	</div>
</form>

<div>
	<button type="button" data-bs-toggle="modal" data-bs-target="#addFcltModal">추가하기</button>
</div>

<!-- 시설비품 추가 모달창 시작 -->
<div class="modal fade" id="addFcltModal" tabindex="-1" aria-labelledby="addFcltModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addFcltModalLabel">시설비품추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="addFcltForm">
					<input type="hidden" name="loginId" value="${loginId}">
					<div class="mb-3">
						<label for="categoryCd" class="col-form-label">카테고리</label>
						<select name="categoryCd" id="categoryCd">
							<option value="11">회의실</option>
							<option value="21">노트북</option>
							<option value="22">빔프로젝터</option>
							<option value="23">마이크</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="facilityName" class="col-form-label">이름</label>
						<input type="text" class="form-control" name="facilityName" id="facilityName" onblur="nameCheck()" required>
						<span class="msg"></span>
					</div>
					<div class="mb-3">
						<label for="facilityNote" class="col-form-label">설명</label>
						<textarea class="form-control" name="facilityNote" id="facilityNote" required></textarea>
					</div>
					<div class="mb-3">
						<label for="useYn" class="col-form-label">사용여부</label>
						<select name="useYn" id="useYn">
							<option value="Y" selected>사용가능</option>
							<option value="N">사용불가</option>
						</select>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="addFcltBtn" onclick="addFacility()">추가</button>
			</div>
		</div>
	</div>
</div>
<!-- 시설비품 추가 모달창 끝 -->

<!-- 시설비품리스트 시작 -->
<table>
	<thead>
		<tr>
			<td>facilityNo</td>
			<td>categoryCd</td>
			<td>facilityName</td>
			<td>facilityNote</td>
			<td>useYn</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="f" items="${resultList}">
			<tr>
				<td>${f.facilityNo}</td>
				<td>${f.categoryCd}</td>
				<td><button type="button" onclick="facilityNo(${f.facilityNo})">${f.facilityName}</button></td>
				<td>${f.facilityNote}</td>
				<td>${f.useYn}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 시설비품리스트 끝 -->

<!-- 시설비품 수정 모달창 시작 -->
<div class="modal fade" id="modFcltModal" tabindex="-1" aria-labelledby="modFcltModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modFcltModalLabel">시설비품수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="modFcltForm">
					<input type="hidden" name="facilityNo" id="modFacilityNo">
					<input type="hidden" name="loginId" value="${loginId}">
					<div class="mb-3">
						<label for="categoryCd" class="col-form-label">카테고리</label>
						<select name="categoryCd" id="modCategoryCd">
							<option value="11">회의실</option>
							<option value="21">노트북</option>
							<option value="22">빔프로젝터</option>
							<option value="23">마이크</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="facilityName" class="col-form-label">이름</label>
						<input type="text" class="form-control" name="facilityName" id="modFacilityName" onblur="nameCheck()" required>
						<span class="msg"></span>
					</div>
					<div class="mb-3">
						<label for="facilityNote" class="col-form-label">설명</label>
						<textarea class="form-control" name="facilityNote" id="modFacilityNote" required></textarea>
					</div>
					<div class="mb-3">
						<label for="useYn" class="col-form-label">사용여부</label>
						<select name="useYn" id="modUseYn">
							<option value="Y">사용가능</option>
							<option value="N">사용불가</option>
						</select>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="modFcltBtn" onclick="modFacility()">수정</button>
			</div>
		</div>
	</div>
</div>
<!-- 시설비품 수정 모달창 끝 -->

<script>
var addFcltModal = document.getElementById('#addFcltModal')
addFcltModal.addEventListener('show.bs.modal', function (event) {
  // Button that triggered the modal
  var button = event.relatedTarget
  // Extract info from data-bs-* attributes
  var recipient = button.getAttribute('data-bs-whatever')
  // If necessary, you could initiate an AJAX request here
  // and then do the updating in a callback.
  //
  // Update the modal's content.
  var modalTitle = addFcltModal.querySelector('.modal-title')
  var modalBodyInput = addFcltModal.querySelector('.modal-body input')

  modalTitle.textContent = 'New message to ' + recipient
  modalBodyInput.value = recipient
})

var modFcltModal = document.getElementById('#modFcltModal')
modFcltModal.addEventListener('show.bs.modal', function (event) {
  // Button that triggered the modal
  var button = event.relatedTarget
  // Extract info from data-bs-* attributes
  var recipient = button.getAttribute('data-bs-whatever')
  // If necessary, you could initiate an AJAX request here
  // and then do the updating in a callback.
  //
  // Update the modal's content.
  var modalTitle = modFcltModal.querySelector('.modal-title')
  var modalBodyInput = modFcltModal.querySelector('.modal-body input')

  modalTitle.textContent = 'New message to ' + recipient
  modalBodyInput.value = recipient
})

//입력값 유효성 검사(이름 공백금지/중복검사, 모든 입력폼 필수입력)

//추가 버튼 클릭 시 폼 제출
function addFacility(){
	console.log('추가버튼 클릭');
	const addFcltForm = $('#addFcltForm');
	addFcltForm.attr('action', '${pageContext.request.contextPath}/facility/addFacility');
	addFcltForm.attr('method', 'post');
	addFcltForm.submit();
}

//시설비품 클릭 시 상세보기 및 수정 모달 띄우기
function facilityNo(facilityNo){
	console.log(facilityNo);
	
	$.ajax({
		url : '${pageContext.request.contextPath}/rest/modifyFacility',
		type : 'post',
		data : {facilityNo : facilityNo},
		success : function(facility){
			console.log('ajax성공');
			console.log(facility);
			$('#modFacilityNo').val(facility.facilityNo);
			$('#modCategoryCd').val(facility.categoryCd);
			$('#modFacilityName').val(facility.facilityName);
			$('#modFacilityNote').val(facility.facilityNote);
			$('#modUseYn').val(facility.useYn);
		},
		error : function(){
			console.log('ajax실패');
		}
	})
	$('#modFcltModal').modal('show');
}

//수정버튼 클릭 시 폼 제출
function modFacility(){
	console.log('수정버튼 클릭');
	const modFcltForm = $('#modFcltForm');
	modFcltForm.attr('action', '${pageContext.request.contextPath}/facility/modifyFacility');
	modFcltForm.attr('method', 'post');
	modFcltForm.submit();
}

</script>
</body>
</html>