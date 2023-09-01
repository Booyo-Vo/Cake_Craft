<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<h1>apprDocByNo</h1>
	<table border="1">
		<tr>
			<th>문서번호</th>
			<td>${documentNo}</td>
			<th rowspan="3">결<br>재</th>
			<th>${apprInfoLv1.approvalId}</th><!-- empBase직급가져오기 -->
			<th>${apprInfoLv2.approvalId}</th>
			<th>${apprInfoLv3.approvalId}</th>
		</tr>
		<tr>
			<th>문서구분</th>
			<td>${apprDoc.documentNm}</td>
			<td rowspan="2">	<!-- 담당자 : 결재레벨1 -->
				<c:if test="${apprInfoLv1.approvalStatusCd == 2}">
					<div>사인</div>
				</c:if>
			</td>
			<td rowspan="2">	<!-- 결재레벨2 -->
				<c:if test="${apprInfoLv2.approvalStatusCd == 2}">
					<div>사인</div>
				</c:if>
			</td>
			<td rowspan="2">	<!-- 결재레벨3 -->
				<c:if test="${apprInfoLv3.approvalStatusCd == 2}">
					<div>사인</div>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>항목구분</th>
			<td>${apprDoc.documentSubNm}</td>
		</tr>
		<tr>
			<th>기 안 자</th>
			<td>${apprDoc.id}</td>
			<th>참<br>조</th>
			<td colspan="3">${apprRef.refId}</td>
		</tr>
		<tr>
			<th>기안일자</th>
			<td colspan="5">${apprDoc.modDtime}</td>
		</tr>
		<tr>
			<th>시행일자</th>
			<td colspan="5">
				${apprDoc.startDay}
				~
				${apprDoc.endDay}
			</td>
		</tr>
		<tr>
			<th>제 &nbsp; &nbsp; 목</th>
			<td colspan="5">${apprDoc.documentTitle}</td>
		</tr>
		<tr>
			<th>내 &nbsp; &nbsp; 용</th>
			<td colspan="5">${apprDoc.documentContent}</td>
		</tr>
		<tr>
			<th>파 &nbsp; &nbsp; 일</th>
			<td colspan="5"></td>
		</tr>
	</table>
		
	<br>

	<!-- 결재자로 지정된 경우 : 승인 / 반려 -->
	<c:if test="${apprHist.approvalLevel eq ''}">
	<c:if test="${(apprHist.approvalLevel == 2 && apprHist.approvalStatusCd == 1) 
				|| (apprHistPreLv.approvalStatusCd == 2	&& apprHist.approvalLevel == 3 && apprHist.approvalStatusCd == 1)}">
		<div>
			<button type="button" class="btn btn-primary" onclick="apprAccept()">승인</button>
		</div>
		<div>
			<button type="button" class="btn btn-primary" onclick="apprReturn()">반려</button>
		</div>
	</c:if>
	</c:if>
	
	<!-- 이미 결재를 승인한 경우 or 이전레벨 결재자가 승인하지 않은 경우 : 버튼 없음 -->
	
	<!-- 작성자 본인인 경우 : 임시저장/제출하기 버튼 -->
	<c:if test="${apprDoc.id == loginId}">
		<div>임시저장</div>
		<div>제출하기</div>
	</c:if>
</div>

<script>
	// 승인버튼을 눌렀을 때 호출되는 함수
	function apprAccept() {
		var documentNo = 
	}
	
	// 반려버튼을 눌렀을 때 호출되는 함수
	function apprReturn() {
		
	}

</script>
</body>
</html>