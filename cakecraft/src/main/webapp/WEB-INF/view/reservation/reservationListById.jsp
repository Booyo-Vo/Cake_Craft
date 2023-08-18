<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
<!-------------jdgrid  --------->
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
 <!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />
<!-- The actual JQuery code -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js" /></script>
<!-- The JQuery UI code -->
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
<!-- The jqGrid language file code-->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
<!-- The atual jqGrid code -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>
</head>
<body>
	<!-- jqgrid 테스트 시작 -->
	<table id="list"></table>
	<div id="pager"></div>
	<!-- jqgrid 테스트 끝 -->
	
	<table>
		<thead>
			<tr>
				<td>facility</td>
				<td>content</td>
				<td>start</td>
				<td>end</td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="r" items="${list}">
				<tr>
					<td>${r.facilityName}</td>
					<td>${r.reservationContent}</td>
					<td>${fn:substring(r.startDtime, 0, 16)}</td>
					<td>${fn:substring(r.endDtime, 0, 16)}</td>
					<td>
						<c:if test="${r.startDtime >= anHour}">
							<a class="btn btn-sm btn-primary" id="rmvBtn" href="${pageContext.request.contextPath}/reservation/removeReservation?reservationNo=${r.reservationNo}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<script>
		let mydata = [ //데이터
	        <c:forEach var="r" items="${list}">
	        	{reservationNo: "${r.reservationNo}", name: "${r.facilityName}", content: "${r.reservationContent}", start: "${fn:substring(r.startDtime, 0, 16)}", end: "${fn:substring(r.endDtime, 0, 16)}"},
	    	</c:forEach>
		];
	
		$("#list").jqGrid({
			datatype: "local",
			data: mydata,
			colNames:['예약번호','이름','내용','시작','끝'],
			colModel:[ /*sortable:false 를 붙이면 정렬이 되지 않도록 함*/
				{name:'reservationNo', index:'reservationNo', width:80, align: "center", sortable: false},
				{name:'name', index:'name', width:80, align: "center", sortable: false},
				{name:'content', index:'content', width:80 , align: "center", sortable: false},
				{name:'start', index:'start', width:80, align: "center", sortable: false},
				{name:'end', index:'end', width:80, align: "center", sortable: false},
			],
			autowidth: true, //테이블의 너비를 자동 조절
			rownumbers: true, // 각 행앞에 번호를 표시
			multiselect: false, // 다중선택 활성화
			pager:'#pager',
			rowNum: 10, // 표시할 행의 수 
			rowList: [10, 20, 50], // 행수를 선택할 수 있는 옵션 설정
			sortname: 'start', // 기본정렬열
			sortorder: 'desc', //기본정렬순서
			height: "auto",//표의 높이
			search: false, // 검색 대화상자 활성화
		    //searchtext: "검색:", // 검색 필터 텍스트 설정
		    //searchtitle: "검색 필터", // 검색 대화상자 제목 설정
		    caption: "예약 이력" // 테이블 캡션 설정
		});
	
		$(window).on('resize.jqGrid', function() { // 윈도우 크기가 조정 될 때 표의 너비를 조정
			$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
		})
		$(".jarviswidget-fullscreen-btn").click(function(){ // 전체화 버튼이 클릭될 때 표의 너비를 조정
			setTimeout(function() {
				$("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
			}, 100);
		});
	    
	    // 데이터셀을 클릭 가능한 링크로 만드는 코드
	    $("#list").on("click", ".jqgrow td[aria-describedby='name']", function () {
	        var rowId = $(this).closest("tr.jqgrow").attr("id");
	        var rowData = $("#list").jqGrid("getRowData", rowId);
	        var reservationNo = rowData.reservationNo;
	        window.location.href = "${pageContext.request.contextPath}/reservation/reservationNo="+reservationNo;
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
	</script>
</body>
</html>