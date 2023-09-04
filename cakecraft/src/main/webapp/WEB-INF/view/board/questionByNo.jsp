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
							<h4>문의 상세보기</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/questionList">QnA</a></li>
								<li class="breadcrumb-item active" aria-current="page">questionByNo</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			<!-- 문의상세 시작 -->
			<div class="pd-20 card-box mb-30">
				<div class="container" style="width: 90%;">
					<br>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>제목</b></label>
						<div class="col-md-10">
							${questionByNo.questionTitle}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>내용</b></label>
						<div class="col-md-10">
							${questionByNo.questionContent}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>비밀글</b></label>
						<div class="col-md-10">
							<c:if test="${questionByNo.secretYn=='Y'}">
								<i class="icon-copy fa fa-lock" aria-hidden="true"></i>
							</c:if>
							<c:if test="${questionByNo.secretYn=='N'}">
								<i class="icon-copy fa fa-unlock" aria-hidden="true"></i>
							</c:if>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>작성자</b></label>
						<div class="col-md-10">
							${questionByNo.regId}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>작성일</b></label>
						<div class="col-md-10">
							${questionByNo.regDtime}
						</div>
					</div>
					<div class="pull-right">
						<a href="${pageContext.request.contextPath}/board/questionList">
							<button type="button" class="btn btn-secondary form-group">취 소</button>
						</a>
						<!-- 작성자만 수정,삭제버튼 노출 -->
						<c:if test="${loginId == questionByNo.regId}">
							<a href="${pageContext.request.contextPath}/board/modifyQuestion?questionNo=${questionByNo.questionNo}">
								<button type="button" class="btn btn-primary form-group">수 정</button>
							</a>
							<button type="button" class="btn btn-primary form-group" onclick="removeQuestion(${questionByNo.questionNo})">삭 제</button>
						</c:if>
					</div>
					<br><br>
				</div>
			</div>
			<!-- 문의상세 끝 -->
		</div>
		
		<!-- 답변 시작 -->
		<div class="pd-20 card-box mb-30">
			<div class="container" style="width: 90%;">
				<!-- 문의 답변이 존재하지않으면 입력폼 출력 -->
				<c:if test="${answerByNo == null}">
					<!-- 관리부만 입력폼 출력 -->
					<c:if test="${empBase.deptCd == '1'}">
						<!-- 입력폼 -->
						<div class="form-group">
							<div>
								<br>
								<label><b>문의 답변</b></label>
								<button type="button" class="pull-right btn btn-primary" id="addSubmitBtn">등 록</button>
							</div>
							<br>
							<form action="${pageContext.request.contextPath}/board/addAnswer" method="post" id="addAnswerForm">
								<input type="hidden" name="questionNo" value="${questionByNo.questionNo}">
								<input type="hidden" name="id" value="${questionByNo.id}">
								<textarea class="form-control" name="answerContent" id="addAnswerContent"></textarea>
							</form>
						</div>
					</c:if>
				</c:if>
				
				<!-- 문의 답변이 존재한다면 답변출력 -->
				<c:if test="${answerByNo != null}">
					<!-- 문의 답변 -->
					<div id="answerDiv">
						<div>
							<br>
							<label><b>문의 답변</b></label>
							<!-- 관리부만 답변 수정버튼 출력 -->
							<c:if test="${empBase.deptCd == '1'}">
								<a href="#" onclick="modAnswerBtn(${questionByNo.questionNo})">
									<button type="button" class="pull-right btn btn-primary">수 정</button>
								</a>
							</c:if>
						</div>
						<br>
						${answerByNo.answerContent}
					</div>
					<br>
					
					<!-- 수정폼 -->
					<div id="modAnswerFormDiv" style="display: none">
						<div>
							<br>
							<div class="pull-left">
								<label><b>문의 답변 수정</b></label>
							</div>
							<div class="pull-right">
								<button type="button" class="btn btn-secondary" id="cancelBtn">취 소</button>
								<button type="button" class="btn btn-primary" id="modSubmitBtn">확 인</button>
							</div>
							<br>
						</div>
						<br>
						<form action="${pageContext.request.contextPath}/board/modifyAnswer" method="post" id="modAnswerForm">
							<input type="hidden" name="questionNo" value="${questionByNo.questionNo}">
							<input type="hidden" name="id" value="${questionByNo.id}">
							<textarea class="form-control" name="answerContent" id="modAnswerContent">${answerByNo.answerContent}</textarea>
						</form>
						<br>
					</div>
				</c:if>
			</div>
		</div>
		<!-- 답변 끝 -->
		<br>
	</div>
</div>
<script>
// 입력폼 유효성검사
$('#addSubmitBtn').click(function(){
	if($('#addAnswerContent').val() == ''){
		alert('답변내용을 입력해주세요');
		$('#addAnswerContent').focus();
	}else {
		$('#addAnswerForm').submit();
	}
});

// 답변수정 버튼 클릭시 
function modAnswerBtn(questionNo){
	$('#modAnswerFormDiv').show();
	$('#answerDiv').hide();
	
	// 수정폼 유효성검사 
	$('#modSubmitBtn').click(function(){
		if($('#modAnswerContent').val() == ''){
			alert('답변내용을 입력해주세요');
			$('#modAnswerContent').focus();
		}else {
			$('#modAnswerForm').submit();
		}
	});
	
	// 수정폼 취소 버튼 클릭시
	$('#cancelBtn').click(function(){
		location.reload();
	});
} 
// 문의 삭제 버튼 클릭 시
function removeQuestion(questionNo) {
	swal({
		title: '문의를 삭제하시겠습니까?',
		text: "삭제된 게시글은 복구할 수 없습니다.",
		type: 'warning',
		confirmButtonText: '예',
		cancelButtonText: '아니오',
		showCancelButton: true,
	}).then(function(result){
		console.log(result);
		if (result.value == true) {
			window.location.href = '${pageContext.request.contextPath}/board/removeQuestion?questionNo=' + questionNo;
		}
	});
}
</script>
</body>
</html>