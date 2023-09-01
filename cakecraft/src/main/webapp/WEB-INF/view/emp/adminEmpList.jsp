<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
jQuery.noConflict(); 
jQuery(document).ready(function($) {
		
	var mydata = [ //데이터
		<c:forEach var="e" items="${adminEmpList}">
			{name: "${e.empName}", id: "${e.id}", deptNm: "${e.deptNm}", teamNm: "${e.teamNm}", positionNm: "${e.positionNm}", email: "${e.email}", empStatus: "${e.empStatus}", dayoffCnt: "${e.dayoffCnt}"},
		</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['이름','사원번호','부서','팀','직급','이메일','재직상태','연차잔여개수','증명서'],
		colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
			{name:'name', index:'name', width:60, align: "center"},
			{name:'id', index:'id', width:80 , align: "center" },
			{name:'deptNm', index:'deptNm', width:60, align: "center"},
			{name:'teamNm', index:'teamNm', width:60, align: "center"},
			{name:'positionNm', index:'positionNm', width:60, align: "center"},
			{name:'email', index:'email', width:100, align: "center"},
			{name:'empStatus', index:'empStatus', width:60, align: "center"},
			{name:'dayoffCnt', index:'dayoffCnt', width:60, align: "center"},
			{name:'certificate', index:'certificate', width:60, sortable: false, align: "center",
				formatter: function(cellValue, options, rowObject) {
					var empStatus = rowObject.empStatus;
					var certificateText = "";

					if (empStatus === "재직자") {
						certificateText = '<a href="/cakecraft/emp/certificate?id=' + rowObject.id + '">재직증명서</a>';
					} else if (empStatus === "퇴사자") {
						certificateText = '<a href="/cakecraft/emp/certificate?id=' + rowObject.id + '">경력증명서</a>';
					} 
					return certificateText;
				}
			}	
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers : true, // 각 행앞에 번호를 표시
		multiselect:true, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수 
		rowList: [10, 20, 50], // 행수를 선택할 수 있는 옵션 설정
		sortname: 'id', // 기본정렬열
		sortorder: 'asc', //기본정렬순서
		height: "auto",//표의 높이
		search: true, // 검색 대화상자 활성화
		searchtext: "검색:", // 검색 필터 텍스트 설정
		searchtitle: "검색 필터", // 검색 대화상자 제목 설정
		caption: "직원 목록" // 테이블 캡션 설정
	});

	$(window).on('resize.jqGrid', function() { // 윈도우 크기가 조정 될 때 표의 너비를 조정
		$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
	})
	$(".jarviswidget-fullscreen-btn").click(function(){ // 전체화 버튼이 클릭될 때 표의 너비를 조정
		setTimeout(function() {
			$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
		}, 100);
	});
	$("#searchButton").on("click", function() {
		var data = $("#searchDataInput").val(); // 입력된 검색어를를 가져와 변수저장
		var searchType = $("#searchTypeSelect").val(); // 검색유형을 선택하는 드롭다운을 가져와 변수저장

		// jqGrid의 필터 설정을 업데이트
		$("#list").jqGrid("setGridParam", {
			postData: { filters: JSON.stringify({
				groupOp: "OR", // 여러 조건 중 하나라도 만족하면 검색 결과로 표시
				rules: [
					{ field: searchType, op: "cn", data: data } // 검색 유형과 검색어 설정 (field:검색유형, cn은 부분일치, data는 검색한 변수)
				]
			})},
				search: true // 필터링을 통한 검색 활성화
		}).trigger("reloadGrid"); // jqGrid 재로딩
	});
	
	// 데이터셀을 클릭 가능한 링크로 만드는 코드 (이름 또는 아이디를 눌러 상세정보로)
	$("#list").on("click", ".jqgrow td[aria-describedby='list_name'], .jqgrow td[aria-describedby='list_id']", function () {
		var rowId = $(this).closest("tr.jqgrow").attr("id");
		var rowData = $("#list").jqGrid("getRowData", rowId);
		var id = rowData.id;
		window.location.href = "/cakecraft/emp/adminEmpById?id=" + id;
	});

	// 데이터셀을 클릭 가능한 링크로 만드는 코드 (연차갯수를 눌러 연차 정보로 이동)
	$("#list").on("click", ".jqgrow td[aria-describedby='list_dayoffCnt']", function () {
		var rowId = $(this).closest("tr.jqgrow").attr("id");
		var rowData = $("#list").jqGrid("getRowData", rowId);
		var id = rowData.id;
		window.location.href = "/cakecraft/emp/dayoffById?id=" + id;
	});
	
	// 선택 가능한 열에 밑줄 스타일 추가
	$("#list").on("mouseover mouseout", ".jqgrow td[aria-describedby='list_id'], .jqgrow td[aria-describedby='list_dayoffCnt'], .jqgrow td[aria-describedby='list_name'], .jqgrow td[aria-describedby='list_certificate']", function (event) {
		if (event.type === "mouseover") {
		$(this).css("text-decoration", "underline");
			$(this).css("cursor", "pointer");
			$(this).css("color", "#007bff");
		} else if (event.type === "mouseout") {
			$(this).css("text-decoration", "none");
			$(this).css("cursor", "default");
			$(this).css("color", ""); // 원래 색상으로 복원
		}
	});
	//체크 박스 선택후 선택된 사원 다운로드를 눌렀을때
	$("#submitIdButton").on("click", function() {
		console.log("Submit button clicked"); // 디버그용 로그 메시지
		
	    var selectedRows = $("#list").jqGrid("getGridParam", "selarrrow"); // 선택된 행의 아이디 목록을 가져옴
	    
	    if (selectedRows.length > 0) { // 선택된 행이 있는 경우에만 실행
	        var selectedIds = [];
	        
	        for (var i = 0; i < selectedRows.length; i++) {
	            var rowData = $("#list").jqGrid("getRowData", selectedRows[i]);
	            selectedIds.push(rowData.id); // 선택된 행의 아이디를 배열에 추가
	        }
	        
	        // 선택된 아이디 목록을 서버로 보내어 엑셀 다운로드 요청
	        var selectedIdsStr = selectedIds.join(","); // 선택된 아이디 배열을 문자열로 변환
	        window.location.href = "/cakecraft/emp/getSelectExcel?ids=" + selectedIdsStr; // 서버 URL을 요청하여 다운로드
	    } else {
	        swal('실패','선택된 사원이 없습니다.','warning');
	    }
	});
	
});
</script>
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
							<h4>사원리스트</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">사원리스트</li>
							</ol>
							<!-- 사원추가-->
							<div class="d-flex justify-content-end mb-3">
								<a href="/cakecraft/emp/addEmp" class="btn btn-primary">사원추가</a>
							</div>
						</nav>
					</div>
				</div>
			</div>
			<div class="pd-20 card-box mb-30">
				<br>
				<div class="form-group row">
					<div class="col-sm-4 col-md-2">
						<select class="custom-select form-control" id="searchTypeSelect">
							<option value="" selected>-- 선택하세요 --</option>
							<option value="name">이름</option>
							<option value="deptNm">부서</option>
							<option value="teamNm">팀</option>
						</select>
					</div>
					<div class="col-sm-4 col-md-8">
						<input type="text" id="searchDataInput" class="form-control">
					</div>
					<div class="col-sm-4 col-md-2">
						<button class="btn btn-info btn-fill" id="searchButton" value="검색">검색</button>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-12 col-md-12">
						<!-- jqgird list -->
						<table id="list"></table>
						<div id="pager"></div>
					</div>
				</div>
				<a href="/cakecraft/emp/getExcel" class="btn btn-primary">사원전체정보 다운로드 <i class="icon-copy fi-download"></i></a>
				<button id="submitIdButton"  class="btn btn-primary">선택된사원정보 다운로드 <i class="icon-copy fi-download"></i></button>
			</div>
		</div>
	</div>
</div>
<br>
</body>
</html>