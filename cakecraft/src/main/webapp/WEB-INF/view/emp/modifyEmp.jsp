<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyEmp</title>
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
 <form action="/emp/modifyEmp" method="post">
<table>
    <tbody>
        <tr>
            <th>사번</th>
            <td>${empbase.id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td><input type="text" name="empName" value="${empbase.empName}"></td>
        </tr>
        <tr>
            <th>주민등록번호</th>
            <td>${empbase.socialNo}</td>
        </tr>
		<tr>
		    <th>부서</th>
		    <td>
		        <select name="deptNm">
		            <c:forEach items="${deptList}" var="d">
		                <option value="${d.cdNm}" ${d.cdNm == empbase.deptNm ? 'selected' : ''}>${d.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
		<tr>
		    <th>팀</th>
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
		    <th>직급</th>
		    <td>
		        <select name="positionNm">
		            <c:forEach items="${positionList}" var="p">
		                <option value="${p.cdNm}" ${p.cdNm == empbase.positionNm ? 'selected' : ''}>${p.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
        <tr>
            <th>이메일</th>
            <td><input type="email" name="email" value="${empbase.email}"></td>
        </tr>
        <tr>
            <th>입사일</th>
            <td>${empbase.hireDate}</td>
        </tr>
        <tr>
            <th>퇴사일</th>
            <td><input type="date" name="retireDate" value="${empbase.retireDate}"></td>
        </tr>
        <tr>
            <th>재직상태</th>
            <td>                
           	 <select name="empStatus">
                  <option value="재직자" ${empbase.empStatus == '재직자' ? 'selected' : ''}>재직자</option>
                   <option value="퇴사자" ${empbase.empStatus == '퇴사자' ? 'selected' : ''}>퇴사자</option>
             </select>
             </td>
        </tr>
        <tr>
            <th>연차잔여개수</th>
            <td>${empbase.dayoffCnt}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td><input type="text" name="address" value="${empbase.address}"></td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td><input type="tel" name="empPhone" value="${empbase.empPhone}"></td>
        </tr>
        <tr>
            <th>등록일시</th>
            <td>${empbase.regDtime}</td>
        </tr>
        <tr>
            <th>수정일시</th>
            <td>${empbase.modDtime}</td>
        </tr>
        <tr>
            <th>등록자</th>
            <td>${empbase.regId}</td>
        </tr>
        <tr>
            <th>수정자</th>
            <td>${empbase.modId}</td>
        </tr>
    </tbody>
</table>
<!-- redirect 할때 id 값이 필요해서 hidden으로 전달함-->
<input type ="hidden" name="id" value="${empbase.id}">
<button type="submit">수정</button>
</form>
</body>
</html>