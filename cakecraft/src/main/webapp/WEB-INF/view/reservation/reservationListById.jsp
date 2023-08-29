<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
<script>
jQuery.noConflict();
jQuery(document).ready(function($){
	let mydata = [ //데이터
        <c:forEach var="r" items="${list}">
        	{reservationNo: "${r.reservationNo}", facilityName: "${r.facilityName}", reservationContent: "${r.reservationContent}", startDtime: "${fn:substring(r.startDtime, 0, 19)}", endDtime: "${fn:substring(r.endDtime, 0, 19)}"},
    	</c:forEach>
	];

	$("#table").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['예약번호','예약시설/비품','내용','예약시작시간','예약종료시간', '삭제'],
		colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
			{name:'reservationNo', index:'reservationNo', width:20, align: "center", sortable: false},
			{name:'facilityName', index:'facilityName', width:70, align: "center", sortable: false},
			{name:'reservationContent', index:'reservationContent', width:70 , align: "center", sortable: false},
			{name:'startDtime', index:'startDtime', width:70, align: "center", sortable: false},
			{name:'endDtime', index:'endDtime', width:70, align: "center", sortable: false},
			{name:'delBtn', width:70, fixed:true, align: "center", sortable : false, formatter:formatOpt, formatoptions:{keys:true, editbutton:false}},
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers: true, // 각 행앞에 번호를 표시
		multiselect: false, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수 
		rowList: [10, 20, 50], // 행수를 선택할 수 있는 옵션 설정
		sortname: 'startDtime', // 기본정렬열
		sortorder: 'desc', //기본정렬순서
		height: "auto",//표의 높이
		search: false, // 검색 대화상자 활성화
	    //searchtext: "검색:", // 검색 필터 텍스트 설정
	    //searchtitle: "검색 필터", // 검색 대화상자 제목 설정
	    caption: "나의 예약이력" // 테이블 캡션 설정
	});
	
	function formatOpt(cellvalue, options, rowObject){
		let str = "";
		let rowId = options.rowId;
		let startDtime = new Date(rowObject.startDtime);
		let startDtimeMs = startDtime.getTime();
		let currentTime = new Date();
        let nowMs = Date.now();
        if(startDtimeMs - nowMs > 1000*60*30){
			str += '<a id="delBtn' + rowId + '">삭제</a>';
        }
		return str;
	}
	
	$(window).on('resize.jqGrid', function() { // 윈도우 크기가 조정 될 때 표의 너비를 조정
		$("#table").jqGrid('setGridWidth', $("#table").parent().parent().parent().parent().parent().width());
	})
	$(".jarviswidget-fullscreen-btn").click(function(){ // 전체화 버튼이 클릭될 때 표의 너비를 조정
		setTimeout(function() {
			$("#table").jqGrid('setGridWidth', $("#table").parent().parent().parent().parent().parent().width());
		}, 100);
	});
    
	// 삭제버튼 클릭 후 실행함수
	$("a[id^=delBtn]").on("click", function () {
		var rowId = $(this).closest("tr.jqgrow").attr("id");
		var rowData = $("#table").jqGrid("getRowData", rowId);
		var reservationNo = rowData.reservationNo;
		window.location.href = "${pageContext.request.contextPath}/reservation/removeReservation?reservationNo="+reservationNo;
	});
	    
	// 선택 가능한 열에 밑줄 스타일 추가
	$("#table").on("mouseover", "a[id^='delBtn']", function () {
		$(this).css("text-decoration", "underline");
		$(this).css("cursor", "pointer");
		$(this).css("color", "#007bff");
	}).on("mouseout", "a[id^='delBtn']", function () {
		$(this).css("text-decoration", "none");
		$(this).css("cursor", "default");
		$(this).css("color", ""); // 원래 색상으로 복원
	});
})

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
							<h4>예약이력</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">홈</a></li>
								<li class="breadcrumb-item active" aria-current="page">나의 예약이력</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<!-- 페이지 헤더 끝 -->
			
			<div class="pd-20 card-box mb-30">
				<!-- jqgrid 시작 -->
				<table id="table"></table>
				<div id="pager"></div>
				<!-- jqgrid 끝 -->
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