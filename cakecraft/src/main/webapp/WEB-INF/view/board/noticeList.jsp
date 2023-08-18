<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
	jQuery.noConflict();
	var mydata = [ //데이터
        <c:forEach var="n" items="${noticeList}">
        	{noticeNo: "${n.noticeNo}", noticeTitle: "${n.noticeTitle}", regDtime: "${n.regDtime}", regId: "${n.regId}"},
    	</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['번호','제목','작성일','작성자'],
		colModel:[
			{name:'noticeNo', index:'noticeNo', width:10, align: "center", sortable:false},
			{name:'noticeTitle', index:'noticeTitle', width:30, align: "center", sortable:false},
			{name:'regDtime', index:'regDtime', width:30, align: "center"},
			{name:'regId', index:'tearegIdmNm', width:30, align: "center"},
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers : false, // 각 행앞에 번호를 표시
		multiselect: false, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수 
		sortname: 'regDtime', // 기본정렬열
		sortorder: 'desc', //기본정렬순서
		height: "auto", //표의 높이
	    caption: "공지사항" // 테이블 캡션 설정
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
    $("#list").on("click", ".jqgrow td[aria-describedby='list_noticeTitle']", function () {
        var rowId = $(this).closest("tr.jqgrow").attr("id");
        var rowData = $("#list").jqGrid("getRowData", rowId);
        var noticeNo = rowData.noticeNo;
        window.location.href = "${pageContext.request.contextPath}/board/noticeByNo?noticeNo=" + noticeNo;
    });
    
    // 선택 가능한 열에 밑줄 스타일 추가
    $("#list").on("mouseover", ".jqgrow td[aria-describedby='list_noticeTitle']", function () {
        $(this).css("text-decoration", "underline");
        $(this).css("cursor", "pointer");
        $(this).css("color", "#007bff");
    }).on("mouseout", ".jqgrow td[aria-describedby='list_noticeTitle']", function () {
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
	<h1>공지 게시판</h1>
	<!-- 공지사항 추가버튼 -->
	<div>
		<a href="${pageContext.request.contextPath}/board/addNotice"><button type="button">공지사항 작성</button></a>
	</div>
	<!-- 작성자, 공지내용 검색 -->
	<form action="${pageContext.request.contextPath}/board/noticeList" method="get">
		<div>
			<input type="text" name="searchRegId" placeholder="작성자 입력">
			<input type="text" name="searchWord" placeholder="공지내용 입력">
			
			<button type="submit">검색</button>
		</div>
	</form>
	<!-- 공지 목록 -->
	<table id="list"></table>
	<!-- 페이징 -->
	<div id="pager"></div>
</div>
</body>
</html>