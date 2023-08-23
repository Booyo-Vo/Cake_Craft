<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
</head>

<body>
<c:import url="/layout/header.jsp"></c:import>
<div class="main-container">
<!-- 검색 시작 -->
<form action="${pageContext.request.contextPath}/facility/facilityList" method="get">
	<div>
		<select id="category" required>
			<option value="" selected disabled>==선택==</option>
			<option value="A">전체</option>
			<option value="F">시설</option>
			<option value="S">비품</option>
		</select>
		<select id="categoryCd" name="categoryCd" required>
			<option value="" selected disabled>==선택==</option>
			<option value="A">전체</option>
			<c:forEach var="t" items="${categoryCdList}">
				<option value="${t.cd}">${t.cdNm}</option>
			</c:forEach>
		</select>
		<select id="useYn" name="useYn" required>
			<option value="" selected disabled>==선택==</option>
			<option value="A">전체</option>
			<option value="Y">사용가능</option>
			<option value="N">사용불가</option>
		</select>
		<button type="submit">검색</button>
	</div>
</form>
<!-- 검색 끝 -->

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
						<label for="addCategory" class="col-form-label">카테고리</label>
						<select id="addCategory" required>
							<option value="" selected disabled>==선택==</option>
							<option value="F">시설</option>
							<option value="S">비품</option>
						</select>
						<select id="addCategoryCd" name="categoryCd" required>
							<option value="" selected disabled>==선택==</option>
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
						<select name="useYn" id="addUseYn" required>
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
					<input type="hidden" name="categoryCd" id="modCategory" value="">
					<div class="mb-3">
						<label for="modCategoryCd" class="col-form-label">카테고리</label>
						<input type="text" class="form-control" id="modCategoryCd" readonly>
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
searchSelected();

//시설/비품 카테고리별 상세 리스트 출력
$('#category').change(function(){
	let category = $('#category').val();
	let cd = '';
	if(category == 'F'){
		cd = '1%';
	} else if (category == 'S'){
		cd = '2%';
	} else {
		$('#categoryCd *').remove();
		$('#categoryCd').append('<option value="" selected disabled>==선택==</option>');
		$('#categoryCd').append('<option value="A" selected>전체</option>');
	}
	if(category != 'A'){
		$('#categoryCd *').remove();
		$('#categoryCd').append('<option value="" selected disabled>==선택==</option>');
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/listBySearch',
			type : 'post',
			data : {cd : cd },
			success : function(list){
				console.log('ajax성공');
				console.log(list);
				list.forEach(function(item, index){
					$('#categoryCd').append('<option value="' +item.cd+ '">' + item.cdNm + '</option>');
				})
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	}
})

//현재 검색조건 selected처리
function searchSelected(){
	let categoryCd = '<c:out value="${categoryCd}" />';
	let useYn = '<c:out value="${useYn}" />';
	console.log(categoryCd);
	console.log(useYn);
	
	if(categoryCd == 'A'){
		$('#category').val('A').prop('selected', true);
		$('#categoryCd').val('A').prop('selected', true);
	} else if(categoryCd.startWith('1')){
		$('#category').val('F').prop('selected', true);
		$('#categoryCd').val(categoryCd).prop('selected', true);
	} else if(categoryCd.startWith('2')){
		$('#category').val('S').prop('selected', true);
		$('#categoryCd').val(categoryCd).prop('selected', true);
	}
	
	$('#useYn').val(useYn).prop('selected', true);
}


//추가폼 유효성 검사(이름 공백금지/중복검사, 모든 입력폼 필수입력)
// 이름 유효성검사
$('#addFacilityName').val('');
$('#addFacilityNote').val('');

//시설/비품 카테고리별 상세 리스트 출력
$('#addCategory').change(function(){
	let addCategory = $('#addCategory').val();
	let cd = '';
	if(addCategory == 'F'){
		cd = '1%';
	} else if (addCategory == 'S'){
		cd = '2%';
	}
	$('#addCategoryCd *').remove();
	$('#addCategoryCd').append('<option value="" selected disabled>==선택==</option>');
	$.ajax({
		url : '${pageContext.request.contextPath}/rest/listBySearch',
		type : 'post',
		data : {cd : cd },
		success : function(list){
			console.log('ajax성공');
			console.log(list);
			list.forEach(function(item, index){
				$('#addCategoryCd').append('<option value="' +item.cd+ '">' + item.cdNm + '</option>');
			})
		},
		error : function(){
			console.log('ajax실패');
		}
	})
})
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
			$('#modCategory').val(facility.categoryCd);
			$('#modCategoryCd').val(facility.cdNm);
			$('#modFacilityName').val(facility.facilityName);
			$('#modFacilityNote').val(facility.facilityNote);
			$('#modCount').text(facility.facilityNote.length);
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