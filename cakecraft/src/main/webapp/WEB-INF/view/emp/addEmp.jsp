<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<!--  부서에 따른 팀목록 나열 -->
<script>
$(document).ready(function() {
	// 부서 선택이 변경되었을 때 실행
	$('select[name="deptNm"]').change(function() {
		var selectedDept = $(this).val();
		var teamSelect = $('select[name="teamNm"]');

		if (selectedDept !== '') {
			teamSelect.prop('disabled', false);
			
			// AJAX 요청을 통해 부서에 따른 팀 목록을 가져온다
			$.get('/cakecraft/stStdCd/getTeamListByDept?deptNm=' + selectedDept, function(teams) {
				teamSelect.empty();
				$.each(teams, function(index, team) {
					teamSelect.append($('<option>', {
						value: team.cdNm,
						text: team.cdNm
						}));
				});
			});
		} else {
			teamSelect.prop('disabled', true);
			teamSelect.empty();
		}
	});

	// 페이지 로드 시에 기본 선택된 부서에 해당하는 팀 목록을 표시
	var initialSelectedDept = $('select[name="deptNm"]').val();
	if (initialSelectedDept !== '') {
		var initialTeamSelect = $('select[name="teamNm"]');
		$.get('/cakecraft/stStdCd/getTeamListByDept?deptNm=' + initialSelectedDept, function(teams) {
			initialTeamSelect.empty();
			$.each(teams, function(index, team) {
				initialTeamSelect.append($('<option>', {
					value: team.cdNm,
					text: team.cdNm
				}));
			});
			initialTeamSelect.prop('disabled', false);
		});
	}
});
</script>
<!-- 공백이 입력되않도록 -->
<script>
	function addEmp() {
		//폼 데이터 수집
		var empFormData = new FormData(document.getElementById('empForm'));

		var empName = $('input[name="empName"]').val();
		var socialNo1 = $('input[name="socialNo1"]').val();
		var socialNo2 = $('input[name="socialNo2"]').val();
		var email = $('input[name="email"]').val();
		var empPhone1 = $('input[name="empPhone1"]').val();
		var empPhone2 = $('input[name="empPhone2"]').val();
		var empPhone3 = $('input[name="empPhone3"]').val();
		var hireDate = $('input[name="hireDate"]').val();
		var address = $('input[name="address"]').val();
		
		var socialNo = socialNo1 + "-" + socialNo2;
		var empPhone = empPhone1 + "-" + empPhone2 + "-" + empPhone3;
		
		// 공백 검사
		if (empName.trim() === '' || socialNo.trim() === '' || email.trim() === '' || empPhone.trim() === '' || hireDate.trim() === '' || address.trim() === '') {
			swal('오류','필수 입력 항목을 모두 입력해주세요.','warning');
			return;
		}
		
		// 글자수 체크
		if (socialNo1.length !== 6 || socialNo2.length !== 7) {
			swal('오류','주민번호를 다시 확인해주세요.','warning');
			return;
		}
		if (empPhone1.length !== 3 || empPhone2.length !== 4 || empPhone3.length !== 4) {
			swal('오류','핸드폰번호를 다시 확인해주세요.','warning');
			return;	
		}
		
		empFormData.append("socialNo", socialNo);
		empFormData.append("empPhone", empPhone); 
		
	// 사원추가시 생성된 사원번호를 알림창으로 띄우기 위해 -->
	//Ajax 요청 보내기
	$.ajax({
		type: 'POST',  // HTTP 요청 방법 (POST)
		url: '/cakecraft/emp/addEmp', 
		data: empFormData,  // 폼 데이터
		processData: false,
		contentType: false,
		success: function(response) {
			 // 성공 시 실행할 코드
			var empId = response.empId;
			var row = response.addEmprow;

			if (row > 0) { // 문자열을 정수로 변환하여 비교
				swal('추가 성공', empId + '  사원번호가 생성되었습니다', 'success').then(() => {
					window.location.reload();
				});
			} else {
				swal('추가 실패','사원 추가에 실패했습니다.','warning');
			}
		},
		error: function(error) {
			swal('추가 실패','사원 추가에 실패했습니다.','warning');
		}
	});
}
</script>
<!--  사원대량추가 excel 성공/실패 알림창을 위해 ajax -->
<script>
function addExcel() {
	// 선택한 파일 가져오기
	var file = $("input[name='file']")[0].files[0];

	// FormData 객체 생성하여 파일 전송하기
	var formData = new FormData();
	formData.append('file', file);

	$.ajax({
		type: "POST",  // 파일 데이터를 전송할 때는 POST 메서드 사용
		url: "/cakecraft/emp/addExcel",
		data: formData, // FormData 객체 전송
		processData: false, 
		contentType: false, 
		success: function(response) {
			if (response >= 0) {
				swal('추가 성공', response + "명의 사원이 성공적으로 추가되었습니다.",'success').then(() => {
					window.location.reload();
				});
			} else {
				swal('추가 실패','사원 추가에 실패했습니다 파일을 다시 확인해주세요.','warning').then(() => {
					window.location.reload();
				});
			}
		},
			error: function() {
				swal('추가 실패','파일을 다시 확인해주세요.','warning').then(() => {
					window.location.reload();
				});
		}
	});
}
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>사원추가</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">Add Emp</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		<div class="min-height-200px">
		<div class="pd-20 card-box mb-30">
			<form id="empForm" name="empForm">
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label"> 이름</label>
					<div class="col-sm-12 col-md-4">
						<input type="text" class="form-control" name="empName" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">주민번호</label>
					<div class="col-sm-12 col-md-3">
						<input type="text" class="form-control" name="socialNo1" required>
					</div>
					<div class="col-sm-12 col-md-3">
						<input type="text" class="form-control" name="socialNo2" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">부서</label>
					<div class="col-sm-12 col-md-2">
						<select name="deptNm" class="custom-select form-control">
							<c:forEach items="${deptList}" var="d">
								<option value="${d.cdNm}">${d.cdNm}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">팀</label>
					<div class="col-sm-12 col-md-2">
						<select name="teamNm" class="custom-select form-control" disabled>
							<c:forEach items="${teamList}" var="t">
								<option value="${teamList}">${teamList}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">직급</label>
					<div class="col-sm-12 col-md-2">
						<select name="positionNm" class="custom-select form-control">
							<c:forEach items="${positionList}" var="p">
								<option>${p.cdNm}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">이메일</label>
						<div class="col-sm-12 col-md-4">
							<input type="email"class="form-control" name="email" required>
						</div>
					</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">핸드폰번호</label>
					<div class="col-sm-12 col-md-2">
						<input type="text" class="form-control" name="empPhone1" required>
					</div>
					<div class="col-sm-12 col-md-2">
						<input type="text" class="form-control" name="empPhone2" required>
					</div>
					<div class="col-sm-12 col-md-2">
						<input type="text" class="form-control" name="empPhone3" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">입사일</label>
					<div class="col-sm-12 col-md-4">
						<input type="date"class="form-control" name="hireDate" required>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-12 col-md-2 col-form-label">주소</label>
					<div class="col-sm-12 col-md-6">
						<input type="text" class="form-control" id="address" name="address" required>
					</div>
					<div class="col-sm-12 col-md-2">
						<a onclick="findAddr()" class="btn btn-primary" style="color:white">주소검색</a>
					</div>
				</div>
				<button type="button" class="btn btn-primary"  onclick="addEmp()" >사원추가</button>
			</form>
 		</div>
 	</div>
