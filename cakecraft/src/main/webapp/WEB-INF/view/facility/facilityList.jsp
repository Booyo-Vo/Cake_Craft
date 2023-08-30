<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
<script>
jQuery.noConflict();
jQuery(document).ready(function($){
	let mydata = [ //데이터
        <c:forEach var="r" items="${resultList}">
        	{facilityNo: "${r.facilityNo}", categoryCd: "${r.categoryCd}", facilityName: "${r.facilityName}", facilityNote: "${r.facilityNote}", useYn: "${r.useYn}"},
    	</c:forEach>
	];

	$("#table").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['관리번호','카테고리','시설/비품이름','설명','사용여부'],
		colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
			{name:'facilityNo', index:'facilityNo', width:20, align: "center", sortable: false},
			{name:'categoryCd', index:'categoryCd', width:70, align: "center", sortable: false},
			{name:'facilityName', index:'facilityName', width:70 , align: "center", sortable: false},
			{name:'facilityNote', index:'facilityNote', width:70, align: "center", sortable: false},
			{name:'useYn', index:'useYn', width:70, align: "center", sortable: false},
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers: true, // 각 행앞에 번호를 표시
		multiselect: false, // 다중선택 활성화
		pager:'#pager',
		rowNum: 20, // 표시할 행의 수 
		rowList: [10, 20, 50], // 행수를 선택할 수 있는 옵션 설정
		sortname: 'categoryCd', // 기본정렬열
		sortorder: 'desc', //기본정렬순서
		height: "auto",//표의 높이
		search: false, // 검색 대화상자 활성화
	    //searchtext: "검색:", // 검색 필터 텍스트 설정
	    //searchtitle: "검색 필터", // 검색 대화상자 제목 설정
	    caption: "시설비품관리" // 테이블 캡션 설정
	});
	
	$(window).on('resize.jqGrid', function() { // 윈도우 크기가 조정 될 때 표의 너비를 조정
		$("#table").jqGrid('setGridWidth', $("#table").parent().parent().parent().parent().parent().width());
	})
	$(".jarviswidget-fullscreen-btn").click(function(){ // 전체화 버튼이 클릭될 때 표의 너비를 조정
		setTimeout(function() {
			$("#table").jqGrid('setGridWidth', $("#table").parent().parent().parent().parent().parent().width());
		}, 100);
	});
	
	//시설비품 클릭 시 상세보기 및 수정 모달 띄우기
	function showModModal(facilityNo){
		console.log(facilityNo);
		
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/modifyFacility',
			type : 'post',
			data : {facilityNo : facilityNo},
			success : function(facility){
				console.log('ajax성공');
				$('#modFacilityNo').val(facility.facilityNo);
				$('#modCategory').val(facility.categoryCd);
				$('#modCategoryCd').val(facility.cdNm);
				$('#modFacilityName').val(facility.facilityName);
				$('#modFacilityNote').val(facility.facilityNote);
				$('#modCount').text(facility.facilityNote.length);
				$('#modUseYn').val(facility.useYn);
			},
			error : function(){
				console.log('ajax실패');
			}
		})
		$('#modFcltModal').modal('show');
	}

	// 데이터셀을 클릭 가능한 링크로 만드는 코드
	$("#table").on("click", ".jqgrow td[aria-describedby='table_facilityName']", function () {
		var rowId = $(this).closest("tr.jqgrow").attr("id");
		var rowData = $("#table").jqGrid("getRowData", rowId);
		var facilityNo = rowData.facilityNo;
		showModModal(facilityNo);
	});

	// 선택 가능한 열에 밑줄 스타일 추가
	$("#table").on("mouseover", ".jqgrow td[aria-describedby='table_facilityName']", function () {
		$(this).css("text-decoration", "underline");
		$(this).css("cursor", "pointer");
		$(this).css("color", "#007bff");
	}).on("mouseout", ".jqgrow td[aria-describedby='table_facilityName']", function () {
		$(this).css("text-decoration", "none");
		$(this).css("cursor", "default");
		$(this).css("color", ""); // 원래 색상으로 복원
	});
	
	//시설/비품 카테고리별 상세 리스트 출력
	$('#category').change(function(){
		let category = $('#category').val();
		let cd = '';
		if(category == 'F'){
			cd = '1%';
		} else if (category == 'S'){
			cd = '2%';
		} else {
			$('#categoryCd *').remove();
			$('#categoryCd').append('<option value="" selected disabled>==선택==</option>');
			$('#categoryCd').append('<option value="A" selected>전체</option>');
		}
		if(category != 'A'){
			$('#categoryCd *').remove();
			$('#categoryCd').append('<option value="" selected disabled>==선택==</option>');
			$.ajax({
				url : '${pageContext.request.contextPath}/rest/listBySearch',
				type : 'post',
				data : {cd : cd },
				success : function(list){
					console.log('ajax성공');
					console.log(list);
					list.forEach(function(item, index){
						$('#categoryCd').append('<option value="' +item.cd+ '">' + item.cdNm + '</option>');
					})
				},
				error : function(){
					console.log('ajax실패');
				}
			})
		}
	})
	
	//현재 검색조건 selected처리
	function searchSelected(){
		let categoryCd = '<c:out value="${categoryCd}" />';
		let useYn = '<c:out value="${useYn}" />';
		console.log(categoryCd);
		console.log(useYn);
		
		if(categoryCd == 'A'){
			$('#category').val('A').prop('selected', true);
			$('#categoryCd').val('A').prop('selected', true);
		} else if(categoryCd.startWith('1')){
			$('#category').val('F').prop('selected', true);
			$('#categoryCd').val(categoryCd).prop('selected', true);
		} else if(categoryCd.startWith('2')){
			$('#category').val('S').prop('selected', true);
			$('#categoryCd').val(categoryCd).prop('selected', true);
		}
		
		$('#useYn').val(useYn).prop('selected', true);
	}
	
	
	//추가폼 유효성 검사(이름 공백금지/중복검사, 모든 입력폼 필수입력)
	// 이름 유효성검사
	$('#addFacilityName').val('');
	$('#addFacilityNote').val('');
	
	//시설/비품 카테고리별 상세 리스트 출력
	$('#addCategory').change(function(){
		let addCategory = $('#addCategory').val();
		let cd = '';
		if(addCategory == 'F'){
			cd = '1%';
		} else if (addCategory == 'S'){
			cd = '2%';
		}
		$('#addCategoryCd *').remove();
		$('#addCategoryCd').append('<option value="" selected disabled>==선택==</option>');
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/listBySearch',
			type : 'post',
			data : {cd : cd },
			success : function(list){
				console.log('ajax성공');
				console.log(list);
				list.forEach(function(item, index){
					$('#addCategoryCd').append('<option value="' +item.cd+ '">' + item.cdNm + '</option>');
				})
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	})
	$('#addFacilityName').blur(function() {
		console.log($('#addFacilityName').val()); 
		$('#addFacilityName').val($('#addFacilityName').val().replace(/ /g,'')); //모든 공백제거
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/nameCheck',
			type : 'post',
			data : {
				facilityName : $('#addFacilityName').val()
			},
			success : function(param){
				if(param > 0){
					$('#addNameMsg').text('이미 사용 중인 이름입니다');
					$('#addFacilityName').focus();
				}
			}
		})
		$('#addNameMsg').text('');
		$('#addFacilityNote').focus();
	});
	
	//설명 유효성검사
	$('#addFacilityNote').keyup(function(){
		const MAX_COUNT = 100;
		let len = $('#addFacilityNote').val().length;
		if(len > MAX_COUNT) {
			let str = $('#addFacilityNote').val().substring(0, MAX_COUNT);
			$('#addFacilityNote').val(str);
			$('#addNoteMsg').text(MAX_COUNT +'자 이하로 입력해주세요');
		} else {
			$('#addCount').text(len);
		}
	})
	
	
	//검색조건에 따라 선택박스 selected옵션 추가
	let categoryCd = '<c:out value="${categoryCd}"/>';
	let useYn = '<c:out value="${useYn}"/>';
	//시설/비품 검색
	if(categoryCd.startsWith('1')){ //시설인 경우
		$('#category').val('F').prop('selected', true);
		$('#categoryCd').val(categoryCd).prop('selected', true);
	} else if (categoryCd.startsWith('2')){ //비품인 경우
		$('#category').val('S').prop('selected', true);
		$('#categoryCd').val(categoryCd).prop('selected', true);
	} else if (categoryCd === 'A'){ //전체인 경우
		$('#category').val('A').prop('selected', true);
		$('#categoryCd').val('A').prop('selected', true);
	}
	//사용여부 검색
	$('#useYn').val(useYn).prop('selected', true);

})

