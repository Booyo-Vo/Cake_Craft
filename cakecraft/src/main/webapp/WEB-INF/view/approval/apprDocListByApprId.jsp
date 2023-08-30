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
        <c:forEach var="ada" items="${apprDocListByApprId}">
        	{no: "${ada.documentNo}", cd: "${ada.approvalDocumentCd}", title: "${ada.documentTitle}", modDtime: "${ada.modDtime}"},
    	</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['문서번호','문서형식','제목','기안일자'],
		colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
			{name:'no', index:'no', width:50, align: "center"},
			{name:'cd', index:'cd', width:50 , align: "center" },
			{name:'title', index:'title', width:50, align: "center"},
			{name:'modDtime', index:'modDtime', width:50, align: "center"},

		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers : true, // 각 행앞에 번호를 표시
		multiselect:true, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수 
		rowList: [10, 20, 50], // 행수를 선택할 수 있는 옵션 설정
		sortname: 'modDtime', // 기본정렬열
		sortorder: 'desc', //기본정렬순서
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
    
 	// 데이터셀을 클릭 가능한 링크로 만드는 코드 (문서번호를 눌러 상세정보로)
    $("#list").on("click", ".jqgrow td[aria-describedby='list_no']", function () {
        var rowId = $(this).closest("tr.jqgrow").attr("id");
        var rowData = $("#list").jqGrid("getRowData", rowId);
        var no = rowData.no;
        window.location.href = "/cakecraft/approval/apprDocByNo?documentNo=" + no;
    });
    
 	// 선택 가능한 열에 밑줄 스타일 추가
    $("#list").on("mouseover mouseout", ".jqgrow td[aria-describedby='list_no']", function (event) {
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
							<h4>결재수신문서</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">결재수신문서</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<div class="pd-20 card-box mb-30">
				<div class="form-group row">
					<div class="col-sm-4 col-md-2">
						<select class="custom-select form-control" id="searchTypeSelect">
							<option value="All" selected>전체 검색</option>
							<option value="cd">문서형식</option>
							<option value="title">제목</option>
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
			</div>
		</div>
	</div>
</div>
</body>
</html>