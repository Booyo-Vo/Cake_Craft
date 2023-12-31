<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="header">
	<div class="header-left">
		<div class="menu-icon dw dw-menu"></div>
	</div>
	<div class="header-right">
	<!---------------------- 오른쪽 상단바 프로필 시작 ---------------------------->
		<div class="dashboard-setting user-notification">
			<div class="dropdown">
			</div>
		</div>
<!---------------------- 오른쪽 상단바 프로필 시작 ---------------------------->
		<div class="user-info-dropdown">
			<div class="row dropdown">
				<div class="col">
					<a class="dropdown-toggle" href="/cakecraft/emp/myPage" role="button">
						<span class="user-icon">
						<!-- 세션 값을 사용하여 프로필 이미지 표시 -->
							<c:choose>
							    <c:when test="${profileImagePath == 'default_profile.png'}">
							        <img src="${pageContext.request.contextPath}/profileImg/profile.png">
							    </c:when>
							    <c:otherwise>
							        <img src="${pageContext.request.contextPath}/profileImg/${sessionScope.profileImagePath}" alt="employee image">
							    </c:otherwise>
							</c:choose>
						</span>
						<span class="user-name" data-empid="${loginEmpBase.empName}">${loginEmpBase.empName} 님 환영합니다! &nbsp;
						</span>
					</a>
				</div>
				<div class="col d-flex justify-content-center align-items-center pr-20">
					<button type="button" onclick="logout()" class="btn btn-primary" >로그아웃</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!---------------------- 오른쪽 상단바 프로필 끝  ---------------------------->
<!-----------------------왼쪽 사이드 바 시작 -------------------------------->
<div class="left-side-bar">
	<!------------------------ 로고 이미지 ----------------------->
	<div class="logo-container" style="padding-left: 40px; padding-right: 40px;">
		<img src="${pageContext.request.contextPath}/layout/vendors/images/cakecraft_logo.png" class="light-logo">
	</div>
	<!------------------------ 사이드바 닫기 버튼 ----------------------->
	<div class="close-sidebar" data-toggle="left-sidebar-close">
		<i class="ion-close-round"></i>
	</div>		
	<!------------------------ 출/퇴근 버튼 ----------------------->
	<div class="menu-item">
	    <form id="attendanceForm">
	    <input type="hidden" value="${loginId}" name="id">
	        <button id="startWorkBtn" type="button" class="btn btn-primary">출근</button>
	        &nbsp;
	        <button id="endWorkBtn" type="button" class="btn btn-secondary">퇴근</button>
	    </form>
	</div>
	<div class="menu-block customscroll">
		<div class="sidebar-menu">
			<ul id="accordion-menu">
				<!------------------------- 일정 ------------------------------->
				<li>
					<a href="/cakecraft/schedule/schedule" class="dropdown-toggle no-arrow">
						<span class="micon dw dw-calendar1"></span><span class="mtext">일정</span>
					</a>
				</li>
				<!------------------------- 전자결재 ---------------------------->
				<li class="dropdown">
					<a href="javascript:;" class="dropdown-toggle">
						<span class="micon dw dw-house-1"></span><span class="mtext">전자결재</span>
					</a>
					<ul class="submenu">
						<li><a href="/cakecraft/approval/apprDocWaitListByNo">승인대기문서</a></li>
						<li><a href="/cakecraft/approval/apprDocListByApprId">결재수신문서</a></li>
						<li><a href="/cakecraft/approval/apprDocListByRefId">참조문서</a></li>
						<li><a href="/cakecraft/approval/apprDocListById">기안문서</a></li>
						<li><a href="/cakecraft/approval/apprDocListByIdTempY">임시저장</a></li>
					</ul>
				</li>
				<!--------------------------- 시설예약 --------------------------->
				<li class="dropdown">
					<a href="javascript:;" class="dropdown-toggle">
						<span class="micon dw dw-edit2"></span><span class="mtext">시설예약</span>
					</a>
					<ul class="submenu">
						<!-- 총무팀: 사용자의 deptCd가 "1"이고 teamCd가 "14"인 경우를 확인 -->
						<!-- 특정 deptCd와 teamCd에 대해서만 "시설비품관리"를 표시 -->
						<c:choose>
							<c:when test="${loginEmpBase.deptCd == '1' && loginEmpBase.teamCd == '14'}">
							<!-- Show "시설비품관리" tab only for the specific deptCd and teamCd -->
							<li><a href="/cakecraft/facility/facilityList">시설비품관리</a></li>
						</c:when>
						</c:choose>
							<li><a href="/cakecraft/reservation/reservation">시설비품예약</a></li>
							<li><a href="/cakecraft/reservation/reservationListById">나의예약이력</a></li>
					</ul>
				</li>
				<!----------------------------- 게시판 -------------------------->
				<li class="dropdown">
					<a href="javascript:;" class="dropdown-toggle">
						<span class="micon dw dw-library"></span><span class="mtext">게시판</span>
					</a>
					<ul class="submenu">
						<li><a href="/cakecraft/board/noticeList">공지사항</a></li>
						<li><a href="/cakecraft/board/anonyList">익명게시판</a></li>
						<li><a href="/cakecraft/board/questionList">Q&A</a></li>
					</ul>
				</li>
				<!------------------------- 채팅 ------------------------------->
				<li>
					<a href="/cakecraft/chat/rooms" class="dropdown-toggle no-arrow">
						<span class="micon dw dw-chat3"></span><span class="mtext">채팅</span>
					</a>
				</li>
				<!---------------------------- 관리자 메뉴 -------------------------->
					<!-- 인사팀: 사용자의 deptCd가 "1"이고 teamCd가 "11"인 경우를 확인 -->
					<!-- 특정 deptCd와 teamCd에 대해서만 "관리자메뉴"를 표시 -->
					<c:choose>
						<c:when test="${loginEmpBase.deptCd == '1' && loginEmpBase.teamCd == '11'}">
						<li class="dropdown">
							<a href="javascript:;" class="dropdown-toggle">
								<span class="micon dw dw-analytics-21"></span><span class="mtext">관리자메뉴</span>
							</a>
							<ul class="submenu">
								<li><a href="/cakecraft/emp/adminEmpList">사원관리</a></li>
								<li><a href="/cakecraft/stStdCd/stStdCdList">부서/팀관리</a></li>
								<li><a href="/cakecraft/emp/chartList">차트</a></li>
							</ul>
						</li>
					</c:when>
				</c:choose>
			</ul>
		</div>
	</div>
