<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
							<h4>공지 상세보기</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/noticeList">Notice</a></li>
								<li class="breadcrumb-item active" aria-current="page">noticeByNo</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			<!-- 공지상세 시작 -->
			<div class="pd-20 card-box mb-30">
				<div class="container" style="width: 90%;">
					<br>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>제목</b></label>
						<div class="col-md-10">
							${noticeByNo.noticeTitle}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>내용</b></label>
						<div class="col-md-10">
							${noticeByNo.noticeContent}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>작성자</b></label>
						<div class="col-md-10">
							${noticeByNo.regId}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>작성일</b></label>
						<div class="col-md-10">
							${noticeByNo.regDtime}
						</div>
					</div>
					<div class="pull-right">
						<a href="${pageContext.request.contextPath}/board/noticeList">
							<button type="button" class="btn btn-secondary form-group">취 소</button>
						</a>
						<!-- 작성자만 수정,삭제버튼 노출 -->
						<c:if test="${loginId == noticeByNo.id}">
							<a href="${pageContext.request.contextPath}/board/modifyNotice?noticeNo=${noticeByNo.noticeNo}">
								<button type="button" class="btn btn-primary form-group">수 정</button>
							</a>
							<button type="button" class="btn btn-primary form-group" onclick="removeNotice(${noticeByNo.noticeNo})">삭 제</button>
						</c:if>
					</div>
					<br><br>
				</div>
			</div>
			<!-- 공지상세 끝 -->
		</div>
	</div>
</div>
<script>
//공지 삭제 버튼 클릭 시
function removeNotice(noticeNo) {
	swal({
		title: '공지를 삭제하시겠습니까?',
		text: "삭제된 게시글은 복구할 수 없습니다.",
		type: 'warning',
		confirmButtonText: '예',
		cancelButtonText: '아니오',
		showCancelButton: true,
	}).then(function(result){
		console.log(result);
		if (result.value == true) {
			window.location.href = '${pageContext.request.contextPath}/board/removeNotice?noticeNo='+noticeNo;
		}
	});
}
</script>
</body>
</html>