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
		<div class="pd-20 card-box mb-30">
			<div class="clearfix">
				<div class="pull-left">
					<h4 class="text-blue h4">${empbase.empName} 사원정보</h4>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">사번</label>
				<div class="col-sm-12 col-md-4">
					${empbase.id}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">주민등록번호</label>
				<div class="col-sm-12 col-md-4">
					${empbase.socialNo}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">부서</label>
				<div class="col-sm-12 col-md-4">
					${empbase.deptNm}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">팀</label>
				<div class="col-sm-12 col-md-4">
					${empbase.teamNm}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">직급</label>
				<div class="col-sm-12 col-md-4">
					${empbase.positionNm}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">이메일</label>
				<div class="col-sm-12 col-md-4">
					${empbase.email}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">입사일</label>
				<div class="col-sm-12 col-md-4">
					${empbase.hireDate}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">퇴사일</label>
				<div class="col-sm-12 col-md-4">
					${empbase.retireDate}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">재직상태</label>
				<div class="col-sm-12 col-md-4">
					${empbase.empStatus}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">연차잔여개수</label>
				<div class="col-sm-12 col-md-4">
					${empbase.dayoffCnt}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">주소</label>
				<div class="col-sm-12 col-md-4">
					${empbase.address}
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-12 col-md-2 col-form-label">핸드폰번호</label>
				<div class="col-sm-12 col-md-4">
					${empbase.empPhone}
				</div>
			</div>
		</div>
	</div>
</div>
<a href="/cakecraft/emp/adminmodifyEmp?id=${empbase.id}" class="btn btn-primary">사원수정</a>
</div>
</body>
</html>