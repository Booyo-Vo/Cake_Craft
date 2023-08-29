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
							<h4>게시글 상세보기</h4>
						</div>
						
						<!-- breadcrumb 시작 -->
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/board/anonyList">Anony</a></li>
								<li class="breadcrumb-item active" aria-current="page">anonyByNo</li>
							</ol>
						</nav>
						<!-- breadcrumb 끝 -->
					</div>
				</div>
			</div>
			<!-- 게시글 상세 시작 -->
			<div class="pd-20 card-box mb-30">
				<div class="container" style="width: 90%;">
					<br>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>제목</b></label>
						<div class="col-md-10">
							${anonyByNo.anonyTitle}
							<button type="button" class="btn btn-light pull-right" id="likeBtn" style="color: #F68E8E"></button>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>내용</b></label>
						<div class="col-md-10">
							${anonyByNo.anonyContent}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>좋아요</b></label>
						<div class="col-md-10">
							${anonyByNo.likeCnt}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>작성자</b></label>
						<div class="col-md-10">
							${anonyByNo.regId}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>작성일</b></label>
						<div class="col-md-10">
							${anonyByNo.regDtime}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 col-form-label"><b>첨부파일</b></label>
						<div class="col-md-10">
							<c:forEach var="a" items="${anonyFileList}">
								<!-- 이미지 파일 -->
								<c:if test="${a.anonyType == 'image/png'}">
									<img src="${pageContext.request.contextPath}/anonyupload/${a.anonyFilename}" alt="IMG-REVIEW" style="width:80px; height:80px;">
									&nbsp;
								</c:if>
								<!-- 이미지 외 파일들 다운로드 가능 -->
								<c:if test="${a.anonyType != 'image/png'}">
									<br>
									<a href="${pageContext.request.contextPath}/anonyupload/${a.anonyFilename}" target="_blank">
										${a.anonyFilename.substring(0, a.anonyFilename.lastIndexOf("_"))}${a.anonyFilename.substring(a.anonyFilename.lastIndexOf("."))}
									</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="pull-right">
						<a href="${pageContext.request.contextPath}/board/anonyList">
							<button type="button" class="btn btn-secondary form-group">취 소</button>
						</a>
						<!-- 작성자만 수정,삭제버튼 노출 -->
						<c:if test="${loginId == anonyByNo.id}">
							<a href="${pageContext.request.contextPath}/board/modifyAnony?anonyNo=${anonyByNo.anonyNo}">
								<button type="button" class="btn btn-primary form-group">수 정</button>
							</a>
							<button type="button" class="btn btn-primary form-group" onclick="removeAnony(${anonyByNo.anonyNo})">삭 제</button>
						</c:if>
					</div>
					<br><br>
				</div>
			</div>
			<!-- 게시글 상세 정보 끝 -->
		</div>
		
		<!-- 댓글 시작 -->
		<div class="pd-20 card-box mb-30">
			<div class="container" style="width: 90%;">
				<!-- 댓글 입력 폼 시작 -->
				<div class="form-group">
					<div>
						<br>
						<label><b>댓 글</b></label>
						<button type="button" class="pull-right btn btn-primary"  id="addSubmitBtn">등 록</button>
					</div>
					<br>
					<form action="${pageContext.request.contextPath}/board/addComments" method="post" id="addCommentsForm">
						<input type="hidden" name="id" value="${loginId}">
						<input type="hidden" name="anonyNo" value="${anonyByNo.anonyNo}">
						<textarea class="form-control" name="commentsContent" id="addCommentsContent" style="height: 80px;"></textarea>
					</form>
				</div>
				<!-- 댓글 입력 폼 끝 -->
				
				<!-- 댓글 목록 시작 -->
				<div>
					<table class="table">
						<c:forEach var="c" items="${commentsList}">
							<!-- 댓글내용 -->
							<tr id="comments${c.commentsNo}">
								<td style="width: 50%">${c.commentsContent}</td>
								<td style="width: 10%">익명이</td>
								<td style="width: 24%">${c.regDtime}</td>
								<!-- 작성자만 수정,삭제버튼 노출 -->
								<c:if test="${loginId == c.regId}">
									<td style="width: 8%">
										<a href="#" onclick="modCommentsBtn(${c.commentsNo},${c.anonyNo})">수 정</a>
									</td>
									<td style="width: 8%">
										<a href="#" onclick="removeCommentsBtn(${c.commentsNo},${c.anonyNo})">삭 제</a>
									</td>
								</c:if>
								<c:if test="${loginId != c.regId}">
									<td style="width: 8%">&nbsp;</td>
									<td style="width: 8%">&nbsp;</td>
								</c:if>
							</tr>
							
							<!-- 댓글 수정폼 -->
							<tr id="modForm${c.commentsNo}" style="display: none">
								<td colspan="5">
									<div class="form-group">
										<div>
											<br>
											<div class="pull-left">
												<label><b>댓 글 수 정</b></label>
											</div>
											<div class="pull-right">
												<button type="button" class="btn btn-secondary" id="cancelBtn${c.commentsNo}">취 소</button>
												<button type="button" class="btn btn-primary" id="modSubmitBtn${c.commentsNo}">확 인</button>
											</div>
											<br><br>
										</div>
										<br>
										<form action="${pageContext.request.contextPath}/board/modifyComments" method="post" id="modComments${c.commentsNo}">
											<input type="hidden" name="id" value="${loginId}">
											<input type="hidden" name="anonyNo" value="${c.anonyNo}">
											<input type="hidden" name="commentsNo" value="${c.commentsNo}">
											<textarea class="form-control" name="commentsContent" id="commentsContent${c.commentsNo}" style="height: 80px;">${c.commentsContent}</textarea>
										</form>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- 댓글 목록 끝 -->
			</div>
		</div>
		<br>
	</div>
