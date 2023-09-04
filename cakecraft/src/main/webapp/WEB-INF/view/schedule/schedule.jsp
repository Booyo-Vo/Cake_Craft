<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<style>
.td01 {
	height:100px;
	width: 14%;
	font-size: 12px;
}
.p-rel{
	position: relative;
}
.text-top-right {
	position: absolute;
	top: 7px;
	right: 6px;
}
.ell{
	display: block;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	width: 90%;
}
.ell-parent {
	position: absolute;
	width: 90%;
}

</style>
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
							<h4>일 정</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">Schedule</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			<div class="pd-20 card-box mb-30">
				<div class="container">
					<h1>${strTargetMonth} ${targetYear}</h1>
					<div class="row">
						<!-- 달력 시작 -->
						<div class="col-md-10">
							<div class="pull-right">
								<a class="btn" href="${pageContext.request.contextPath}/schedule/schedule?targetYear=${todayYear}&targetMonth=${todayMonth}">today</a>
								<a class="btn" href="${pageContext.request.contextPath}/schedule/schedule?targetYear=${targetYear}&targetMonth=${targetMonth-1}">&#10094;</a>
								<a class="btn" href="${pageContext.request.contextPath}/schedule/schedule?targetYear=${targetYear}&targetMonth=${targetMonth+1}">&#10095;</a>
							</div>
							<br><br>
							<table class="table table-bordered">
								<tr class="text-center">
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
											<td class="td01 p-rel">
												<div class="text-top-right">
													<a data-bs-toggle="modal" href="#addScheduleModal" onclick="date(${d},${targetYear},${targetMonth})">${d}</a>
												</div>
												<br>
												
												<!-- 해당 일자의 공휴일을 출력 -->
												<c:forEach var="l" items="${holidayList}">
													<div class="ell-parent">
														<c:if test="${fn:substring(l.locdate,4,6) == (targetMonth+1) && fn:substring(l.locdate,6,8) == d}">
															<span class="ell" style="background-color: #99004C; color: #FFFFFF;">&nbsp;${l.dateName}</span>
														</c:if>
													</div>
												</c:forEach>
												<div style="padding-bottom:26%;"></div>
												
												<!-- 전사일정 조회 -->
												<c:forEach var="c" items="${scheduleListByCateAll}">
													<c:if test="${fn:substring(c.startDtime, 8, 10) == d}">
														<div class="ell-parent">
															<!-- 인사팀인 경우만 전사일정 수정,삭제 가능 -->
															<c:if test="${c.teamCd == '11'}">
																<a data-bs-toggle="modal" href="#modifyScheduleModal" onclick="scheduleNo(${c.scheduleNo})">
																	<span class="ell" style="background-color: #638899; color: #FFFFFF;">&nbsp;${c.scheduleContent}</span>
																</a>
															</c:if>
															<c:if test="${c.teamCd != '11'}">
																<span class="ell" style="background-color: #638899; color: #FFFFFF;">&nbsp;${c.scheduleContent}</span>
															</c:if>
														</div>
														<div style="padding-bottom:26%;"></div>
													</c:if>
												</c:forEach>
												<!-- 팀일정 조회 -->
												<c:forEach var="c" items="${scheduleListByCateTeam}">
													<c:if test="${fn:substring(c.startDtime, 8, 10) == d}">
														<div class="ell-parent">
															<c:if test="${c.categoryCd == '2'}">
																<!-- 시설 예약인 경우엔 수정,삭제 불가능 -->
																<c:if test="${fn:substring(c.scheduleContent, 0, 4) == '[예약]'}">
																	<span class="ell" style="background-color: #F68E8E; color: #FFFFFF;">&nbsp;${c.scheduleContent}</span>
																</c:if>
																<c:if test="${fn:substring(c.scheduleContent, 0, 4) != '[예약]'}">
																	<a data-bs-toggle="modal" href="#modifyScheduleModal" onclick="scheduleNo(${c.scheduleNo})">
																		<span class="ell" style="background-color: #F68E8E; color: #FFFFFF;">&nbsp;${c.scheduleContent}</span>
																	</a>
																</c:if>
															</c:if>
														</div>
														<div style="padding-bottom: 26%;"></div>
													</c:if>
												</c:forEach>
												<!-- 개인일정 조회 -->
												<c:forEach var="c" items="${scheduleListByCateId}">
													<c:if test="${fn:substring(c.startDtime, 8, 10) == d}">
														<div class="ell-parent">
															<c:if test="${c.categoryCd == '3'}">
																<!-- 비품 예약인 경우엔 수정,삭제 불가능 -->
																<c:if test="${fn:substring(c.scheduleContent, 0, 4) == '[예약]'}">
																	<span class="ell" style="background-color: #919CD4; color: #FFFFFF;">&nbsp;${c.scheduleContent}</span>
																</c:if>
																<c:if test="${fn:substring(c.scheduleContent, 0, 4) != '[예약]'}">
																	<a data-bs-toggle="modal" href="#modifyScheduleModal" onclick="scheduleNo(${c.scheduleNo})">
																		<span class="ell" style="background-color: #919CD4; color: #FFFFFF;">&nbsp;${c.scheduleContent}</span>
																	</a>
																</c:if>
															</c:if>
														</div>
														<div style="padding-bottom: 26%;"></div>
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
						<div class="col-md-2" style="padding-top: 50px;">
							<span><b>today schedule</b><br><br></span>
							<div class="mb-5">
								<span style="background-color: #638899; color: #FFFFFF; display:block; width: 100%;">&nbsp;전사일정&nbsp;</span>
								<c:forEach var="c" items="${scheduleListByDate}">
									<c:if test="${c.categoryCd == '1'}">
										<div>
											<span>&#8226; ${c.scheduleContent}</span>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="mb-5">
								<span style="background-color: #F68E8E; color: #FFFFFF; display:block; width: 100%;">&nbsp;팀 일정&nbsp;</span>
								<c:forEach var="c" items="${scheduleListByDate}">
									<c:if test="${c.categoryCd == '2'}">
										<div>
											<span>&#8226; ${c.scheduleContent}</span>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div>
								<span style="background-color: #919CD4; color: #FFFFFF; display:block; width: 100%;">&nbsp;개인 일정&nbsp;</span>
								<c:forEach var="c" items="${scheduleListByDate}">
									<c:if test="${c.categoryCd == '3'}">
										<div>
											<span>&#8226; ${c.scheduleContent}</span>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<!-- 오늘의 일정 끝 -->
					</div>
				</div>
			</div>
			
			<!-- 결재문서 알림, 공지사항 알림 시작 -->
			<div class="pd-20 card-box mb-30">
				<div class="row">
					<!-- 결재문서알림 : 최신작성일순 3개 -->
					<div class="col-md-6">
						<div class="container" style="width: 80%">
							<div style="padding-bottom: 10px;">
								<b>[결재문서알림]</b>
								<div class="pull-right">
									<a href="${pageContext.request.contextPath}/approval/apprDocWaitListByNo">+더보기</a>
								</div>
							</div>
							<c:forEach var="a" items="${apprDocList}" varStatus="status">
								<c:if test="${status.index < 3}">
									<div>&nbsp;&#8226; ${a.documentTitle}</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<!-- 공지사항알림: 최신작성일순 3개 -->
					<div class="col-md-6">
						<div class="container" style="width: 80%">
							<div style="padding-bottom: 10px;">
								<b>[공지사항알림]</b>
								<div class="pull-right">
									<a href="${pageContext.request.contextPath}/board/noticeList">+더보기</a>
								</div>
							</div>
							<c:forEach var="n" items="${noticeList}" varStatus="status">
								<c:if test="${status.index < 3}">
									<div>&nbsp;&#8226; ${n.noticeTitle}</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<!-- 결재문서 알림, 공지사항 알림 끝 -->
		</div>
	</div>