//추가 버튼 클릭 시 폼 제출
function addFacility(){
	console.log('추가버튼 클릭');
	
	if($('#addCategory').val() === '' 
			|| $('#addCategoryCd').val() === ''
			|| $('#addFacility').val() === '' 
			|| $('#addFacilityNote').val() === ''
			|| $('#useYn').val() === ''){
		alert('입력창을 채워주세요');
		return;
	}
	
	const addFcltForm = $('#addFcltForm');
	addFcltForm.attr('action', '${pageContext.request.contextPath}/facility/addFacility');
	addFcltForm.attr('method', 'post');
	addFcltForm.submit();
}

//수정폼 유효성 검사(이름 공백금지/중복검사, 모든 입력폼 필수입력)
//이름 유효성검사
function handleNameBlur() {
	console.log($('#modFacilityName').val()); 
	$('#modFacilityName').val($('#modFacilityName').val().replace(/ /g,'')); //모든 공백제거
	$.ajax({
		url : '${pageContext.request.contextPath}/rest/nameCheck',
		type : 'post',
		data : {
			facilityName : $('#modFacilityName').val(),
			facilityNo: $('#modFacilityNo').val()
		},
		success : function(param){
			if(param > 0){
				$('#modNameMsg').text('이미 사용 중인 이름입니다');
				$('#modFacilityName').focus();
			}
		}
	})
	$('#modNameMsg').text('');
	$('#modFacilityNote').focus();
};
  
