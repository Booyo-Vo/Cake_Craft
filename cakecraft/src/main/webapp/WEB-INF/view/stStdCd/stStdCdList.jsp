<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>//부서추가
function addDept() {
	//입력한 값을 받아옴
	var deptNm = document.getElementById("addDeptNm").value;

	// 입력값이 비어있거나 공백만 포함하는지 확인
	if (!deptNm || !deptNm.trim()) {
		alert("부서명을 입력해주세요.");
		return;
	}

	$.ajax({
		type: "GET",
		url: "/cakecraft/stStdCd/addDept",
		data: {deptNm: deptNm },
		success: function(response) {
	if (response === "DUPLICATE") {
			alert("이미 존재하는 부서명입니다.");
			}else if(response === "SUCCESS") {
				alert("부서가 추가되었습니다.");
				$('#addDeptStStdCdModal').modal('hide'); // 모달 닫기
				// 페이지 새로고침
				window.location.reload();
			}else{
				alert("부서 추가에 실패했습니다.");
			}
		},
		error: function() {
			alert("오류가 발생했습니다.");
			$('#addDeptStStdCdModal').modal('hide'); // 모달 닫기
			// 페이지 새로고침
			window.location.reload();
		}
	});
}
</script>
<script>//팀추가
function addTeam() {
	//입력한 값을 받아옴
	var teamNm = document.getElementById("addTeamNm").value;
	var teamDeptNm = document.getElementById("addTeamDeptNm").value;

	// 입력값이 비어있거나 공백만 포함하는지 확인
	if(!teamNm || !teamNm.trim()) {
		alert("팀명을 입력해주세요.");
		return;
	}

	$.ajax({
		type: "GET",
		url: "/cakecraft/stStdCd/addTeam",
		data: { teamNm: teamNm, teamDeptNm: teamDeptNm },
		success: function(response) {
			if(response === "DUPLICATE") {
			alert("이미 존재하는 팀명입니다.");
			}else if(response === "SUCCESS") {
				alert("팀이 추가되었습니다.");
				$('#addTeamModal').modal('hide');// 모달 닫기
				// 페이지 새로고침
				window.location.reload();
			}else{
				alert("팀 추가에 실패했습니다.");
			}
		},
		error: function() {
			alert("오류가 발생했습니다.");
			$('#addTeamModal').modal('hide');// 모달 닫기
			// 페이지 새로고침
			window.location.reload();
		}
	});
}
</script>
<script> //부서수정
function openModifyDeptCdModal(deptName) {
	// 해당 부서명을 모달에 표시
	document.getElementById("originDeptcdNm").value = deptName;
	// 모달을 열기
	$('#modifyDeptCdNmModal').modal('show');
}
function modifyDeptCdNm() {
	//입력한 값을 받아옴
	var originDeptCdNm = document.getElementById("originDeptcdNm").value;
	var updatedDeptCdNm = document.getElementById("updateDeptcdNm").value;

	// 입력값이 비어있거나 공백만 포함하는지 확인
	if (!updatedDeptCdNm || !updatedDeptCdNm.trim()) {
		alert("수정할 부서명을 입력해주세요.");
		return;
	}
	
	$.ajax({
		type: "GET", 
		url:"/cakecraft/stStdCd/modifyDeptCdNm", 
		data:{
			originDeptCdNm: originDeptCdNm,
			updatedDeptCdNm: updatedDeptCdNm
		},
		success: function(response) {
			if (response === "DUPLICATE") {
				alert("이미 존재하는 부서명입니다.");
			} else if (response === "SUCCESS") {
				alert("수정되었습니다.");
				$('#modifyDeptCdNmModal').modal('hide');// 모달 닫기
				// 페이지 새로고침
				window.location.reload();
			} else {
				alert("부서명 수정에 실패하였습니다.");
				$('#modifyDeptCdNmModal').modal('hide');// 모달 닫기
			}
		},
		error: function() {
			alert("오류가 발생했습니다.");
			$('#modifyDeptCdNmModal').modal('hide');// 모달 닫기
			// 페이지 새로고침
			window.location.reload();
		}
	});
}
</script>
<script> //팀수정
function openModifyTeamCdModal(teamName) {
	// 해당 부서명을 모달에 표시
	document.getElementById("originTeamcdNm").value = teamName;
	// 모달을 열기
	$('#modifyTeamCdNmModal').modal('show');
}
function modifyTeamCdNm() {
	//입력한 값을 받아옴
	var originTeamCdNm = document.getElementById("originTeamcdNm").value;
	var updatedTeamCdNm = document.getElementById("updateTeamcdNm").value;

	// 입력값이 비어있거나 공백만 포함하는지 확인
	if (!updatedTeamCdNm || !updatedTeamCdNm.trim()) {
		alert("수정할 팀명을 입력해주세요.");
		return;
	}

	$.ajax({
		type: "GET", 
		url: "/cakecraft/stStdCd/modifyTeamCdNm", 
		data: {
			originTeamCdNm: originTeamCdNm,
			updatedTeamCdNm: updatedTeamCdNm
		},
		success: function(response) {
			if (response === "DUPLICATE") {
				alert("이미 존재하는 부서명입니다.");
			} else if (response === "SUCCESS") {
				alert("수정되었습니다.");
				$('#modifyTeamCdNmModal').modal('hide');
				// 페이지 새로고침
				window.location.reload();
			} else {
				alert("부서명 수정에 실패하였습니다.");
			}
		},
		error: function() {
			alert("오류가 발생했습니다.");
			$('#modifyTeamCdNmModal').modal('hide');
			// 페이지 새로고침
			window.location.reload();
		}
	});
}
</script>
<script>
$(document).ready(function() {
	$('.dept-delete-button').click(function() { // 삭제 버튼을 누르면
		var row = $(this).closest('tr'); // 삭제 버튼이 속한 행(tr)을 가져옴
		var deptGrpCd = row.find('th:first').text(); // 부서 코드를 가져옴
		var deptCd = row.find('td:eq(0)').text(); // 부서 번호를 가져옴
		var deptName = row.find('td:eq(1)').text(); // 부서명을 가져옴

		var confirmDelete = confirm(deptName + "을 정말 삭제하시겠습니까?\n");

		if (confirmDelete) { // 확인을 눌렀을 때
			$.ajax({
				type: "GET", 
				url: "/cakecraft/stStdCd/removeStStdCd", 
				data: {
					grpCd: deptGrpCd, // 그룹 코드
					cd: deptCd // 부서 번호
				},
				success: function(response) {
					if (response === "FAIL") {
						alert("해당 부서에 근무하는 사원이 있습니다.");
					} else if (response === "SUCCESS") {
						alert("부서 삭제에 성공했습니다.");
						// 페이지 새로고침
						window.location.reload();
					} else {
						alert("부서 삭제에 실패하였습니다.");
					}
				},
				error: function() {
					alert("오류가 발생했습니다.");
				}
			});
		}
	});
});
</script>
<script>
$(document).ready(function() {
	$('.team-delete-button').click(function() { // 삭제 버튼을 누르면
		var row = $(this).closest('tr'); // 삭제 버튼이 속한 행(tr)을 가져옴
		var teamGrpCd = row.find('th:first').text(); // 부서 코드를 가져옴
		var teamCd = row.find('td:eq(0)').text(); // 부서 번호를 가져옴
		var teamName = row.find('td:eq(1)').text(); // 부서명을 가져옴

		var confirmDelete = confirm(teamName + "을 정말 삭제하시겠습니까?\n");

		if (confirmDelete) { // 확인을 눌렀을 때
			$.ajax({
				type: "GET", 
				url: "/cakecraft/stStdCd/removeStStdCd", 
				data: {
					grpCd: teamGrpCd, // 그룹 코드
					cd: teamCd // 부서 번호
				},
				success: function(response) {
					if (response === "FAIL") {
					alert("해당 팀에 근무하는 사원이 있습니다.");
					} else if (response === "SUCCESS") {
						alert("팀 삭제에 성공했습니다.");
						// 페이지 새로고침
						window.location.reload();
					} else {
						alert("팀 삭제에 실패하였습니다.");
					}
				},
				error: function() {
					alert("오류가 발생했습니다.");
				}
			});
		}
	});
});
</script>
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
							<h4>부서,팀 관리</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">부서 팀 관리</li>
							</ol>
							<!-- 부서/팀 추가 수정 모달창 -->
							<div class="d-flex justify-content-end mb-3">
							    <!-- 부서추가 모달창버튼 -->		
							    <button type="button" class="btn btn-primary btn-lg me-2" data-bs-toggle="modal" data-bs-target="#addDeptStStdCdModal">부서추가</button>
							    <!-- 팀추가 모달창버튼 -->	
							    <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#addTeamStStdCdModal">팀추가</button>
							</div>
						</nav>
					</div>
				</div>
			</div>
