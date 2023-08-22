<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
	jQuery.noConflict();
	var mydata = [ //데이터
        <c:forEach var="l" items="${anonyList}">
        	{anonyNo: "${l.anonyNo}", anonyTitle: "${l.anonyTitle}", likeCnt: "${l.likeCnt}", regDtime: "${l.regDtime}"},
    	</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['번호','제목','&#9825; 좋아요 수','작성일'],
		colModel:[
			{name:'anonyNo', index:'noticeNo', width:10, align: "center", sortable:false},
			{name:'anonyTitle', index:'noticeTitle', width:30, align: "center", sortable:false},
			{name:'likeCnt', index:'likeCnt', width:30, align: "center"},
			{name:'regDtime', index:'regDtime', width:30, align: "center"},
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers : false, // 각 행앞에 번호를 표시
		multiselect: false, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수 
		sortname: 'regDtime', // 기본정렬열
		sortorder: 'desc', //기본정렬순서
		height: "auto", //표의 높이
	    caption: "익명게시판" // 테이블 캡션 설정
	});
	
	// 윈도우 크기가 조정 될 때 표의 너비를 조정
	$(window).on('resize.jqGrid', function() {
		$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
	})
	
	// 전체화 버튼이 클릭될 때 표의 너비를 조정
	$(".jarviswidget-fullscreen-btn").click(function(){
		setTimeout(function() {
			$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
		}, 100);
	});
    
    // 데이터셀을 클릭 가능한 링크로 만드는 코드
    $("#list").on("click", ".jqgrow td[aria-describedby='list_anonyTitle']", function () {
        var rowId = $(this).closest("tr.jqgrow").attr("id");
        var rowData = $("#list").jqGrid("getRowData", rowId);
        var anonyNo = rowData.anonyNo;
        window.location.href = "${pageContext.request.contextPath}/board/anonyByNo?anonyNo=" + anonyNo;
    });
    
    // 선택 가능한 열에 밑줄 스타일 추가
    $("#list").on("mouseover", ".jqgrow td[aria-describedby='list_anonyTitle']", function () {
        $(this).css("text-decoration", "underline");
        $(this).css("cursor", "pointer");
        $(this).css("color", "#007bff");
    }).on("mouseout", ".jqgrow td[aria-describedby='list_anonyTitle']", function () {
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
	<h1>익명 게시판</h1>
	<!-- 익명게시글 추가버튼 -->
	<div>
		<a href="${pageContext.request.contextPath}/board/addAnony"><button type="button">게시글 작성</button></a>
	</div>
	<!-- 제목 검색 -->
	<form action="${pageContext.request.contextPath}/board/anonyList" method="get">
		<div>
			<input type="text" name="searchWord" placeholder="제목 입력">
			
			<button type="submit">검색</button>
		</div>
	</form>
	<!-- 익명게시판 목록 -->
	<table id="list"></table>
	<!-- 페이징 -->
	<div id="pager"></div>
</div>
</body>
</html>