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
<div id="printSection">
	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="invoice-wrap">
					<div class="invoice-box">
						<h3 class="text-center mb-30 weight-600"><br>재&nbsp;직&nbsp;증&nbsp;명&nbsp;서</h3>
						<br>
						<br>
						<div class="invoice-desc pb-30">
							<table class="table table-bordered">
								<tr>
									<th>성명</th>
									<td>${empbase.empName}</td>
									<th>주민등록번호</th>
									<td>${empbase.socialNo}</td>
								</tr>
								<tr>
									<th>주소</th>
									<td colspan="3">${empbase.address}</td>
								</tr>
								<tr>
									<th>소속</th>
									<td>${empbase.deptNm}${empbase.teamNm}</td>
									<th>직책</th>
									<td>${empbase.positionNm}</td>
								</tr>
								<tr>
									<th>재직기간</th>
									<td colspan="3">${empbase.hireDate}&nbsp;~&nbsp;재직중</td>
								</tr>
							</table>
							<br>
							<br>
							<br>
							<div class="invoice-desc-body">
							<h5 class="text-center mb-30 weight-600"><br><br>상기와 같이 재직 하였음을 증명함</h5>
							</div>
							<div class="invoice-desc-footer">
							<h5 class="text-center mb-30 weight-600">${currentDate}</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<br>
<br>
</body>
</html>