<!-- 제목끝 -->	
<!-- 팀, 부서 테이블 -->
			<div class="row clearfix">
				<c:forEach items="${deptList}" var="d">	
					<div class="col-md-6 col-sm-12 mb-30">
						<div class="pd-20 card-box height-100-p">
							<h4 class="mb-15 text-blue h4">${d.cdNm}</h4>
							<table class="table">
								<thead>
									<tr class="table-active">
										<th scope="col">부서코드</th>
										<th scope="col">부서번호</th>
										<th scope="col">부서명</th>
										<th scope="col"></th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody>
									<tr class="table-active">
										<th scope="row">${d.grpCd}</th>
										<td>${d.cd}</td>
										<td>${d.cdNm}</td>
										<td><button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modifyDeptCdNmModal" onclick="openModifyDeptCdModal('${d.cdNm}')">수정</button></td>
										<td><button type="button" class="btn btn-secondary btn-sm dept-delete-button">삭제</button></td>
									</tr>
								</tbody>
								</table>
								<table class="table">
									<thead>
										<tr>
											<th scope="col">팀코드</th>
											<th scope="col">팀번호</th>
											<th scope="col">팀명</th>
											<th scope="col"></th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${teamListMap[d.cd]}" var="t">
										<tr>
											<th scope="row">${t.grpCd}</th>
											<td>${t.cd}</td>
											<td>${t.cdNm}</td>
											<td><button type="button" class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#modifyTeamCdNmModal"  onclick="openModifyTeamCdModal('${t.cdNm}')">수정</button></td>
											<td><button type="button"  class="btn btn-light btn-sm team-delete-button">삭제</button></td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