</div>
<script>
// 좋아요 버튼 클릭시
var likeCk = ${likeCk};

let anonyNo = ${anonyByNo.anonyNo};
let id = '${loginId}';

if(likeCk > 0){
	$('#likeBtn').html('<i class="icon-copy fa fa-heart" aria-hidden="true"></i> 좋아요 취소');
	$('#likeBtn').click(function() {
		$.ajax({
			type :'post',
			url : '${pageContext.request.contextPath}/board/likeDown',
			data : {
				anonyNo : anonyNo,
				id : id
			},
			success : function(data) {
				alert('좋아요 취소');
				location.reload();
			},
		})
	})
}else{
	$('#likeBtn').html('<i class="icon-copy fa fa-heart-o" aria-hidden="true"></i> 좋아요');
	$('#likeBtn').click(function() {
		$.ajax({
			type :'post',
			url :'${pageContext.request.contextPath}/board/likeUp',
			data : {
				anonyNo : anonyNo,
				id : id
			},
			success : function(data) {
				alert('좋아요');
				location.reload();
			},
		})
	})
}

// 입력폼 유효성검사
$('#addSubmitBtn').click(function(){
	if($('#addCommentsContent').val() == ''){
		alert('내용을 입력해주세요');
		$('#addCommentsContent').focus();
	}else {
		$('#addCommentsForm').submit();
	}
});

// 댓글수정 버튼 클릭시 
function modCommentsBtn(commentsNo, anonyNo){
	// 수정폼 구역
	const modFormId = 'modForm'+commentsNo;
	// 댓글내용 구역
	const commentsId = 'comments'+commentsNo;
	// 수정폼 제출 버튼 
	const modSubmitBtnId = 'modSubmitBtn'+commentsNo;
	// 수정폼
	const modCommentsId = 'modComments'+commentsNo;
	// 수정폼 안에 댓글내용
	const commentsContentId = 'commentsContent'+commentsNo;
	// 수정폼 안에 취소버튼
	const cancelBtnId = 'cancelBtn'+commentsNo;
	
	$('#' + modFormId).show();
	$('#' + commentsId).hide();
	
	// 수정폼으로 포커스 이동
	$('#' + commentsContentId).focus();
	var offset = $('#' + commentsContentId).offset();
	$("html, body").animate({scrollTop: offset.top},100);
	
	// 수정폼 유효성검사 
	$('#' + modSubmitBtnId).click(function(){
		if($('#' + commentsContentId).val() == ''){
			alert('댓글내용을 입력해주세요');
		}else {
			$('#' + modCommentsId).submit();
		}
	});
	
	// 수정폼 취소 버튼 클릭시
	$('#' + cancelBtnId).click(function(){
		location.reload();
	});
} 

// 게시글 삭제 버튼 클릭시
function removeAnony(anonyNo) {
	if (confirm('게시글을 삭제하시겠습니까?')) {
		window.location.href = '${pageContext.request.contextPath}/board/removeAnony?anonyNo='+anonyNo;
	}
}

// 댓글 삭제 버튼 클릭시
function removeCommentsBtn(commentsNo, anonyNo) {
	if (confirm('댓글을 삭제하시겠습니까?')) {
		window.location.href = '${pageContext.request.contextPath}/board/removeComments?commentsNo='+ commentsNo +'&anonyNo='+ anonyNo;
	}
}
</script>
</body>
</html>