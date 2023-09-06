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
							<h4>공지사항 작성</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/noticeList">Notice</a></li>
								<li class="breadcrumb-item active" aria-current="page">addNotice</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			
			<!-- 입력폼 시작 -->
			<div class="html-editor pd-20 card-box mb-30">
				<form action="${pageContext.request.contextPath}/board/addNotice" method="post" id="addNoticeForm">
					<input type="hidden" name="id" value="${loginId}">
					<div class="form-group">
						<input type="text" class="form-control" name="noticeTitle" id="noticeTitle" placeholder="Enter title">
					</div>
					<div class="form-group">
						<textarea class="textarea_editor form-control border-radius-0" name="noticeContent" id="noticeContent" placeholder="Enter content"></textarea>
					</div>
					<div style="display: flex;">
						<div style="margin-left: auto;">
							<a href="${pageContext.request.contextPath}/board/noticeList">
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
<jsp:include page="/layout/footer.jsp"></jsp:include>
<script>
// 입력폼 유효성검사
$('#btn').click(function(){
	if($('#noticeTitle').val() == ''){
		swal({
			type: 'error',
			title: '제목을 입력해주세요.'
		});
		$('#noticeTitle').focus();
	}else if($('#noticeContent').val() == ''){
		swal({
			type: 'error',
			title: '내용을 입력해주세요.'
		});
	}else {
		$('#addNoticeForm').submit();
	}
});
</script>
</body>
</html>