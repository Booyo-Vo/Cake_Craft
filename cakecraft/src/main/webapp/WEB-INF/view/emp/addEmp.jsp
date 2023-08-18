<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addEmp</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
    // 부서선택이 변경 되었을때 실행
    $('select[name="deptNm"]').change(function() {
    	//부서선택시 선택된 부서값을 받아옴
        var selectedDept = $(this).val();
    	//팀 선택간을 선택함
        var teamSelect = $('select[name="teamNm"]');
        if (selectedDept !== '') {
            // 부서가 선택되었을 때 팀 선택 드롭다운 활성화
            teamSelect.prop('disabled', false);
            
            // AJAX 요청을 통해 부서에 따른 팀 목록을 가져온다
            $.get('/stStdCd/getTeamListByDept?deptNm=' + selectedDept, function(teams) {
                teamSelect.empty();
                $.each(teams, function(index, team) {
                    teamSelect.append($('<option>', {
                        value: team.cdNm,
                        text: team.cdNm
                    }));
                });
            });
        } else {
            // 부서가 선택되지 않았을 때 팀 선택 드롭다운 비활성화 및 초기화
            teamSelect.prop('disabled', true);
            teamSelect.empty();
        }
    });
});
</script>
<!-- 공백이 입력되않도록 -->
<script>
$(document).ready(function() {
    $('form').submit(function(event) {
        var empName = $('input[name="empName"]').val();
        var socialNo = $('input[name="socialNo"]').val();
        var email = $('input[name="email"]').val();
        var empPhone = $('input[name="empPhone"]').val();
        var hireDate = $('input[name="hireDate"]').val();
        var address = $('input[name="address"]').val();
        
        // 공백 제거 후 검사
        if (empName.trim() === '' || socialNo.trim() === '' || email.trim() === '' || empPhone.trim() === '' || hireDate.trim() === '' || address.trim() === '') {
            alert('필수 입력 항목을 모두 입력해주세요.');
            event.preventDefault(); // 폼 제출 중지
        }
    });
});
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
    <form action="/cakecraft/emp/addEmp" method="post">
        <table>
            <tr>
                <td>이름</td>
                <td><input type="text" name="empName" required></td>
            </tr>
            <tr>
                <td>주민번호</td>
                <td><input type="text" name="socialNo" required></td>
            </tr>
		<tr>
		    <td>부서</td>
		    <td>
		        <select name="deptNm">
		            <c:forEach items="${deptList}" var="d">
		                <option value="${d.cdNm}" ${d.cdNm == empbase.deptNm ? 'selected' : ''}>${d.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
		<tr>
		    <td>팀</td>
		    <td>
		        <select name="teamNm" disabled>
		            <c:forEach items="${teamList}" var="t">
		            	<!-- 기본값이 선택되어있고 (부서선택에 따른)변경된 값이 보내지도록 설정 -->
		                <option value="${t.cdNm}" ${t.cdNm == empbase.teamNm ? 'selected' : ''}>${t.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
		<tr>
		    <td>직급</td>
		    <td>
		        <select name="positionNm">
		            <c:forEach items="${positionList}" var="p">
		                <option value="${p.cdNm}" ${p.cdNm == empbase.positionNm ? 'selected' : ''}>${p.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
            <tr>
                <td>이메일</td>
                <td><input type="email" name="email" required></td>
            </tr>
            <tr>
                <td>핸드폰번호</td>
                <td><input type="tel" name="empPhone" required></td>
            </tr>
            <tr>
                <td>입사일</td>
                <td><input type="date" name="hireDate" required></td>
            </tr>
            <tr>
                <td>주소:</td>
                <td><input type="text" name="address" required></td>
            </tr>
        </table>
        <button type="submit">사원추가</button>
    </form>
</body>
</html>