//설명 유효성검사
function handleNoteKeyUp(){
	const MAX_COUNT = 100;
	let len = $('#modFacilityNote').val().length;
	if(len > MAX_COUNT) {
		let str = $('#modFacilityNote').val().substring(0, MAX_COUNT);
		$('#modFacilityNote').val(str);
		$('#modNoteMsg').text(MAX_COUNT +'자 이하로 입력해주세요');
	} else {
		$('#modCount').text(len);
	}
}

//수정 시 사용여부 유효성 검사
function handleUseYnChange(){
	let facilityNo = $('#modFacilityNo').val();
	let useYn = $('#modUseYn').val();
	
	if(useYn == 'N'){ //사용여부를 Y->N으로 바꾸는 경우
		$.ajax({
			url : '${pageContext.request.contextPath}/rest/getReservationCnt',
			type : 'post',
			data : {facilityNo : facilityNo},
			success : function(cnt){
				console.log(cnt + '<-- cnt ajax성공');
				if(cnt > 0){
					swal('변경 불가', '사용이 예약된 시설비품입니다.', 'warning');
					$('#modUseYn').val('Y').prop('selected', true);
				} else {
					swal('변경 가능', '사용여부가 변경되었습니다.', 'info');
					$('#modUseYn').val('N').prop('selected', true);
				}
			},
			error : function(){
				console.log('ajax실패');
			}
		})
	}
}

