<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>schedule.jsp</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
<h1>${targetYear}년 ${targetMonth+1}월 </h1>
<a href="/schedule?targetYear=${targetYear}&targetMonth=${targetMonth-1}">이전</a>
<a href="/schedule?targetYear=${targetYear}&targetMonth=${targetMonth+1}">다음</a>
<div class="container">
	<div class="row">
		<!-- 달력 시작 -->
		<div class="col-8">
			<table class="table">
				<tr>
					<th>Sun</th>
					<th>Mon</th>
					<th>Tue</th>
					<th>Wed</th>
					<th>Thu</th>
					<th>Fri</th>
					<th>Sat</th>
				</tr>
				<tr>
					<c:forEach var="i" begin="0" end="${totalTd -1}" step="1">
						<c:set var="d" value="${i-beginBlank+1}"></c:set>
						<c:if test="${i!=0 && i%7==0}">
							</tr><tr>
						</c:if>
						<c:if test="${d < 1 || d > lastDate}">
							<td>&nbsp;</td>
						</c:if>
						<c:if test="${!(d < 1 || d > lastDate)}">
							<td>
								<a data-bs-toggle="modal" href="#addScheduleModal" onclick="date(${d},${targetYear},${targetMonth})">${d}</a>
								<c:forEach var="c" items="${scheduleList}">
									<c:if test="${fn:substring(c.startDtime, 8, 10) == d}">
										<div>
											<c:if test="${c.categoryCd == '1'}">
												<span style="color:blue">●</span><span> ${c.scheduleContent}</span>
											</c:if>
											<c:if test="${c.categoryCd == '2'}">
												<span style="color:red">●</span><span> ${c.scheduleContent}</span>
											</c:if>
											<c:if test="${c.categoryCd == '3'}">
												<span style="color:black">●</span><span> ${c.scheduleContent}</span>
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</table>
		</div>
		<!-- 달력 끝 -->
		
		<!-- 오늘의 일정 시작 -->
		<div class="col-4">
			<div class="mb-5">
				<span style="color:blue">●</span> 전사일정
				<c:forEach var="c" items="${scheduleListByDate}">
					<c:if test="${c.categoryCd == '1'}">
						<div>
							<span> ${c.scheduleContent}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="mb-5">
				<span style="color:red">●</span> 팀일정
				<c:forEach var="c" items="${scheduleListByDate}">
					<c:if test="${c.categoryCd == '2'}">
						<div>
							<span> ${c.scheduleContent}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div>
				<span style="color:black">●</span> 개인일정
				<c:forEach var="c" items="${scheduleListByDate}">
					<c:if test="${c.categoryCd == '3'}">
						<div>
							<span>${c.scheduleContent}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<!-- 오늘의 일정 끝 -->
		
		<!-- 일정 추가 모달창 시작 -->
		<div class="modal fade" id="addScheduleModal" tabindex="-1" aria-labelledby="addScheduleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addScheduleModalLabel">일정 추가</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="addScheduleForm">
							<input type="hidden" name="loginId" value="${loginId}">
							<input type="hidden" name="teamCd" value="${empBase.teamCd}">
							<div class="mb-3">
								<label for="categoryCd" class="col-form-label">카테고리</label>
								<select name="categoryCd" id="categoryCd">
									<option value= "">==선택해주세요==</option>
									<!-- '인사팀'인 경우에만 '전사일정' 드랍다운 항목 표시 -->
									<c:if test="${empBase.teamCd == '11'}">
										<option value="1">전사 일정</option>
									</c:if>
									<option value="2">팀 일정</option>
									<option value="3">개인 일정</option>
								</select>
							</div>
							<div class="mb-3">
								<label for="scheduleContent" class="col-form-label">일정내용</label>
								<textarea class="form-control" name="scheduleContent" id="scheduleContent"></textarea>
							</div>
							<div class="mb-3">
								<label for="startDtime" class="col-form-label">시작일</label>
								<input type="date" class="form-control" name="startDtime" id="startDtime">
							</div>
							<div class="mb-3">
								<label for="endDtime" class="col-form-label">종료일</label>
								<input type="date" class="form-control" name="endDtime" id="endDtime">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="addScheduleBtn" onclick="addSchedule()">추가</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 일정 추가 모달창 끝 -->
	</div>
</div>
<script>
// 날짜 클릭 시 일정추가 모달창에 날짜값 넘겨주기
function date(d, targetYear, targetMonth){
	$.ajax({
		url : '${pageContext.request.contextPath}/rest/addSchedule',
		type : 'post',
		data : {
			targetDate : d,
			targetYear : targetYear,
			targetMonth : targetMonth
		},
		success : function(model){
			console.log('addSchedule ajax성공');
			console.log(model);
			$('#startDtime').val(model);
			$('#addScheduleModal').modal('show');
		},
		error : function(){
			console.log('addSchedule ajax실패');
		},
	});
}

// 일정 추가 버튼 클릭 시 폼 제출
function addSchedule(){
	console.log('추가버튼 클릭');
	const addScheduleForm = $('#addScheduleForm');
	addScheduleForm.attr('action', '${pageContext.request.contextPath}/schedule/addSchedule');
	addScheduleForm.attr('method', 'post');
	addScheduleForm.submit();
}
</script>
</body>
</html>