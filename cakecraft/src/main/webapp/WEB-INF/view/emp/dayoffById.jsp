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
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>연차사용내역</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="/cakecraft/emp/adminEmpList">Admin Emp list</a></li>
								<li class="breadcrumb-item active" aria-current="page">Dayoff list</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
<!-- 제목 끝 -->
		<div class="pd-20 card-box mb-30">
			<div class="form-group row">
					<h4 class="mb-15 text-blue h4">${empBase.empName}</h4>
					<c:if test="${not empty empDayoff}">
						<table class="table">
							<tr>
								<td></td>   
								<td>사번</td>   
								<td>상태</td>   
								<td>시작일</td> 
								<td>종료일</td>     
							</tr>
						<c:forEach items="${empDayoff}" var="e">
							<tr>
								<td></td>   
								<td>${e.id}</td>   
								<td>${e.dayoffStatusNm}</td>   
								<td>${e.startDay}</td> 
								<td>${e.endDay}</td>     
							</tr>
						</c:forEach>
					</table>
				</c:if>
					<c:if test="${empty empDayoff}">
						<p class ="text-center">연차사용내역이 없습니다</p>
					</c:if>
					<br>
					<div class ="text-right font-20">
						<table class="table">
							<tr>
								<th>잔여 연차</th>
								<th> ${empBase.dayoffCnt} </th>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 푸터 시작 -->
<c:import url="/layout/footer.jsp"></c:import>
<!-- 푸터 끝 -->	
</body>
</html>