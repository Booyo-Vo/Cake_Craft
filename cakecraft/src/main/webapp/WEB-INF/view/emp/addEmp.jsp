<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
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
});ㄴ
</script>
<!-- 공백이 입력되않도록 -->
<script>
$(document).ready(function() {
	$('form[name="empForm"]').submit(function(event) {
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
<div class="main-container">
    <form action="/cakecraft/emp/addEmp" method="post"  name="empForm">
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
		                <option value="${d.cdNm}">${d.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
		<tr>
		    <td>팀</td>
		    <td>
		        <select name="teamNm" disabled>
		            <c:forEach items="${teamList}" var="t">
		                <option value="${teamList}">${teamList}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
		<tr>
		    <td>직급</td>
		    <td>
		        <select name="positionNm">
		            <c:forEach items="${positionList}" var="p">
		                <option>${p.cdNm}</option>
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
 <br>
 <br>   
<h2>사원대량 업로드</h2>
<p>반드시 정해진 엑셀 양식으로 작성후 업로드해야합니다</p>
<a href="/cakecraft/excel/getExcelFrom" style="color:red">사원추가 엑셀양식</a>
<br>
<br>
<form action="/cakecraft/emp/addExcel" method="post" enctype="multipart/form-data">
    <input type="file" name="file" accept=".xlsx" required>
    <button type="submit">Upload</button>
</form>
 </div>
</body>
</html>