<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
							<h4>공지사항 수정</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/noticeList">Notice</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/noticeByNo?noticeNo=${noticeByNo.noticeNo}">NoticeByNo</a></li>
								<li class="breadcrumb-item active" aria-current="page">modifyNotice</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			
			<!-- 입력폼 시작 -->
			<div class="html-editor pd-20 card-box mb-30">
				<form action="${pageContext.request.contextPath}/board/modifyNotice" method="post" id="modNoticeForm">
					<input type="hidden" name="id" value="${loginId}">
					<input type="hidden" name="noticeNo" value="${noticeByNo.noticeNo}">
					<div class="form-group">
						<input type="text" class="form-control" name="noticeTitle" id="noticeTitle" value="${noticeByNo.noticeTitle}">
					</div>
					<div class="form-group">
						<textarea class="textarea_editor form-control border-radius-0" name="noticeContent" id="noticeContent">${noticeByNo.noticeContent}</textarea>
					</div>
					<div style="display: flex;">
						<div style="margin-left: auto;">
							<a href="${pageContext.request.contextPath}/board/noticeByNo?noticeNo=${noticeByNo.noticeNo}">
								<button type="button" class="btn btn-secondary">취소</button>
							</a>
							<button type="button" class="btn btn-primary" id="btn">확인</button>
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
	if($('#noticeTitle').val() == ''){
		alert('제목을 입력해주세요');
		$('#noticeTitle').focus();
	}else if($('#noticeContent').val() == ''){
		alert('내용을 입력해주세요');
	}else {
		$('#modNoticeForm').submit();
	}
});
</script>
</body>
</html>