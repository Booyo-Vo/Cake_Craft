<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<!--  증명서 출력 -->
<script>
var printPage = function() {
	document.body.innerHTML = printSection.innerHTML;
	window.print();
};
</script>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<!-- 제목 -->
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>증명서출력</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="/cakecraft/emp/adminEmpList">Admin Emp list</a></li>
								<li class="breadcrumb-item active" aria-current="page">Certificate</li>
							</ol>
							<div class="d-flex justify-content-end mb-3">
							    <button onclick="printPage();" class="btn btn-primary">프린트 출력   <i class="icon-copy fa fa-print" aria-hidden="true"></i></button>
							</div>
						</nav>
					</div>
				</div>
			</div>
		<div id="printSection">
			<div class="pd-ltr-20 xs-pd-20-10">
				<div class="min-height-200px">
					<div class="invoice-wrap">
						<div class="invoice-box">
							<c:if test="${empbase.empStatus eq '재직자'}">
								<h2 class="text-center mb-30 weight-600"><br>재&nbsp;직&nbsp;증&nbsp;명&nbsp;서</h2>
							</c:if>
							<c:if test="${empbase.empStatus eq '퇴사자'}">
								<h2 class="text-center mb-30 weight-600"><br>경&nbsp;력&nbsp;증&nbsp;명&nbsp;서</h2>
							</c:if>
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
										<td>${empbase.deptNm}&nbsp;&nbsp;${empbase.teamNm}</td>
										<th>직책</th>
										<td>${empbase.positionNm}</td>
									</tr>
									<tr>
										<th>재직기간</th>
										<c:if test="${empbase.empStatus eq '재직자'}">
											<td colspan="3">${empbase.hireDate}&nbsp;~&nbsp;재직중</td>
										</c:if>
										<c:if test="${empbase.empStatus eq '퇴사자'}">
											<td colspan="3">${empbase.hireDate}&nbsp;~&nbsp;${empbase.retireDate}</td>
										</c:if>
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
								<div class="invoice-desc-footer">
									<h5 class="text-center mb-30 weight-600 font-24">(주)cakecraft</h5>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<br>
<!-- 푸터 시작 -->
<c:import url="/layout/footer.jsp"></c:import>
<!-- 푸터 끝 -->
</body>
</html>