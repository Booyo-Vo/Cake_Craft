<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<h4>사원 상세정보</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">emp</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<!-- Default Basic Forms Start -->
				<div class="pd-20 card-box mb-30">
				<div class="clearfix">
								<div class="pull-left">
									<p class="mb-30"><b>${empbase.id} 님의 정보를 조회합니다</b></p>
								</div>
							</div>
					<div class="row">
						<div class="col-md-6 col-sm-12">
								<form>
									<!-- 이름 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>이름</b></label>
										<div class="col-sm-12 col-md-10">
											${empbase.empName}
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>사원번호</b></label>
										<div class="col-sm-12 col-md-10">
											${empbase.id}
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>부서</b></label>
										<div class="col-sm-12 col-md-10">
											${empbase.deptNm}
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>팀</b></label>
										<div class="col-sm-12 col-md-10">
											${empbase.teamNm}
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>직급</b></label>
										<div class="col-sm-12 col-md-10">
											${empbase.positionNm}
										</div>
									</div>
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>이메일</b></label>
										<div class="col-sm-12 col-md-10">
											${empbase.email}
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>