<!-- 부서/팀 추가 수정 모달창 -->
<!-- 부서 추가 모달창 시작 -->
<div class="modal fade" id="addDeptStStdCdModal" tabindex="-1" aria-labelledby="addDeptStStdCdModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addDeptStStdCdModalLabel">부서추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="addDeptStStdCdForm">
					<div class="mb-3">
						<label for="addDeptNm" class="col-form-label">부서명</label>
						<input type="text" class="form-control" name="deptNm" id="addDeptNm" required>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="addDeptBtn" onclick="addDept()">추가</button>
			</div>
		</div>
	</div>
</div>
<!-- 부서 추가 모달창 끝 -->

<!-- 팀 추가 모달창 시작 -->
<div class="modal fade" id="addTeamStStdCdModal" tabindex="-1" aria-labelledby="addTeamStStdCdModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addTeamStStdCdModalLabel">팀추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="addTeamStStdCdForm">
					<div class="mb-3">
						<label for="addTeamDeptNm" class="col-form-label">부서</label>
							<select name=addTeamDeptNm id="addTeamDeptNm">
							 	<c:forEach items="${deptList}" var="d">
	  								 <option value="${d.cdNm}">${d.cdNm}</option>
								</c:forEach>
							</select>
						</div>
					<div class="mb-3">
						<label for="addTeamNm" class="col-form-label">팀명</label>
						<input type="text" class="form-control" name="TeamNm" id="addTeamNm" required>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="addTeamBtn" onclick="addTeam()">추가</button>
			</div>
		</div>
	</div>
</div>
<!-- 팀 추가 모달창 끝 -->

<!-- 부서 수정 모달창 시작 -->
<div class="modal fade" id="modifyDeptCdNmModal" tabindex="-1" aria-labelledby="modifyDeptCdNmModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modifyDeptCdNmModalLabel">팀추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="modifyDeptCdNmForm">
					<div class="mb-3">
						<label for="originCdNm" class="col-form-label">기존 부서명</label>
						<input type="text" class="form-control" name="originDeptcdNm" id="originDeptcdNm" value ="${d.cdNm}" readonly>
					</div>
					<div class="mb-3">
						<label for="updateCdNm" class="col-form-label">수정할 부서명</label>
						<input type="text" class="form-control" name="updateDeptcdNm" id="updateDeptcdNm" required>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="modifyDeptCdNmBtn" onclick="modifyDeptCdNm()">수정</button>
			</div>
		</div>
	</div>
</div>
<!-- 부서 수정 모달창 끝 -->

<!-- 팀 수정 모달창 시작 -->
<div class="modal fade" id="modifyTeamCdNmModal" tabindex="-1" aria-labelledby="modifyTeamCdNmModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modifyTeamCdNmModalLabel">팀추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="modifyTeamCdNmForm">
					<div class="mb-3">
						<label for="originCdNm" class="col-form-label">기존 팀명</label>
						<input type="text" class="form-control" name="originTeamcdNm" id="originTeamcdNm" value ="${t.cdNm}" readonly>
					</div>
					<div class="mb-3">
						<label for="updateCdNm" class="col-form-label">수정할 팀명</label>
						<input type="text" class="form-control" name="updateTeamcdNm" id="updateTeamcdNm" required>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="modifyTeamCdNmBtn" onclick="modifyTeamCdNm()">수정</button>
			</div>
		</div>
	</div>
</div>
<!-- 팀 수정 모달창 끝 -->
</body>
</html>