//수정버튼 클릭 시 폼 제출
function modFacility(){
	console.log('수정버튼 클릭');
	
	if($('#modCategoryCd').val() === ''
		|| $('#modFacility').val() === '' 
		|| $('#modFacilityNote').val() === ''
		|| $('#modUseYn').val() === ''){
		alert('입력창을 채워주세요');
		return;
	}
	
	const modFcltForm = $('#modFcltForm');
	modFcltForm.attr('action', '${pageContext.request.contextPath}/facility/modifyFacility');
	modFcltForm.attr('method', 'post');
	modFcltForm.submit();
}
</script>
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
								<h4>시설비품관리</h4>
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
				<!-- 검색 시작 -->

					<form action="${pageContext.request.contextPath}/facility/facilityList" method="get">
						<div class="row mt-3 mb-3">
							<div class="col-2">
								<label for="category">분류</label>
							</div>
							<div class="col-3">
								<select id="category" class="form-control" required>
									<option value="" selected disabled>==선택==</option>
									<option value="A">전체</option>
									<option value="F">시설</option>
									<option value="S">비품</option>
								</select>
							</div>
							<div class="col-3">
								<select id="categoryCd" class="form-control" name="categoryCd" required>
									<option value="" selected disabled>==선택==</option>
									<option value="A">전체</option>
									<c:forEach var="t" items="${categoryCdList}">
										<option value="${t.cd}">${t.cdNm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-2">
								<label for="useYn">사용여부</label>
							</div>
							<div class="col-3">
								<select id="useYn" class="form-control" name="useYn" required>
									<option value="" selected disabled>==선택==</option>
									<option value="A">전체</option>
									<option value="Y">사용가능</option>
									<option value="N">사용불가</option>
								</select>
							</div>
							<div class="col-3">
								<button type="submit" class="btn btn-primary">검색</button>
							</div>
						</div>
					</form>
					<!-- 검색 끝 -->
				</div>
				
				<div class="pd-20 card-box mb-30">
					<div class="mb-3">
						<button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#addFcltModal">시설비품추가</button>
						<a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/facility/categoryList">카테고리 관리</a>
					</div>
					
					<!-- jqgrid시작 -->
					<div><table id="table"></table></div>
					<div id="pager"></div>
					<!-- jqgrid끝 -->
					
					<!-- 시설비품 추가 모달창 시작 -->
					<div class="modal fade" id="addFcltModal" tabindex="-1" aria-labelledby="addFcltModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="addFcltModalLabel">시설비품추가</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form id="addFcltForm">
										<input type="hidden" name="loginId" value="${loginId}">
										<div class="mb-3">
											<label for="addCategory" class="col-form-label">카테고리</label>
											<select id="addCategory" required>
												<option value="" selected disabled>==선택==</option>
												<option value="F">시설</option>
												<option value="S">비품</option>
											</select>
											<select id="addCategoryCd" name="categoryCd" required>
												<option value="" selected disabled>==선택==</option>
											</select>
										</div>
										<div class="mb-3">
											<label for="addFacilityName" class="col-form-label">이름</label>
											<input type="text" class="form-control" name="facilityName" id="addFacilityName" required>
											<span id="addNameMsg"></span>
										</div>
										<div class="mb-3">
											<label for="addFacilityNote" class="col-form-label">설명</label>
											<textarea class="form-control" name="facilityNote" id="addFacilityNote" required></textarea>
											<span id="addCount">0</span>자 / 100자
											<span id="addNoteMsg"></span>
										</div>
										<div class="mb-3">
											<label for="addUseYn" class="col-form-label">사용여부</label>
											<select name="useYn" id="addUseYn" required>
												<option value="Y" selected>사용가능</option>
												<option value="N">사용불가</option>
											</select>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary" id="addFcltBtn" onclick="addFacility()" >추가</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 시설비품 추가 모달창 끝 -->
					
					<!-- 시설비품 수정 모달창 시작 -->
					<div class="modal fade" id="modFcltModal" tabindex="-1" aria-labelledby="modFcltModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modFcltModalLabel">시설비품수정</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form id="modFcltForm">
										<input type="hidden" name="facilityNo" id="modFacilityNo">
										<input type="hidden" name="loginId" value="${loginId}">
										<input type="hidden" name="categoryCd" id="modCategory" value="">
										<div class="mb-3">
											<label for="modCategoryCd" class="col-form-label">카테고리</label>
											<input type="text" class="form-control" id="modCategoryCd" readonly>
										</div>
										<div class="mb-3">
											<label for="modFacilityName" class="col-form-label">이름</label>
											<input type="text" class="form-control" name="facilityName" id="modFacilityName" onblur="handleNameBlur()" required>
											<span id="modNameMsg"></span>
										</div>
										<div class="mb-3">
											<label for="modFacilityNote" class="col-form-label">설명</label>
											<textarea class="form-control" name="facilityNote" id="modFacilityNote" onkeyup="handleNoteKeyUp()" required></textarea>
											<span id="modCount">0</span>자 / 100자
											<span id="modNoteMsg"></span>
										</div>
										<div class="mb-3">
											<label for="modUseYn" class="col-form-label">사용여부</label>
											<select name="useYn" id="modUseYn" onchange="handleUseYnChange()">
												<option value="Y">사용가능</option>
												<option value="N">사용불가</option>
											</select>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary" id="modFcltBtn" onclick="modFacility()">수정</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 시설비품 수정 모달창 끝 -->
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
</body>
</html>