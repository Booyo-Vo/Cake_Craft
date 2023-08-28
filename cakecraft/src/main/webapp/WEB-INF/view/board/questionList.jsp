<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
jQuery.noConflict();
jQuery(document).ready(function($) {
	var mydata = [ //데이터
		<c:forEach var="q" items="${questionList}">
			{questionNo: "${q.questionNo}", questionTitle: "${q.questionTitle}", sercretYn:"${q.secretYn}", regDtime: "${q.regDtime}", regId: "${q.regId}"},
		</c:forEach>
	];

	$("#list").jqGrid({
		datatype: "local",
		data: mydata,
		colNames:['번호','제목','비밀글','작성일','작성자'],
		colModel:[
			{name:'questionNo', index:'questionNo', width:10, align: "center", sortable:false},
			{name:'questionTitle', index:'questionTitle', width:25, align: "center", sortable:false},
			{name:'sercretYn', index:'sercretYn', width:10, align: "center", sortable:false,
				// 비밀글일 경우 자물쇠 이미지로 표시
				formatter: function(cellvalue) {
					if (cellvalue == 'Y') {
						return '<i class="icon-copy fa fa-lock" aria-hidden="true"></i>';
					} else {
						return '';
					}
				}
			},
			{name:'regDtime', index:'regDtime', width:25, align: "center"},
			{name:'regId', index:'regId', width:20, align: "center"},
		],
		autowidth: true, //테이블의 너비를 자동 조절
		rownumbers : false, // 각 행앞에 번호를 표시
		multiselect: false, // 다중선택 활성화
		pager:'#pager',
		rowNum: 10, // 표시할 행의 수 
		sortname: 'regDtime', // 기본정렬열
		sortorder: 'desc', //기본정렬순서
		height: "auto", //표의 높이
		caption: "QnA" // 테이블 캡션 설정
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
	$("#list").on("click", ".jqgrow td[aria-describedby='list_questionTitle']", function () {
		var rowId = $(this).closest("tr.jqgrow").attr("id");
		var rowData = $("#list").jqGrid("getRowData", rowId);
		var questionNo = rowData.questionNo;
		var secretYn = rowData.sercretYn;
		var loginId = '${loginId}';
		var deptCd = '${empBase.deptCd}';
		
		// 비밀글인 경우 작성자와 관리부만 열람가능
		if(secretYn == ''){
			window.location.href = "${pageContext.request.contextPath}/board/questionByNo?questionNo=" + questionNo;
		}else if(secretYn != '' && loginId == rowData.regId){
			window.location.href = "${pageContext.request.contextPath}/board/questionByNo?questionNo=" + questionNo;
		}else if(secretYn != '' && loginId != rowData.regId && deptCd == '1'){
			window.location.href = "${pageContext.request.contextPath}/board/questionByNo?questionNo=" + questionNo;
		}else{
			alert("비밀글입니다");
		}
		
	});
	
	// 선택 가능한 열에 밑줄 스타일 추가
	$("#list").on("mouseover", ".jqgrow td[aria-describedby='list_questionTitle']", function () {
		$(this).css("text-decoration", "underline");
		$(this).css("cursor", "pointer");
		$(this).css("color", "#007bff");
	}).on("mouseout", ".jqgrow td[aria-describedby='list_questionTitle']", function () {
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
							<h4>QnA</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">QnA</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			<div class="pd-20 card-box mb-30">
				<div class="clearfix mb-20">
					<!-- 작성자, 문의제목 검색 시작 -->
					<div class="pull-left">
						<form action="${pageContext.request.contextPath}/board/questionList" method="get">
							<div class="d-flex">
								<input class="form-control d-inline-block" type="text" name="searchRegId" placeholder="작성자 검색">
								&nbsp;
								<input class="form-control d-inline-block" type="text" name="searchWord" placeholder="문의제목 검색">
								&nbsp;
								<button class="d-inline-block btn-none" type="submit"><div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div></button>
							</div>
						</form>
					</div>
					<!-- 작성자, 문의제목 검색 끝 -->
					
					<!-- 문의사항 추가버튼 시작 -->
					<div class="pull-right">
						<a href="${pageContext.request.contextPath}/board/addQuestion"><button type="button" class="btn btn-primary">문의사항 작성</button></a>
					</div>
					<!-- 문의사항 추가버튼 끝 -->
				</div>
				
				<!-- 문의 목록 -->
				<table id="list"></table>
				<!-- 페이징 -->
				<div id="pager"></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>