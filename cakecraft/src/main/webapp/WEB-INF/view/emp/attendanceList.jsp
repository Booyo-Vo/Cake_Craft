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
        <c:forEach var="e" items="${empAttList}">
        	{id: "${e.id}", startDtime: "${e.startDtime}", endDtime: "${e.endDtime}", regDtime: "${e.regDtime}"},
    	</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['사원번호','출근시간','퇴근시간'],
		colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
			{name:'id', index:'id', width:80, align: "center"},
			{name:'startDtime', index:'startDtime', width:80 , align: "center" },
			{name:'endDtime', index:'endDtime', width:80, align: "center"},
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers : false, // 각 행앞에 번호를 표시
		multiselect:false, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수
		sortname: 'name', // 기본정렬열
		sortorder: 'asc', //기본정렬순서
		height: "auto",//표의 높이
	    caption: "출퇴근 이력" // 테이블 캡션 설정
	});
	// 윈도우 크기가 조정 될 때 표의 너비를 조정
	$(window).on('resize.jqGrid', function() { // 윈도우 크기가 조정 될 때 표의 너비를 조정
		$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
	})
	// 전체화 버튼이 클릭될 때 표의 너비를 조정
	$(".jarviswidget-fullscreen-btn").click(function(){ // 전체화 버튼이 클릭될 때 표의 너비를 조정
		setTimeout(function() {
			$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
		}, 100);
	});
	// 데이터셀을 클릭 가능한 링크로 만드는 코드
    $("#searchButton").on("click", function() {
        var data = $("#searchDataInput").val(); // 입력된 검색어를를 가져와 변수저장
        var searchType = $("#searchTypeSelect").val(); // 검색유형을 선택하는 드롭다운을 가져와 변수저장
    });
    
    // 데이터셀을 클릭 가능한 링크로 만드는 코드
    $("#list").on("click", ".jqgrow td[aria-describedby='list_id']", function () {
        var rowId = $(this).closest("tr.jqgrow").attr("id");
        var rowData = $("#list").jqGrid("getRowData", rowId);
        var id = rowData.id;
        window.location.href = "/cakecraft/emp/empById?id=" + id;
    });
    
    // 선택 가능한 열에 밑줄 스타일 추가
    $("#list").on("mouseover", ".jqgrow td[aria-describedby='list_id']", function () {
        $(this).css("text-decoration", "underline");
        $(this).css("cursor", "pointer");
        $(this).css("color", "#007bff");
    }).on("mouseout", ".jqgrow td[aria-describedby='list_id']", function () {
        $(this).css("text-decoration", "none");
        $(this).css("cursor", "default");
        $(this).css("color", ""); // 원래 색상으로 복원
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
					<div class="col-md-6 col-sm-12">
						<div class="title">
							<h4>출퇴근 이력 조회</h4>
						</div>
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">My Attendance list</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			<div class="pd-20 card-box mb-30">
				<div class="clearfix mb-20">
					<!-- 제목 검색 시작 -->
					<div class="pull-left">
						<form action="${pageContext.request.contextPath}/emp/attendanceList" method="get">
							<div class="d-flex">
								<input class="form-control d-inline-block" style="width: 400px;" type="text" name="searchWord" placeholder="날짜 검색">
								&nbsp;
								<button class="d-inline-block btn-none" type="submit">
									<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
								</button>
							</div>
						</form>
					</div>
					<!-- 제목 검색 끝 -->
				</div>
				<!-- 리스트 목록 -->
				<table id="list"></table>
				<!-- 페이징 -->
				<div id="pager"></div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/layout/footer.jsp"></jsp:include>	
</body>
</html>