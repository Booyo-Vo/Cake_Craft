<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-------------jdgrid  --------->
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
 <!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />
<!-- The actual JQuery code -->
<script type="text/javasscript" src="https://code.jquery.com/jquery-1.10.2.min.js" /></script>
<!-- The JQuery UI code -->
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
<!-- The jqGrid language file code-->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
<!-- The atual jqGrid code -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>
<script>
$(document).ready(function() {
	var mydata = [ //데이터
        <c:forEach var="e" items="${adminEmpList}">
        	{name: "${e.empName}", id: "${e.id}", deptNm: "${e.deptNm}", teamNm: "${e.teamNm}", positionNm: "${e.positionNm}", email: "${e.email}", empStatus: "${e.empStatus}", dayoffCnt: "${e.dayoffCnt}"},
    	</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['이름','사원번호','부서','팀','직급','이메일','재직상태','연차잔여개수'],
		colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
			{name:'name', index:'name', width:80, align: "center"},
			{name:'id', index:'id', width:80 , align: "center" },
			{name:'deptNm', index:'deptNm', width:80, align: "center"},
			{name:'teamNm', index:'teamNm', width:80, align: "center"},
			{name:'positionNm', index:'positionNm', width:80, align: "center"},
			{name:'email', index:'email', width:80, align: "center"},
			{name:'empStatus', index:'empStatus', width:80, align: "center"},
			{name:'dayoffCnt', index:'dayoffCnt', width:80, align: "center"}
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
    
    // 데이터셀을 클릭 가능한 링크로 만드는 코드
    $("#list").on("click", ".jqgrow td[aria-describedby='list_id']", function () {
        var rowId = $(this).closest("tr.jqgrow").attr("id");
        var rowData = $("#list").jqGrid("getRowData", rowId);
        var id = rowData.id;
        window.location.href = "/emp/adminEmpById?id=" + id;
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
<a href="/emp/addEmp">사원추가</a>
<table id="list"></table>
<div id="pager"></div>
<div style="margin-top: 20px; margin-left: 15px; font-size: 12px;">
    <select class="form-control" style="width: 10%; float: left;" id="searchTypeSelect">
        <option value="All" selected>전체 검색</option>
        <option value="name">이름</option>
        <option value="deptNm">부서</option>
        <option value="teamNm">팀</option>
    </select>
    <input type="text" id="searchDataInput" class="form-control" style="width: 30%; float: left; margin-bottom: 50px; margin-left: 10px;">
    <button class="btn btn-info btn-fill" id="searchButton" value="검색" style="width: 10%; float: left; margin-left: 10px;">
        검색
    </button>
</div>
</body>
</html>