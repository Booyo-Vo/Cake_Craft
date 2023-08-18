<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyEmp</title>
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
 <form action="/cakecraft/emp/modifyEmp" method="post">
<table>
    <tbody>
        <tr>
            <th>사번</th>
            <td>${empbase.id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td><input type="text" name="empName" value="${empbase.empName}" required></td>
        </tr>
        <tr>
            <th>주민등록번호</th>
            <td>${empbase.socialNo}</td>
        </tr>
		<tr>
		    <th>부서</th>
		    <td>
		        <select name="deptNm" required>
		            <c:forEach items="${deptList}" var="d">
		                <option value="${d.cdNm}" ${d.cdNm == empbase.deptNm ? 'selected' : ''}>${d.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
		<tr>
		    <th>팀</th>
		    <td>
		        <select name="teamNm" required data-selected-team="${empbase.teamNm}">
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
		        <select name="positionNm" required>
		            <c:forEach items="${positionList}" var="p">
		                <option value="${p.cdNm}" ${p.cdNm == empbase.positionNm ? 'selected' : ''}>${p.cdNm}</option>
		            </c:forEach>
		        </select>
		    </td>
		</tr>
        <tr>
            <th>이메일</th>
            <td><input type="email" name="email" value="${empbase.email}" required></td>
        </tr>
        <tr>
            <th>입사일</th>
            <td>${empbase.hireDate}</td>
        </tr>
		    <tr>
		        <th>퇴사일</th>
		        <td><input type="date" name="retireDate" value="${empbase.retireDate}" required></td>
		    </tr>
        <tr>
            <th>재직상태</th>
            <td>                
           	 <select name="empStatus" required>
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
            <td><input type="text" name="address" value="${empbase.address}" required></td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td><input type="tel" name="empPhone" value="${empbase.empPhone}" required></td>
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