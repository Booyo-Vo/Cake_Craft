<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script>document.getElementsByTagName("html")[0].className += " js";</script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/reservation_assets/css/style.css">
	<title>reservation</title>
	<c:import url="/layout/cdn.jsp"></c:import>
</head>
<body>
<c:import url="/layout/header.jsp"></c:import>
<div class="main-container">
	<header class="cd-main-header text-center flex flex-column flex-center">
		<input type="date" id="selectDate" value="${date}" min="${currDay}" max="${weekDay}">
		<span class="text-xl mt-5">시설비품 예약현황</span>
	</header>

	<a href="${pageContext.request.contextPath}/reservation/reservation?categoryCd=1&targetYear=${targetYear}&targetMonth=${targetMonth}&targetDate=${targetDate}">회의실</a>
	<a href="${pageContext.request.contextPath}/reservation/reservation?categoryCd=2&targetYear=${targetYear}&targetMonth=${targetMonth}&targetDate=${targetDate}">비품</a>
  	<button type="button" class="btn btn-primary" data-bs-toggle=modal data-bs-target="#addRsrv">예약하기</button>
  	<!-- 메인 시작 -->
  	<div class="cd-schedule cd-schedule--loading margin-top-lg margin-bottom-lg js-cd-schedule">
		<!-- 타임라인 시작 -->
	    <div class="cd-schedule__timeline">
		<ul>
			<li><span>09:00</span></li>
			<li><span>09:30</span></li>
			<li><span>10:00</span></li>
			<li><span>10:30</span></li>
			<li><span>11:00</span></li>
			<li><span>11:30</span></li>
			<li><span>12:00</span></li>
			<li><span>12:30</span></li>
			<li><span>13:00</span></li>
			<li><span>13:30</span></li>
			<li><span>14:00</span></li>
			<li><span>14:30</span></li>
			<li><span>15:00</span></li>
			<li><span>15:30</span></li>
			<li><span>16:00</span></li>
			<li><span>16:30</span></li>
			<li><span>17:00</span></li>
			<li><span>17:30</span></li>
			<li><span>18:00</span></li>
		</ul>
	    </div>
		<!-- 타임라인 끝 -->
		
		<!-- 예약현황 시작 -->
	    <div class="cd-schedule__events">
			<ul>
				<c:forEach var="f" items="${facilityList}"><!-- 시설/비품 수만큼 반복 -->
					<li class="cd-schedule__group">
						<div class="cd-schedule__top-info"><span>${f.facilityName}</span></div>
						
						<!-- 스케줄만큼 반복 -->
						<ul>
							<c:forEach var="r" items="${reservationList}">
								<c:if test="${f.facilityNo == r.facilityNo}">
										<li class="cd-schedule__event">
											<a data-start="${fn:substring(r.startDtime, 10, 16)}" data-end="${fn:substring(r.endDtime, 10, 16)}" data-content="event-abs-circuit" data-event="event-1" href="#0">
												<em class="cd-schedule__name">${r.reservationContent}</em>
											</a>
										</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>
		<!-- 예약현황 끝 -->
		
		<!-- 시설비품 예약 모달창 시작 -->
		<div class="modal fade" id="addRsrv" tabindex="-1" aria-labelledby="addRsrvLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addRsrvLabel">예약수정</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="addRsrvForm">
							<input type="hidden" name="loginId" value="${loginId}">
							<div class="mb-3">
								<label for="facilityNo" class="col-form-label">카테고리</label>
								<select name="facilityNo" id="facilityNo">
									<option value="" selected disabled>선택</option>
									<c:forEach var="f" items="${facilityList}">
										<option value="${f.facilityNo}">${f.facilityName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="mb-3">
								<label for="teamNm" class="col-form-label">소속</label>
								<input type="text" class="form-control" name="teamNm" id="teamNm" value="${teamNm}">
							</div>
							<div class="mb-3">
								<label for="reservationContent" class="col-form-label">내용</label>
								<input type="text" class="form-control" name="reservationContent" id="reservationContent">
							</div>
							<div class="mb-3">
								<label for="date" class="col-form-label">날짜</label>
								<input type="date" class="form-control" name="date" id="date" value="${date}" readonly>
							</div>
							<div class="mb-3">
								<label for="times" class="col-form-label">예약시간</label>
								<select name="times" id="times" multiple>
								</select>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="addRsrvBtn" onclick="addReservation()">예약</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 시설비품 예약 모달창 끝 -->
		
		<!-- 예약상세 모달 시작 -->
		<div class="cd-schedule-modal">
			<header class="cd-schedule-modal__header">
				<div class="cd-schedule-modal__content">
				<span class="cd-schedule-modal__date"></span>
				<h3 class="cd-schedule-modal__name"></h3>
		</div>
		
		<div class="cd-schedule-modal__header-bg"></div>
		</header>
		
		<div class="cd-schedule-modal__body">
	    <div class="cd-schedule-modal__event-info"></div>
	    <div class="cd-schedule-modal__body-bg"></div>
		</div>
		
			<a href="#0" class="cd-schedule-modal__close text-replace">Close</a>
		</div>
		<!-- 예약상세 모달 끝 -->
		<div class="cd-schedule__cover-layer"></div>
	</div>
	<!-- 메인 끝 -->
	<script src="/cakecraft/reservation_assets/js/util.js"></script>
	<script src="/cakecraft/reservation_assets/js/main.js"></script>
</div>
</body>

<script>
	$('#facilityNo').change(function(){
		$('#times *').remove();
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/reservationInfo',
			type : 'post',
			data : {
				facilityNo : $('#facilityNo').val(),
				targetYear : ${targetYear},
				targetMonth : ${targetMonth},
				targetDate : ${targetDate}
				},
			success : function(unbookedList){
				console.log('ajax성공');
				//현재 시간 구하기
				unbookedList.forEach(function(item, index){
					const now = new Date().getTime();
					let rsrvTime = new Date('${date} '+ item.substring(0, item.indexOf(":")) + ':00:00').getTime();
					if(rsrvTime - now > (1000*60*60)){
						$('#times').append('<option value=' + item.substring(0, item.indexOf(":")) + '>' + item + '</option>');
					}
				})
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	})
	
	$('#selectDate').change(function(){
		let targetDay = $('#selectDate').val();
		console.log(targetDay);
		let targetYear = targetDay.substring(0,4);
		let targetMonth = parseInt(targetDay.substring(5,7)) - 1;
		let targetDate = targetDay.substring(8);
		
		window.location.href = '${pageContext.request.contextPath}/reservation/reservation?targetYear='+targetYear+'&targetMonth='+(targetMonth)+'&targetDate='+targetDate;
	})
	
	function addReservation(){
		console.log('예약버튼 클릭');
		const addFcltForm = $('#addRsrvForm');
		addFcltForm.attr('action', '${pageContext.request.contextPath}/reservation/addReservation');
		addFcltForm.attr('method', 'post');
		addFcltForm.submit();
	}
</script>
</html>