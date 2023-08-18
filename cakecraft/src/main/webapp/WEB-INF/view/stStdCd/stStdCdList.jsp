<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>stStdCdList</title>
</head>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>//부서추가
function addDept() {
    var deptNm = document.getElementById("addDeptNm").value;
    
    $.ajax({
        type: "GET",
        url: "/cakecraft/stStdCd/addDept",
        data: {deptNm: deptNm },
        success: function(response) {
            if (response === "DUPLICATE") {
                alert("이미 존재하는 부서명입니다.");
            } else if (response === "SUCCESS") {
                alert("부서가 추가되었습니다.");
            } else {
                alert("부서 추가에 실패했습니다.");
            }
        },
        error: function() {
            alert("오류가 발생했습니다.");
        }
    });
}
</script>
<script>//팀추가
function addTeam() {
    var teamNm = document.getElementById("addTeamNm").value;
    var teamDeptNm = document.getElementById("addTeamDeptNm").value;
    
    $.ajax({
        type: "GET",
        url: "/cakecraft/stStdCd/addTeam",
        data: { teamNm: teamNm, teamDeptNm: teamDeptNm },
        success: function(response) {
            if (response === "DUPLICATE") {
                alert("이미 존재하는 팀명입니다.");
            } else if (response === "SUCCESS") {
                alert("팀이 추가되었습니다.");
            } else {
                alert("팀 추가에 실패했습니다.");
            }
        },
        error: function() {
            alert("오류가 발생했습니다.");
        }
    });
}
</script>

<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<button type="button" data-bs-toggle="modal" data-bs-target="#addDeptStStdCdModal">부서추가</button>

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

<button type="button" data-bs-toggle="modal" data-bs-target="#addTeamStStdCdModal">팀추가</button>
<!-- 부서 추가 모달창 시작 -->
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
<!-- 부서 추가 모달창 끝 -->
<table>
	<tr>
	    <c:forEach items="${deptList}" var="d">
	        <td> <!-- 부서 -->
	        	${d.cdNm}
	        </td> 
	    </c:forEach>
	</tr>
	<tr>
	    <c:forEach items="${deptList}" var="d">
	        <td> <!-- 팀 -->
	            <c:forEach items="${teamListMap[d.cd]}" var="t">
	                ${t.cdNm}<br><br>
	            </c:forEach>
	        </td>
	    </c:forEach>
	</tr>
</table>

</body>
</html>