<br>
<br>
	<div class="pd-20 card-box mb-30">
		<div class="clearfix"> 
			<div class="pull-left">
				<h4 class="text-blue h4">사원대량 업로드</h4>
				<p class="text-danger">반드시 정해진 엑셀 양식으로 작성후 업로드해야합니다</p>
			</div>
		</div>
			<a href="/cakecraft/excel/getExcelFrom"><i class="icon-copy fa fa-edit" aria-hidden="true"></i>사원추가 엑셀양식</a>
		<br>
		<br> 
			<div class="col-sm-12 col-md-6">
			<input type="file" name="file" accept=".xlsx" required class="form-control-file form-control height-auto">
		</div>
		<br>
		<button type="submit" onclick="addExcel()" class="btn btn-primary">추가</button>
	</div>
</div>
</div>
</div>
<!-- 푸터 시작 -->
<c:import url="/layout/footer.jsp"></c:import>
<!-- 푸터 끝 -->
<!-- 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
function findAddr(){
		new daum.Postcode({
			oncomplete: function(data) {
				
				console.log(data);
				 
				 var roadAddr = data.roadAddress; // 도로명 주소 변수
				var zonecode = data.zonecode; // 우편번호
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('address').value = roadAddr;
			}
		}).open();
}
</script>
</body>
</html>