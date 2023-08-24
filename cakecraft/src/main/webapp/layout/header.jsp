<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
/* 동그란 이미지 스타일 */
.circular-image {
    display: inline-block;
    overflow: hidden;
    border-radius: 50%; /* 이미지를 동그랗게 만듭니다 */
    width: 100px; /* 이미지의 가로 크기를 조절해주세요 */
    height: 100px; /* 이미지의 세로 크기를 조절해주세요 */
    background-color: #ccc; /* 이미지 로딩 중 및 오류 시 보여질 배경 색상 설정 */
}

.circular-image img {
    display: block;
    max-width: 100%;
    height: auto;
}
/* 메뉴 아이템 가운데 정렬 스타일 */
.menu-item {
    display: flex;
    justify-content: center; /* 가로 가운데 정렬 */
    align-items: center; /* 세로 가운데 정렬 */
    margin-bottom: 10px; /* 아이템 간격 설정 */
}
</style>

<script>
	//로그아웃 버튼 클릭시
	function logout() {
		if (localStorage.getItem('rememberedId') !== null) { //로컬스토리지에 rememberedId 값이 있다면
			/* localStorage.removeItem('rememberedId'); */
			localStorage.removeItem('lastLoginTime'); //마지막 로그인 시간 삭제(자동로그인 방지)
			
			//로그아웃 요청 보내기
			fetch('/cakecraft/logout', {
				method: 'GET',
				credentials: 'same-origin' //동일한 출처에서 요청 보내도록 설정
			}).then(response => {
				//로그아웃 성공시
				if (response.ok) {
					alert('로그아웃 완료');
					location.reload(); // // 페이지 새로고침하여 로그아웃 적용
				} else {
					// 로그아웃 실패 시
					alert('로그아웃 실패');
				}
			});
		} else {
			// 로그인 상태가 아닌 경우
			alert('로그인하세요!');
		}
	}
</script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	<script>
	jQuery.noConflict(); 
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());

		gtag('config', 'UA-119386393-1');
	</script>
