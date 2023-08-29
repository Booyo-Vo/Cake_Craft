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
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-6 col-sm-12">
						<div class="title">
							<h4>문의사항 수정</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/questionList">QnA</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/questionByNo?questionNo=${questionByNo.questionNo}">QuestionByNo</a></li>
								<li class="breadcrumb-item active" aria-current="page">modifyQuestion</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			
			<!-- 입력폼 시작 -->
			<div class="html-editor pd-20 card-box mb-30">
				<form action="${pageContext.request.contextPath}/board/modifyQuestion" method="post" id="modQuestionForm">
					<input type="hidden" name="id" value="${loginId}">
					<input type="hidden" name="questionNo" value="${questionByNo.questionNo}">
					<div class="form-group">
						<input class="form-control" type="text" name="questionTitle" id="questionTitle" value="${questionByNo.questionTitle}">
					</div>
					<div class="form-group">
						<textarea class="textarea_editor form-control border-radius-0" name="questionContent" id="questionContent">${questionByNo.questionContent}</textarea>
					</div>
					<div class="form-group">
						<c:if test="${questionByNo.secretYn == 'Y'}">
							<input type="checkbox" name="secretYn" value="Y" checked="checked"> 비밀글 여부
						</c:if>
						<c:if test="${questionByNo.secretYn != 'Y'}">
							<input type="checkbox" name="secretYn" value="Y"> 비밀글 여부
						</c:if>
					</div>
					<div style="display: flex;">
						<div style="margin-left: auto;">
							<a href="${pageContext.request.contextPath}/board/questionByNo?questionNo=${questionByNo.questionNo}"><button type="button" class="btn btn-primary">취소</button></a>
							<button type="button" id="btn" class="btn btn-primary">확인</button>
						</div>
					</div>
				</form>
			</div>
			<!-- 입력폼 끝 -->
		</div>
	</div>
</div>
<script>
// 입력폼 유효성검사
$('#btn').click(function(){
	if($('#questionTitle').val() == ''){
		alert('제목을 입력해주세요');
		$('#questionTitle').focus();
	}else if($('#questionContent').val() == ''){
		alert('내용을 입력해주세요');
	}else {
		$('#modQuestionForm').submit();
	}
});
</script>
</body>
</html>