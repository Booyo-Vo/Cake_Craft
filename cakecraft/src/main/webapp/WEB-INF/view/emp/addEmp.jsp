<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <form action="/emp/addEmp" method="post">
        <label for="empName">이름:</label>
        <input type="text" id="empName" name="empName" required><br>
        
        <label for="socialNo">주민번호:</label>
        <input type="text" id="socialNo" name="socialNo" required><br>
        
        <label for="deptNm">부서명</label>
        <input type="text" id="deptNm" name="deptNm" required><br>
        
        <label for="teamNm"> 팀이름</label>
        <input type="text" id="teamNm" name="teamNm" required><br>
        
        <label for="positionNm">직급</label>
        <input type="text" id="positionNm" name="positionNm" required><br>
        
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br>
        
        <label for="hireDate">입사일:</label>
        <input type="date" id="hireDate" name="hireDate" required><br>
        
        <label for="address">주소:</label>
        <input type="text" id="address" name="address" required><br>
<button type="submit">사원추가</button>
    </form>
</body>
</html>