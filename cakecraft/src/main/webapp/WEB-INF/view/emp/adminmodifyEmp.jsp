<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
//부서가 선택되면 해당부서에 맞는 팀만 나열되도록
$(document).ready(function() {
	// 부서선택이 변경 되었을때 실행
	$('select[name="deptNm"]').change(function() {
		//선택된 부서의 값을 가져옴
		var selectedDept = $(this).val();
		//팀 선택상자를 선택
		var teamSelect = $('select[name="teamNm"]');

		// AJAX 요청을 통해 부서에 따른 팀 목록을 가져온다
		$.get('/cakecraft/stStdCd/getTeamListByDept?deptNm=' + selectedDept, function(teams) {
			// 팀 선택란 초기화 후 옵션 추가
			teamSelect.empty();
			//팀 배열에 대해 반복
			$.each(teams, function(index, team) {
				teamSelect.append($('<option>', {
					value: team.cdNm,
					text: team.cdNm,
					selected: team.cdNm === teamSelect.val()
				}));
			});

			// 선택된 팀 값을 설정
			var selectedTeam = teamSelect.attr('data-selected-team'); // 미리 설정된 값
			if (selectedTeam) {
				teamSelect.val(selectedTeam);
			}
		});
	});
	// 페이지 로딩이 완료되었을 때 실행
	$('select[name="deptNm"]').trigger('change');
});
</script>
<script>
$(document).ready(function() {
	$('select[name="empStatus"]').change(function() {
		// 재직상태 변경시 선택된 재직상태를 받아옴
		var selectedStatus = $(this).val();
		// 퇴사일 입력칸을 선택함
		var retireDateInput = $('input[name="retireDate"]');

		if (selectedStatus === '퇴사자') {
			//퇴사자일경우 퇴사일 입력칸을 활성화
			retireDateInput.prop('disabled', false);
		} else {
			//퇴사자가 아닐경우 퇴사일 입력칸을 비활성화
			retireDateInput.prop('disabled', true);
			retireDateInput.val(''); // 퇴사일 입력칸 초기화
		}
		});

	//  처음 로딩 시 선택된 재직상태를 받아옴
	var initialStatus = $('select[name="empStatus"]').val();
	// 퇴사일 입력칸을 선택함
	var initialRetireDateInput = $('input[name="retireDate"]');
	if (initialStatus === '퇴사자') {
		//퇴사자일경우 퇴사일 입력칸을 활성화
		initialRetireDateInput.prop('disabled', false);
		} else {
		//퇴사자가 아닐경우 퇴사일 입력칸을 비활성화
		initialRetireDateInput.prop('disabled', true);
		retireDateInput.val(''); // 퇴사일 입력칸 초기화
	}
});
</script>
<!-- 공백이 입력되않도록 -->
<script>
$(document).ready(function() {
	$('form').submit(function(event) {
		// 입력 필드 값 가져오기
		var empName = $('input[name="empName"]').val();
		var address = $('input[name="address"]').val();
		var empPhone = $('input[name="empPhone"]').val();

		// 공백 체크
		if (empName.trim() === '' || address.trim() === '' || empPhone.trim() === '') {
		alert('필수 입력 항목을 모두 입력해주세요.');
		event.preventDefault(); // 폼 제출 중지
		}
	});
});
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<!-- 제목 -->
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>사원정보수정</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="/cakecraft/emp/adminEmpList">Admin Emp list</a></li>
								<li class="breadcrumb-item"><a href="/cakecraft/emp/adminEmpById">Admin Emp</a></li>
								<li class="breadcrumb-item active" aria-current="page">Admin Modify Emp</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
<!-- 제목끝 -->
			<div class="pd-20 card-box mb-30">
				<div class="clearfix">
					<div class="pull-left">
						<h4 class="text-blue h4">${empbase.empName} 사원정보수정</h4>
					</div>
				</div> 
				<form action="/cakecraft/emp/adminmodifyEmp" method="post">
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">사번</label>
						<div class="col-sm-12 col-md-4">
							${empbase.id}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">이름</label>
						<div class="col-sm-12 col-md-4">
							<input type="text" class="form-control"name="empName" value="${empbase.empName}" required>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">주민등록번호</label>
						<div class="col-sm-12 col-md-4">
							${empbase.socialNo}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">부서</label>
						<div class="col-sm-12 col-md-4">
							<select name="deptNm" required>
								<c:forEach items="${deptList}" var="d">
									<option value="${d.cdNm}" ${d.cdNm == empbase.deptNm ? 'selected' : ''}>${d.cdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">팀</label>
						<div class="col-sm-12 col-md-4">
							<select name="teamNm" required data-selected-team="${empbase.teamNm}">
								<c:forEach items="${teamList}" var="t">
									<!-- 기본값이 선택되어있고 (부서선택에 따른)변경된 값이 보내지도록 설정 -->
									<option value="${t.cdNm}" ${t.cdNm == empbase.teamNm ? 'selected' : ''}>${t.cdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">직급</label>
						<div class="col-sm-12 col-md-4">
							<select name="positionNm" required>
								<c:forEach items="${positionList}" var="p">
									<option value="${p.cdNm}" ${p.cdNm == empbase.positionNm ? 'selected' : ''}>${p.cdNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">이메일</label>
						<div class="col-sm-12 col-md-4">
							<input type="email" class="form-control"name="email" value="${empbase.email}" required>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">입사일</label>
						<div class="col-sm-12 col-md-4">
							${empbase.hireDate}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">퇴사일</label>
						<div class="col-sm-12 col-md-4">
							<input type="date" class="form-control"name="retireDate" value="${empbase.retireDate}" required>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">재직상태</label>
						<div class="col-sm-12 col-md-4">
							<select name="empStatus" required>
								<option value="재직자" ${empbase.empStatus == '재직자' ? 'selected' : ''}>재직자</option>
								<option value="퇴사자" ${empbase.empStatus == '퇴사자' ? 'selected' : ''}>퇴사자</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">연차잔여개수</label>
						<div class="col-sm-12 col-md-4">
							${empbase.dayoffCnt}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">주소</label>
						<div class="col-sm-12 col-md-4">
							<input type="text" class="form-control" id="address" name="address" value="${empbase.address}" required>
						</div>
						<div class="col-sm-12 col-md-4">
							<a onclick="findAddr()" class="btn btn-primary" style="color:white">주소검색</a>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-2 col-form-label">핸드폰번호</label>
						<div class="col-sm-12 col-md-4">
							<input type="tel" class="form-control"name="empPhone" value="${empbase.empPhone}" required>
						</div>
					</div>
				<!-- redirect 할때 id 값이 필요해서 hidden으로 전달함-->
				<input type ="hidden" name="id" value="${empbase.id}">
				<button type="submit" class="btn btn-primary">수정</button>
				</form>
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