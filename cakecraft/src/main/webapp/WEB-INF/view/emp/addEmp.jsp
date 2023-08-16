<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addEmp</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
       $.get('/getTeamListByDept?deptNm=' + selectedDept, function(teams) {
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
        });
    });
});
</script>
</head>
<body>
    <form action="/emp/addEmp" method="post">
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
		        <select name="teamNm">
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