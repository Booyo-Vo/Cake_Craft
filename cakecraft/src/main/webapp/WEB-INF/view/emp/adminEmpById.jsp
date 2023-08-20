<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminEmpById</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
<table>
    <tbody>
        <tr>
            <th>사번</th>
            <td>${empbase.id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${empbase.empName}</td>
        </tr>
        <tr>
            <th>주민등록번호</th>
            <td>${empbase.socialNo}</td>
        </tr>
        <tr>
            <th>부서</th>
            <td>${empbase.deptNm}</td>
        </tr>
        <tr>
            <th>팀</th>
            <td>${empbase.teamNm}</td>
        </tr>
        <tr>
            <th>직급</th>
            <td>${empbase.positionNm}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${empbase.email}</td>
        </tr>
        <tr>
            <th>입사일</th>
            <td>${empbase.hireDate}</td>
        </tr>
        <tr>
            <th>퇴사일</th>
            <td>${empbase.retireDate}</td>
        </tr>
        <tr>
            <th>재직상태</th>
            <td>${empbase.empStatus}</td>
        </tr>
        <tr>
            <th>연차잔여개수</th>
            <td>${empbase.dayoffCnt}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${empbase.address}</td>
        </tr>
        <tr>
            <th>핸드폰번호</th>
            <td>${empbase.empPhone}</td>
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
<a href="/cakecraft/emp/modifyEmp?id=${empbase.id}">사원수정</a>
</div>
</body>
</html>