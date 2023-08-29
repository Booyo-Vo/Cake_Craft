<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<c:import url="/layout/cdn.jsp"></c:import>
</head>
<body>
<c:import url="/layout/header.jsp"></c:import>

<!-- 메인 시작 -->
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<!-- 페이지 헤더 시작 -->
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>시설비품 카테고리관리</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">홈</a></li>
								<li class="breadcrumb-item active" aria-current="page">시설비품관리</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<!-- 페이지 헤더 끝 -->
			
			<div class="pd-20 card-box mb-30">
				<form action="${pageContext.request.contextPath}/facility/addFacilityCd" method="post">
					<input type="hidden" name="regId" value="${loginId}">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>분류</th>
								<th>코드</th>
								<th>종류</th>
								<th>사용여부</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="d" items="${cdList}">
							<tr>
								<c:if test="${fn: startsWith(d.cd, '1')}">
									<td>시설</td>
								</c:if>
								<c:if test="${fn: startsWith(d.cd, '2')}">
									<td>비품</td>
								</c:if>
								<td>${d.cd}</td>
								<td id="nameForm${d.cd}">${d.cdNm}</td>
								<td><button type="button" id="use${d.cd}" onclick="changeUse(${d.cd})" class="btn btn-sm btn-secondary">${d.useYn}</button></td>
								<td id="modBtn${d.cd}"><button class="btn btn-sm btn-secondary" type="button" onclick="modNameForm(${d.cd}, '${d.cdNm}')">이름수정</button></td>
							</tr>
						</c:forEach>
							<tr>
								<td>
									<select id="facility" class="custom-select form-control" required>
										<option value="" selected disabled>==선택==</option>
										<option value="1">시설</option>
										<option value="2">비품</option>
									</select>
								</td>
								<td>
									<input type="text" class="form-control" name="cd" id="cd" value="" readonly required>
								</td>
								<td>
									<input type="text" class="form-control" name="cdNm" required>
								</td>
								<td>
									<select name="useYn" class="custom-select form-control" required>
										<option value="" selected disabled>==선택==</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
								</td>
								<td><button type="submit" class="btn btn-sm btn-primary">추가</button></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		
		<!-- 푸터 시작 -->
		<div class="footer-wrap pd-20 mb-20 card-box">
			DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
		</div>
		<!-- 푸터 끝 -->
	</div>
</div>
<!-- 메인 끝 -->

<script>
	$('#facility').change(function(){
		let cd = $('#facility').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/getCode',
			type : 'post', 
			data : {cd : cd},
			success : function(code){
				console.log('ajax성공');
				$('#cd').val(code);
			},
			error: function(){
				console.log('ajax실패');
			}
		})
	})
	
	function changeUse(cd){
		let useYn = '';
		let use = $('#use'+cd).text();
		if(use === 'Y'){
			useYn = 'N';
		} else {
			useYn = 'Y';
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/modifyFacilityCategory',
			type : 'post',
			data : {
				cd : cd,
				useYn : useYn
			},
			success : function(row){
				if(row == 1){
					console.log('변경성공');
					$('#use'+cd).text(useYn);
				} else {
					alert('이미 사용중인 카테고리입니다.');
				}
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	}
	
	function modNameForm(cd, cdNm){
		$('#nameForm'+cd).html('<input id="cdNm' +cd+ '" type="text" name="cdNm" value="' +cdNm+ '">');
		$('#modBtn'+cd).html('<button type="button" class="btn btn-sm btn-secondary" id="modNameBtn'+cd+'" onclick="modName('+cd+')">수정</button>');
	}
	
	function modName(cd){
		let cdNm = $('#cdNm'+cd).val();
		console.log(cdNm);
		if(cdNm === ''){
			alert('이름을 입력하세요');
			$('#cdNm'+cd).focus();
			return;
		} else {
			$.ajax({
				url : '${pageContext.request.contextPath}/rest/categoryNameCheck',
				type : 'post',
				data : {
					cd : cd,
					cdNm : cdNm},
				success : function(row){
					console.log('ajax성공');
					if(row > 0){
						alert('이미 사용중인 이름입니다');
						$('#cdNm'+cd).focus();
					}else {
						$.ajax({
							url : '${pageContext.request.contextPath}/rest/modifyFacilityCategory',
							type : 'post',
							data : {
								cd : cd,
								cdNm : cdNm
							},
							success : function(row){
								if(row == 1){
									console.log('변경성공');
									location.reload();
								} else {
									alert('수정에 실패하였습니다');
								}
							},
							error : function(){
								console.log('수정 ajax실패');
							}
						});
					}
				},
				error : function(){
					console.log('유효성 검사 ajax실패');
				}
			});
		}
	}

</script>
</body>
</html>