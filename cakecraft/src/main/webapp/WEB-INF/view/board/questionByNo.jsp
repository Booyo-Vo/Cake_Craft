<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<h1>문의 상세보기</h1>
	<table>
		<tr>
			<td>questionTitle</td>
			<td>${questionByNo.questionTitle}</td>
		</tr>
		<tr>
			<td>questionContent</td>
			<td>${questionByNo.questionContent}</td>
		</tr>
		<tr>
			<td>secretYn</td>
			<td>
				<c:if test="${questionByNo.secretYn=='Y'}">
					<i class="icon-copy fa fa-lock" aria-hidden="true"></i>
				</c:if>
				<c:if test="${questionByNo.secretYn=='N'}">
					<i class="icon-copy fa fa-unlock" aria-hidden="true"></i>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>reg_id</td>
			<td>${questionByNo.regId}</td>
		</tr>
		<tr>
			<td>mod_id</td>
			<td>${questionByNo.modId}</td>
		</tr>
		<tr>
			<td>reg_dtime</td>
			<td>${questionByNo.regDtime}</td>
		</tr>
		<tr>
			<td>mod_dtime</td>
			<td>${questionByNo.modDtime}</td>
		</tr>
	</table>
	<a href="${pageContext.request.contextPath}/board/questionList">취소</a>
	<!-- 작성자만 수정,삭제버튼 노출 -->
	<c:if test="${loginId == questionByNo.regId}">
		<a href="${pageContext.request.contextPath}/board/removeQuestion?questionNo=${questionByNo.questionNo}">삭제</a>
		<a href="${pageContext.request.contextPath}/board/modifyQuestion?questionNo=${questionByNo.questionNo}">수정</a>
	</c:if>
	<div>
		<!-- 문의 답변이 존재하지않으면 입력폼 출력 -->
		<c:if test="${answerByNo == null}">
			<!-- 관리부만 입력폼 출력 -->
			<c:if test="${empBase.deptCd == '1'}">
				<h4>문의 답변</h4>
				<!-- 입력폼 -->
				<div>
					<form action="${pageContext.request.contextPath}/board/addAnswer" method="post" id="addAnswerFrom">
						<input type="hidden" name="questionNo" value="${questionByNo.questionNo}">
						<input type="hidden" name="id" value="${questionByNo.id}">
						<textarea rows="3" cols="30" name="answerContent" id="addAnswerContent"></textarea>
						<button type="button" id="addSubmitBtn">확인</button>
					</form>
				</div>
			</c:if>
		</c:if>
		<!-- 문의 답변이 존재한다면 답변출력 -->
		<c:if test="${answerByNo != null}">
			<h4>문의 답변</h4>
			<!-- 문의 답변 -->
			<div id="answerDiv">
				${answerByNo.answerContent}
				<!-- 관리부만 답변 수정버튼 출력 -->
				<c:if test="${empBase.deptCd == '1'}">
					<a href="#" onclick="modAnswerBtn(${questionByNo.questionNo})">수정</a>
				</c:if>
			</div>
			<!-- 수정폼 -->
			<div id="modAnswerFormDiv" style="display: none">
				<form action="${pageContext.request.contextPath}/board/modifyAnswer" method="post" id="modAnswerFrom">
					<input type="hidden" name="questionNo" value="${questionByNo.questionNo}">
					<input type="hidden" name="id" value="${questionByNo.id}">
					<textarea rows="3" cols="30" name="answerContent" id="modAnswerContent">${answerByNo.answerContent}</textarea>
					<button type="button" id="modSubmitBtn">확인</button>
					<button type="button" id="cancelBtn">취소</button>
				</form>
			</div>
		</c:if>
	</div>
</div>
<script>
// 입력폼 유효성검사
$('#addSubmitBtn').click(function(){
	if($('#addAnswerContent').val() == ''){
		alert('답변내용을 입력해주세요');
	}else {
		$('#addAnswerFrom').submit();
	}
});

// 문의수정 버튼 클릭시 
function modAnswerBtn(questionNo){
	$('#modAnswerFormDiv').show();
	$('#answerDiv').hide();
	
	// 수정폼 유효성검사 
	$('#modSubmitBtn').click(function(){
		if($('#modAnswerContent').val() == ''){
			alert('답변내용을 입력해주세요');
		}else {
			$('#modAnswerFrom').submit();
		}
	});
	
	// 수정폼 취소 버튼 클릭시
	$('#cancelBtn').click(function(){
		location.reload();
	});
} 
</script>
</body>
</html>