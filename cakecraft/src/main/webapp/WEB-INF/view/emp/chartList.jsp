<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chartList</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
    ${month} 월 입사자 퇴사자
    <br>
    재직자 수: ${hireMonthCnt}
    퇴사자 수: ${retireMonthCnt}
    <br>
     ${year}년 입사자 퇴사자
    <br>
    재직자 수: ${hireYearCnt}
    퇴사자 수: ${retireYearCnt}
    <br>
    직급별 인원 수 
    <table border="1">
        <tr>
            <th>직급</th>
            <th>인원</th>
        </tr>
        <c:forEach items="${positionCnt}" var="position">
            <tr>
                <td>${position.positionName}</td>
                <td>${position.positionCnt}</td>
            </tr>
        </c:forEach>
    </table>
    부서별 인원 수 
    <table border="1">
        <tr>
            <th>부서</th>
            <th>인원</th>
        </tr>
        <c:forEach items="${deptCnt}" var="dept">
            <tr>
                <td>${dept.deptName}</td>
                <td>${dept.deptCnt}</td>
            </tr>
        </c:forEach>
    </table>
     팀별 인원 수 
    <table border="1">
        <tr>
            <th>팀</th>
            <th>인원</th>
        </tr>
        <c:forEach items="${teamCnt}" var="team">
            <tr>
                <td>${team.teamName}</td>
                <td>${team.teamCnt}</td>
            </tr>
        </c:forEach>
    </table>
     <c:forEach items="${genderCnt}" var="genderCnt">
    남자${genderCnt.maleCount}
    여자${genderCnt.femaleCount}
	</c:forEach>
</body>
</html>