</div>
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
					<input type="hidden" name="id" value="${loginId}">
					<input type="hidden" name="teamCd" value="${empBase.teamCd}">
					<div class="mb-3">
						<label for="categoryCd" class="col-form-label">카테고리</label>
						<select class="form-control" name="categoryCd" id="categoryCd">
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
						<input type="text" class="form-control" name="scheduleContent" id="scheduleContent">
					</div>
					<div class="mb-3">
						<label for="startDtime" class="col-form-label">시작일</label>
						<input type="date" class="form-control" name="startDtime" id="startDtime" readonly="readonly">
					</div>
					<div class="mb-3">
						<label for="endDtime" class="col-form-label">종료일</label>
						<input type="date" class="form-control" name="endDtime" id="endDtime" min="">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" onclick="addSchedule()">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- 일정 추가 모달창 끝 -->

<!-- 일정 수정 모달창 시작 -->
<div class="modal fade" id="modifyScheduleModal" tabindex="-1" aria-labelledby="modifyScheduleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modifyScheduleModalLabel">일정 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="modifyScheduleForm">
					<input type="hidden" name="scheduleNo" id="modScheduleNo">
					<input type="hidden" name="id" value="${loginId}">
					<input type="hidden" name="teamCd" value="${empBase.teamCd}">
					<div class="mb-3">
						<label for="modCategoryCd" class="col-form-label">카테고리</label>
						<select class="form-control" name="categoryCd" id="modCategoryCd">
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
						<label for="modScheduleContent" class="col-form-label">일정내용</label>
						<input type="text" class="form-control" name="scheduleContent" id="modScheduleContent">
					</div>
					<div class="mb-3">
						<label for="modStartDtime" class="col-form-label">시작일</label>
						<input type="date" class="form-control" name="startDtime" id="modStartDtime">
					</div>
					<div class="mb-3">
						<label for="modEndDtime" class="col-form-label">종료일</label>
						<input type="date" class="form-control" name="endDtime" id="modEndDtime">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" onclick="removeSchedule()">삭제</button>
				<button type="button" class="btn btn-primary" onclick="modifySchedule()">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- 일정 수정 모달창 끝 -->