</div>
<!-----------------------왼쪽 사이드 바 끝 -------------------------------->	

<script>
////////////////////////출퇴근 버튼 시작//////////////////////////
document.addEventListener("DOMContentLoaded", function () {
	const startWorkBtn = document.getElementById("startWorkBtn");
	const endWorkBtn = document.getElementById("endWorkBtn");
	
	// 로컬 스토리지에서 버튼 상태 가져오기
	const startBtnDisabled = localStorage.getItem("startBtnDisabled");
	const endBtnDisabled = localStorage.getItem("endBtnDisabled");
	
	// 버튼 상태 설정
	startWorkBtn.disabled = startBtnDisabled === "true";
	endWorkBtn.disabled = endBtnDisabled === "true";

	// 출근 버튼 클릭 이벤트 처리
	startWorkBtn.addEventListener("click", function() {
		startWorkBtn.disabled = true;
		localStorage.setItem("startBtnDisabled", "true");
		
		const attendanceForm = document.getElementById("attendanceForm");
		attendanceForm.setAttribute("action", '${pageContext.request.contextPath}/emp/start');
		attendanceForm.submit();
	});

	// 퇴근 버튼 클릭 이벤트 처리
	endWorkBtn.addEventListener("click", function() {
		endWorkBtn.disabled = true;
		localStorage.setItem("endBtnDisabled", "true");
		
		const attendanceForm = document.getElementById("attendanceForm");
		attendanceForm.setAttribute("action", '${pageContext.request.contextPath}/emp/end');
		attendanceForm.submit();
		
		// 출근 버튼 활성화
		startWorkBtn.disabled = false;
		localStorage.setItem("startBtnDisabled", "false");
	});

	// 폼을 서버로 제출하는 함수
	function submitForm(action) {
		const form = document.getElementById("attendanceForm");
		form.setAttribute("action", action);
		form.setAttribute("method", "get");
		form.submit();
	}
});
////////////////////////출퇴근 버튼 끝//////////////////////////
////////////////// 사용자의 위치 정보 시작 ///////////////////////
	navigator.geolocation.getCurrentPosition(
		position => {
			// 위치 정보가 성공적으로 가져온 경우
			const latitude = position.coords.latitude;//위도
			const longitude = position.coords.longitude;//경도
			console.log(latitude);
			console.log(longitude);
			// 위도(latitude)와 경도(longitude)를 이용해 위치 정보 활용 가능
			// 이후 출퇴근 버튼 활성화 여부 결정에 사용
		},
		error => {
			// 위치 정보가 성공적으로 가져오는데 실패한 경우
			console.error("위치 정보를 가져오는데 실패했습니다. 위치 제공을 허용해주세요!", error);
		}
	);
	
	// 사용자의 실제 위치 정보
	const userLocation = {
		latitude: 37.476434,
		longitude: 126.879777
	};

	// 출근 버튼을 활성화할 위치 범위
	const startWorkLocation = {
		latitude: 37.476434,
		longitude: 126.879777
	};
	
	// 출퇴근 버튼 활성화 여부 결정에 사용할 거리 임계값(범위)
	const thresholdDistance = 1; // 단위: km

	// 퇴근 버튼을 활성화할 위치 범위
	const endWorkLocation = {
		latitude: 37.476434, // 퇴근 버튼 활성화 위도
		longitude: 126.879777 // 퇴근 버튼 활성화 경도
	};

	// 두 위치 간의 거리 계산 함수
	function calculateDistance(location1, location2) {
		const earthRadius = 6371; // 지구 반지름 (단위: km)
		const dLat = degToRad(location2.latitude - location1.latitude);
		const dLon = degToRad(location2.longitude - location1.longitude);

	  const a =
		Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		Math.cos(degToRad(location1.latitude)) * Math.cos(degToRad(location2.latitude)) *
		Math.sin(dLon / 2) * Math.sin(dLon / 2);

		const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

		const distance = earthRadius * c; // 두 위치 사이의 거리 (단위: km)
		return distance;
	}

	// 각도를 라디안으로 변환하는 함수
	function degToRad(degrees) {
		return degrees * (Math.PI / 180);
	}
//////////////////사용자의 위치 정보 끝 ///////////////////////

///////////////////로그아웃 버튼 시작 //////////////////////
function logout() {
	if (localStorage.getItem('rememberedId') !== null) {
		swal({
			title: '로그아웃 확인',
			text: '정말로 로그아웃하시겠습니까?',
			icon: 'question',
			confirmButtonText: '로그아웃',
			cancelButtonText: '취소',
			showCancelButton: true,
			}).then((result) => {
			console.log(result);
		    if (result.value == true) {
				window.location.href = "${pageContext.request.contextPath}/logout";
		    	}
		 	 });
			} else {
		swal('로그인하세요!', '', 'info');
	}
}

///////////////////로그아웃 버튼 끝 //////////////////////
/////////////////// Google Analytics //////////////////////
	jQuery.noConflict(); 
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());

	gtag('config', 'UA-119386393-1');
	
</script>