<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
		</div>
		<div class="header-right">
			<div class="dashboard-setting user-notification">
				<div class="dropdown">
					<a class="dropdown-toggle no-arrow" href="javascript:;" data-toggle="right-sidebar">
						<i class="dw dw-settings2"></i>
					</a>
				</div>
			</div>
		<!-- 오른쪽 상단바 프로필 -->
			<div class="user-info-dropdown">
			    <div class="dropdown">
			        <a class="dropdown-toggle" href="/cakecraft/emp/myPage" role="button">
			           <span class="user-icon">
				            <c:if test="${not empty empBase.profileFilename}">
							    <img src="${pageContext.request.contextPath}/profileImg/${empBase.profileFilename}" alt="employee image" style="width: 200px; height: 200px;">
							</c:if>
							<c:if test="${empty empBase.profileFilename}">
							    <img src="${pageContext.request.contextPath}/profileImg/profile.png" alt="default profile image">
							</c:if>
						</span>
					<span class="user-name" data-empid="${loginId}">${loginId} 님 환영합니다! &nbsp;
						<button type="button" onclick="logout()" class="btn btn-primary" >로그아웃</button>
					</span>
				</a>
			</div>
			</div>
			<div class="github-link">
				<a href="https://github.com/dropways/deskapp" target="_blank"><img src="../vendors/images/github.svg" alt=""></a>
			</div>
		</div>
	</div>

	<div class="right-sidebar">
		<div class="sidebar-title">
			<h3 class="weight-600 font-16 text-blue">
				Layout Settings
				<span class="btn-block font-weight-400 font-12">User Interface Settings</span>
			</h3>
			<div class="close-sidebar" data-toggle="right-sidebar-close">
				<i class="icon-copy ion-close-round"></i>
			</div>
		</div>
		<div class="right-sidebar-body customscroll">
			<div class="right-sidebar-body-content">
				<h4 class="weight-600 font-18 pb-10">Header Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary header-white active">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary header-dark">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-light ">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-dark active">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
				<div class="sidebar-radio-group pb-10 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-1" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-1" checked="">
						<label class="custom-control-label" for="sidebaricon-1"><i class="fa fa-angle-down"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-2" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-2">
						<label class="custom-control-label" for="sidebaricon-2"><i class="ion-plus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-3" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-3">
						<label class="custom-control-label" for="sidebaricon-3"><i class="fa fa-angle-double-right"></i></label>
					</div>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
				<div class="sidebar-radio-group pb-30 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-1" name="menu-list-icon" class="custom-control-input" value="icon-list-style-1" checked="">
						<label class="custom-control-label" for="sidebariconlist-1"><i class="ion-minus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-2" name="menu-list-icon" class="custom-control-input" value="icon-list-style-2">
						<label class="custom-control-label" for="sidebariconlist-2"><i class="fa fa-circle-o" aria-hidden="true"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-3" name="menu-list-icon" class="custom-control-input" value="icon-list-style-3">
						<label class="custom-control-label" for="sidebariconlist-3"><i class="dw dw-check"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-4" name="menu-list-icon" class="custom-control-input" value="icon-list-style-4" checked="">
						<label class="custom-control-label" for="sidebariconlist-4"><i class="icon-copy dw dw-next-2"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-5" name="menu-list-icon" class="custom-control-input" value="icon-list-style-5">
						<label class="custom-control-label" for="sidebariconlist-5"><i class="dw dw-fast-forward-1"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-6" name="menu-list-icon" class="custom-control-input" value="icon-list-style-6">
						<label class="custom-control-label" for="sidebariconlist-6"><i class="dw dw-next"></i></label>
					</div>
				</div>

				<div class="reset-options pt-30 text-center">
					<button class="btn btn-danger" id="reset-settings">Reset Settings</button>
				</div>
			</div>
		</div>
	</div>

	<div class="left-side-bar">
		<div class="brand-logo">
		<!-- 왼쪽 사이드 로고이미지 -->
			<a href="/cakecraft/schedule/schedule">
				<img src="../vendors/images/deskapp-logo.svg" alt="" class="dark-logo">
				<img src="../vendors/images/deskapp-logo-white.jpg" alt="" class="light-logo">
			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
		</div>
		<div class="menu-block customscroll">
			<div class="sidebar-menu">
			<!-- 사이드바 프로필이미지 -->
				<ul id="accordion-menu">
			<!-- 출/퇴근 버튼 -->
					<div class="menu-item">
						<button id="startWorkBtn" class="btn btn-primary" disabled>출근</button>
						&nbsp;
						<button id="endWorkBtn" class="btn btn-danger" disabled>퇴근</button>
					</div>
			<!-- 메인메뉴 드롭다운 -->		
					<li>
						<a href="/cakecraft/schedule/schedule" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-calendar1"></span><span class="mtext">일정</span>
						</a>
					</li>
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-house-1"></span><span class="mtext">전자결재</span>
						</a>
						<ul class="submenu">
							<li><a href="/cakecraft/approval/apprDocListById">approvalDocumentListById</a></li>
							<li><a href="/cakecraft/approval/apprDocListByApprId">approvalDocumentListByApprId</a></li>
							<li><a href="/cakecraft/approval/apprDocListByRefId">approvalDocumentListByRefId</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-edit2"></span><span class="mtext">시설예약</span>
						</a>
						<ul class="submenu">
							<li><a href="/cakecraft/facility/facilityList">시설비품관리</a></li>
							<li><a href="/cakecraft/reservation/reservation">시설비품예약</a></li>
							<li><a href="/cakecraft/reservation/reservationListById">나의예약이력</a></li>
						</ul>
					</li>
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
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-analytics-21"></span><span class="mtext">관리자메뉴</span>
						</a>
						<ul class="submenu">
							<li><a href="/cakecraft/emp/addEmp">사원추가</a></li>
							<li><a href="/cakecraft/emp/adminEmpList">사원관리</a></li>
							<li><a href="/cakecraft/stStdCd/stStdCdList">부서/팀관리</a></li>
							<li><a href="/cakecraft/emp/chartList">차트</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- js -->
	<script src="../vendors/scripts/core.js"></script>
	<script src="../vendors/scripts/script.min.js"></script>
	<script src="../vendors/scripts/process.js"></script>
	<script src="../vendors/scripts/layout-settings.js"></script>

	<script>
	  // 사용자의 위치 정보 가져오기
	 navigator.geolocation.getCurrentPosition(
		//jQuery.noConflict();
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
			latitude: 37.4730836,
			longitude: 126.8788276 // 사용자의 실제 위치 정보 기입
		};

			// 출근 버튼을 활성화할 위치 범위
			const startWorkLocation = {
			latitude: 37.4730836,
			longitude: 126.8788276
		};
		// 출퇴근 버튼 활성화 여부 결정에 사용할 거리 임계값(범위)
		const thresholdDistance = 1; // 단위: km

		// 퇴근 버튼을 활성화할 위치 범위
		const endWorkLocation = {
			latitude: 37.4730836, // 퇴근 버튼 활성화 위도
			longitude: 126.8788276 // 퇴근 버튼 활성화 경도
		};

		// 출근 버튼 활성화 여부 결정
		const startWorkBtn = document.getElementById("startWorkBtn");
		if (calculateDistance(userLocation, startWorkLocation) <= thresholdDistance) {
		  startWorkBtn.disabled = false;
		} else {
		  startWorkBtn.disabled = true;
		}
		
		// 퇴근 버튼 활성화 여부 결정
		const endWorkBtn = document.getElementById("endWorkBtn");
		if (!startWorkBtn.disabled && calculateDistance(userLocation, endWorkLocation) <= thresholdDistance) {
			endWorkBtn.disabled = false;
		} else {
			endWorkBtn.disabled = true;
		}

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
		document.addEventListener("DOMContentLoaded", function () {
			// 출근 버튼과 퇴근 버튼 가져오기
			const startWorkBtn = document.getElementById("startWorkBtn");
			const endWorkBtn = document.getElementById("endWorkBtn");
			
			// 근무 기록을 저장하는 함수
			function saveWorkHistory(history) {
				const workHistory = JSON.parse(localStorage.getItem('workHistory')) || [];
					workHistory.push(history);
					localStorage.setItem('workHistory', JSON.stringify(workHistory));
	    	}	
	    
	 	// 출근 버튼 클릭 이벤트 처리
		startWorkBtn.addEventListener("click", () => {
			const currentTime = new Date().toISOString();
			const startWorkHistory = {
				type: "출근",
				time: currentTime
		    };
			saveWorkHistory(startWorkHistory);
			startWorkBtn.disabled = true;
			endWorkBtn.disabled = false;
	    });

	    // 퇴근 버튼 클릭 이벤트 처리
		endWorkBtn.addEventListener("click", () => {
			const currentTime = new Date().toISOString();
			const endWorkHistory = {
				type: "퇴근",
				time: currentTime
	        };
			saveWorkHistory(endWorkHistory);
			endWorkBtn.disabled = true;
			startWorkBtn.disabled = false;
	    });
	 });
 	
    </script>
