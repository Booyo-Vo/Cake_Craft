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
<div class="main-container">
		<div>
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
							<td>${d.cdNm}</td>
							<td><button type="button" id="use-${d.cd}" onclick="changeUse(${d.cd})" class="btn btn-sm btn-secondary">${d.useYn}</button></td>
							<td></td>
						</tr>
					</c:forEach>
						<tr>
							<td>
								<select id="facility">
									<option value="" selected disalbed>==선택==</option>
									<option value="1">시설</option>
									<option value="2">비품</option>
								</select>
							</td>
							<td>
								<input type="text" name="cd" id="cd" value="" readonly>
							</td>
							<td>
								<input type="text" name="cdNm">
							</td>
							<td>
								<select name="useYn">
									<option value="Y" selected>Y</option>
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
		let use = $('#use-'+cd).text();
		if(use === 'Y'){
			useYn = 'N';
		} else {
			useYn = 'Y';
		}
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/modifyFacilityUse',
			type : 'post',
			data : {
				cd : cd,
				useYn : useYn
			},
			success : function(row){
				if(row == 1){
					console.log('변경성공');
					$('#use-'+cd).text(useYn);
				} else {
					alert('이미 사용중인 카테고리입니다.');
				}
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	}

</script>
</body>
</html>