<jsp:include page="/layout/footer.jsp"></jsp:include>
<script>
// 날짜 클릭 시 일정추가 모달창에 날짜값 넘겨주기 및 모달 띄우기
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
			$('#endDtime').attr('min', model);
		},
		error : function(){
			console.log('addSchedule ajax실패');
		},
	});
}

// 일정 추가 버튼 클릭 시
function addSchedule(){
	// 입력폼 유효성 검사
	if($('#categoryCd').val() == ''){
		alert('카테고리를 설정해주세요');
		return;
	}else if($('#scheduleContent').val() == ''){
		alert('일정내용을 입력해주세요');
		return;
	}else if($('#endDtime').val() == ''){
		alert('종료일을 설정해주세요');
		return;
	}else if($('#endDtime').val() < $('#startDtime').val()){
		alert('종료일을 재설정해주세요');
		$('#endDtime').val('');
		$('#endDtime').focus();
		return;
	}
	// 입력폼 제출
	const addScheduleForm = $('#addScheduleForm');
	addScheduleForm.attr('action', '${pageContext.request.contextPath}/schedule/addSchedule');
	addScheduleForm.attr('method', 'post');
	addScheduleForm.submit();
}

// 일정 클릭 시 상세보기 및 일정수정 모달 띄우기
function scheduleNo(scheduleNo){
	$.ajax({
		url : '${pageContext.request.contextPath}/rest/modifySchedule',
		type : 'post',
		data : {
			scheduleNo : scheduleNo
		},
		success : function(model){
			console.log('modifySchedule ajax성공');
			console.log(model);
			const scheduleNo = model.scheduleNo;
			$('#modScheduleNo').val(model.scheduleNo);
			$('#modCategoryCd').val(model.categoryCd);
			$('#modScheduleContent').val(model.scheduleContent);
			$('#modStartDtime').val(model.startDtime.substring(0,10));
			$('#modEndDtime').val(model.endDtime.substring(0,10));
		},
		error : function(){
			console.log('modifySchedule ajax실패');
		},
	});
}

// 일정 수정 버튼 클릭 시
function modifySchedule(){
	// 수정폼 유효성 검사
	if($('#modCategoryCd').val() == ''){
		alert('카테고리를 설정해주세요');
		return;
	}else if($('#modScheduleContent').val() == ''){
		alert('일정내용을 입력해주세요');
		return;
	}else if($('#modEndDtime').val() == ''){
		alert('종료일을 설정해주세요');
		return;
	}else if($('#modEndDtime').val() < $('#modStartDtime').val()){
		alert('종료일을 재설정해주세요');
		$('#modEndDtime').val('');
		$('#modEndDtime').focus();
		return;
	}

	// 수정폼 제출
	const modifyScheduleForm = $('#modifyScheduleForm');
	modifyScheduleForm.attr('action', '${pageContext.request.contextPath}/schedule/modifySchedule');
	modifyScheduleForm.attr('method', 'post');
	modifyScheduleForm.submit();
}

// 일정 삭제 버튼 클릭 시
function removeSchedule() {
	const scheduleNo = $('#modScheduleNo').val(); 

	if (confirm('일정을 삭제하시겠습니까?')) {
		window.location.href = '${pageContext.request.contextPath}/schedule/removeSchedule?scheduleNo=' + scheduleNo;
	}
}
</script>
</body>
</html>