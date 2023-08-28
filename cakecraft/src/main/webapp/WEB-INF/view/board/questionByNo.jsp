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
			<td>${questionByNo.secretYn}</td>
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
	<a href="${pageContext.request.contextPath}/board/removeQuestion?questionNo=${questionByNo.questionNo}">삭제</a>
	<a href="${pageContext.request.contextPath}/board/modifyQuestion?questionNo=${questionByNo.questionNo}">수정</a>

	<div>
		<h4>문의 답변</h4>
		<!-- 문의 답변이 존재하지않으면 입력폼 출력 -->
		<c:if test="${answerByNo == null}">
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
		<!-- 문의 답변이 존재한다면 답변출력 -->
		<c:if test="${answerByNo != null}">
			<!-- 문의 답변 -->
			<div id="answerDiv">
				${answerByNo.answerContent}
				<a href="#" onclick="modAnswerBtn(${questionByNo.questionNo})">수정</a>
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