<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
<h3>${empBase.empName}의 연차사용내역</h3>
<table>
	<tr>
		<td></td>   
		<td>사번</td>   
		<td>이름</td>   
		<td>상태</td>   
		<td>시작일</td> 
		<td>종료일</td>     
	</tr>
		<tr>
		<td></td>   
		<td>${empDayoff.id}</td>   
		<td>이름</td>   
		<td>${empDayoff.dayoffStatus}</td>   
		<td>${empDayoff.startDay}</td> 
		<td>${empDayoff.endDay}</td>     
	</tr>
</table>
</div>
</body>
</html>