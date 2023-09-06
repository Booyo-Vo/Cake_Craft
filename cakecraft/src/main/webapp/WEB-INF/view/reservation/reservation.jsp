<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script>document.getElementsByTagName("html")[0].className += " js";</script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layout/reservation_assets/css/style.css">
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
								<h4>사용예약</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">Reservation</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<!-- 페이지 헤더 끝 -->
				
				<!-- 예약 캘린더 시작 -->
				<div class="pd-20 card-box mb-30">
					<label for="selectDate">예약날짜선택</label>
					<div class="row">
						<div class="col-3">
							<input type="date" id="selectDate" class="form-control" value="${date}" min="${currDay}" max="${weekDay}">
						</div>
						<div class="col-9">
						  	<button type="button" class="btn btn-primary" data-bs-toggle=modal data-bs-target="#addRsrv">예약하기</button>
						</div>
					</div>
				  	
				  	<div class="mt-5">
						<a class="btn btn-secondary" href="${pageContext.request.contextPath}/reservation/reservation?categoryCd=1&targetYear=${targetYear}&targetMonth=${targetMonth}&targetDate=${targetDate}">회의실</a>
						<a class="btn btn-secondary" href="${pageContext.request.contextPath}/reservation/reservation?categoryCd=2&targetYear=${targetYear}&targetMonth=${targetMonth}&targetDate=${targetDate}">비품</a>
				  	</div>
					
				  	<div class="cd-schedule cd-schedule--loading margin-top-sm margin-bottom-lg js-cd-schedule">
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
														<a data-start="${fn:substring(r.startDtime, 10, 16)}" data-end="${fn:substring(r.endDtime, 10, 16)}" data-content="event-abs-circuit" data-event="event-${(r.id % 4) + 1}" href="#0">
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
										<h5 class="modal-title" id="addRsrvLabel">예약하기</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<form id="addRsrvForm">
											<input type="hidden" name="loginId" value="${loginId}">
											<div class="mb-3">
												<label for="categoryCd" class="col-form-label">카테고리</label>
												<select name="categoryCd" id="categoryCd" class="form-control" required>
													<option value="" selected disabled>==선택==</option>
													<option value="1">시설</option>
													<option value="2">비품</option>
												</select>
											</div>
											<div class="mb-3">
												<label for="facilityNo" class="col-form-label">시설비품</label>
												<select name="facilityNo" id="facilityNo" class="form-control" required>
													<option value="" selected disabled>==선택==</option>
												</select>
											</div>
											<div class="mb-3">
												<label for="teamNm" class="col-form-label">소속</label>
												<input type="text" class="form-control" name="teamNm" id="teamNm" value="${teamNm}">
											</div>
											<div class="mb-3">
												<label for="reservationContent" class="col-form-label">내용</label>
												<input type="text" class="form-control" name="reservationContent" id="reservationContent">
												<span id="contentMsg"></span>
											</div>
											<div class="mb-3">
												<label for="date" class="col-form-label">날짜</label>
												<input type="date" class="form-control" name="date" id="date" value="${date}" readonly>
											</div>
											<div class="mb-3">
												<label for="times" class="col-form-label">예약시간</label>
												<select class="form-control" name="times" id="times" multiple>
													<option value="" selected disabled>&darr;&darr;예약가능시간&darr;&darr;</option>
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
				</div>
				<!-- 예약 캘린더 끝 -->
			</div>
		</div>
	</div>
	<!-- 메인 끝 -->
	<!-- 푸터 시작 -->
	<c:import url="/layout/footer.jsp"></c:import>
	<!-- 푸터 끝 -->

	<script src="/cakecraft/layout/reservation_assets/js/util.js"></script>
	<script src="/cakecraft/layout/reservation_assets/js/main.js"></script>
</body>

<script>
	//카테고리 변경 시 
	$('#categoryCd').change(function(){
		let categoryCd = $('#categoryCd').val();
		$('#facilityNo *').remove();
		$('#facilityNo').append('<option value="" selected disabled>==선택==</option>');
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/facilityListByCate',
			type : 'post',
			data : {categoryCd : categoryCd},
			success : function(list){
				console.log('ajax성공');
				list.forEach(function(item, index){
					$('#facilityNo').append('<option value="' + item.facilityNo + '">'+ item.facilityName +'</option>');
				})
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	})
	
	//날짜 선택 시 해당 날짜 캘린더로 이동
	$('#selectDate').change(function(){
		let targetDay = $('#selectDate').val();
		console.log(targetDay);
		let targetYear = targetDay.substring(0,4);
		let targetMonth = parseInt(targetDay.substring(5,7)) - 1;
		let targetDate = targetDay.substring(8);
		
		window.location.href = '${pageContext.request.contextPath}/reservation/reservation?targetYear='+targetYear+'&targetMonth='+(targetMonth)+'&targetDate='+targetDate;
	})
	
	//예약할 시설비품 선택 시 예약가능 시간 출력
	$('#facilityNo').change(function(){
		$('#times *').remove(); //모든 예약시간 옵션 삭제
		$('#times').append('<option disabled>&darr;&darr;예약가능시간&darr;&darr;</option>');
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
					if(rsrvTime - now > (1000*60*30)){
						$('#times').append('<option value=' + item.substring(0, item.indexOf(":")) + '>' + item + '</option>');
					}
				})
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	})
	
	//예약 버튼 클릭 시 실행
	function addReservation(){
		console.log('예약버튼 클릭');
		
		if($('#categoryCd').val() === '' 
			|| $('#teamNm').val() === ''
			|| $('#reservationContent').val() === '' 
			|| $('#date').val() === ''){
			swal('입력내용 확인','예약 내용을 입력해주세요','warning');
			return;
		}
		let times = $.trim($('#times option:selected').val());
		if(times == ''){
			swal('입력내용 확인','예약 내용을 입력해주세요','warning');
			return;
		}		
		const addFcltForm = $('#addRsrvForm');
		addFcltForm.attr('action', '${pageContext.request.contextPath}/reservation/addReservation');
		addFcltForm.attr('method', 'post');
		addFcltForm.submit();
	}
</script>
</html>