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
<c:import url="/layout/cdn.jsp"></c:import>
</head>
<body>
<c:import url="/layout/header.jsp"></c:import>
<div class="main-container">
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
						<label for="addCategoryCd" class="col-form-label">카테고리</label>
						<select name="categoryCd" id="addCategoryCd">
							<option value="11">회의실</option>
							<option value="21">노트북</option>
							<option value="22">빔프로젝터</option>
							<option value="23">마이크</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="addFacilityName" class="col-form-label">이름</label>
						<input type="text" class="form-control" name="facilityName" id="addFacilityName" required>
						<span id="addNameMsg"></span>
					</div>
					<div class="mb-3">
						<label for="addFacilityNote" class="col-form-label">설명</label>
						<textarea class="form-control" name="facilityNote" id="addFacilityNote" required></textarea>
						<span id="addCount">0</span>자 / 100자
						<span id="addNoteMsg"></span>
					</div>
					<div class="mb-3">
						<label for="addUseYn" class="col-form-label">사용여부</label>
						<select name="useYn" id="addUseYn">
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
						<label for="modCategoryCd" class="col-form-label">카테고리</label>
						<select name="categoryCd" id="modCategoryCd">
							<option value="11">회의실</option>
							<option value="21">노트북</option>
							<option value="22">빔프로젝터</option>
							<option value="23">마이크</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="modFacilityName" class="col-form-label">이름</label>
						<input type="text" class="form-control" name="facilityName" id="modFacilityName" required>
						<span id="modNameMsg"></span>
					</div>
					<div class="mb-3">
						<label for="modFacilityNote" class="col-form-label">설명</label>
						<textarea class="form-control" name="facilityNote" id="modFacilityNote" required></textarea>
						<span id="modCount">0</span>자 / 100자
						<span id="modNoteMsg"></span>
					</div>
					<div class="mb-3">
						<label for="modUseYn" class="col-form-label">사용여부</label>
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
</div>
<script>
/* var addFcltModal = document.getElementById('#addFcltModal')
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
}) */

/* var modFcltModal = document.getElementById('#modFcltModal')
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
}) */

//추가폼 유효성 검사(이름 공백금지/중복검사, 모든 입력폼 필수입력)
// 이름 유효성검사
$('#addFacilityName').val('');
$('#addFacilityNote').val('');

$('#addFacilityName').blur(function() {
	if ($('#addFacilityName').val() == ''){
		$('#addNameMsg').text('이름을 작성해주세요');
		$('#addFacilityName').focus();
	} else {
		console.log($('#addFacilityName').val()); 
		$('#addFacilityName').val($('#addFacilityName').val().replace(/ /g,'')); //모든 공백제거
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/nameCheck',
			type : 'post',
			data : {
				facilityName : $('#addFacilityName').val()
			},
			success : function(param){
				if(param > 0){
					$('#addNameMsg').text('이미 사용 중인 이름입니다');
					$('#addFacilityName').focus();
				}
			}
		})
		$('#addNameMsg').text('');
		$('#addFacilityNote').focus();
	}
});

//설명 유효성검사
$('#addFacilityNote').keyup(function(){
	const MAX_COUNT = 100;
	let len = $('#addFacilityNote').val().length;
	if(len > MAX_COUNT) {
		let str = $('#addFacilityNote').val().substring(0, MAX_COUNT);
		$('#addFacilityNote').val(str);
		$('#addNoteMsg').text(MAX_COUNT +'자 이하로 입력해주세요');
	} else {
		$('#addCount').text(len);
	}
})



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

//수정폼 유효성 검사(이름 공백금지/중복검사, 모든 입력폼 필수입력)
//이름 유효성검사
$('#modFacilityName').blur(function() {
	if ($('#modFacilityName').val() == ''){
		$('#modNameMsg').text('이름을 작성해주세요');
		$('#modFacilityName').focus();
	} else {
		console.log($('#modFacilityName').val()); 
		$('#modFacilityName').val($('#modFacilityName').val().replace(/ /g,'')); //모든 공백제거
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/nameCheck',
			type : 'post',
			data : {
				facilityName : $('#modFacilityName').val(),
				facilityNo: $('#modFacilityNo').val()
			},
			success : function(param){
				if(param > 0){
					$('#modNameMsg').text('이미 사용 중인 이름입니다');
					$('#modFacilityName').focus();
				}
			}
		})
		$('#modNameMsg').text('');
		$('#modFacilityNote').focus();
 }
});
  
//설명 유효성검사
$('#modFacilityNote').keyup(function(){
	const MAX_COUNT = 100;
	let len = $('#modFacilityNote').val().length;
	if(len > MAX_COUNT) {
		let str = $('#modFacilityNote').val().substring(0, MAX_COUNT);
		$('#modFacilityNote').val(str);
		$('#modNoteMsg').text(MAX_COUNT +'자 이하로 입력해주세요');
	} else {
		$('#modCount').text(len);
	}
})

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