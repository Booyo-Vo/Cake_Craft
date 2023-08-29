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
	<h1>게시글 상세정보</h1>
	<!-- 게시글 상세 정보 시작 -->
	<table>
		<tr>
			<td>anonyTitle</td>
			<td>${anonyByNo.anonyTitle}</td>
		</tr>
		<tr>
			<td>noticeContent</td>
			<td>${anonyByNo.anonyContent}</td>
		</tr>
		<tr>
			<td>likeCnt</td>
			<td>${anonyByNo.likeCnt}</td>
		</tr>
		<tr>
			<td>reg_id</td>
			<td>${anonyByNo.regId}</td>
		</tr>
		<tr>
			<td>mod_id</td>
			<td>${anonyByNo.modId}</td>
		</tr>
		<tr>
			<td>reg_dtime</td>
			<td>${anonyByNo.regDtime}</td>
		</tr>
		<tr>
			<td>mod_dtime</td>
			<td>${anonyByNo.modDtime}</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
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
			</td>
		</tr>
	</table>
	<a href="${pageContext.request.contextPath}/board/anonyList">취소</a>
	<!-- 작성자만 수정,삭제 버튼 출력 -->
	<c:if test="${loginId == anonyByNo.id}">
		<a href="${pageContext.request.contextPath}/board/modifyAnony?anonyNo=${anonyByNo.anonyNo}">수정</a>
		<a href="${pageContext.request.contextPath}/board/removeAnony?anonyNo=${anonyByNo.anonyNo}">삭제</a>
	</c:if>
	<button type="button" id="likeBtn"></button>
	<!-- 게시글 상세 정보 끝 -->
	
	<!-- 댓글 입력 폼 시작 -->
	<div>
		<form action="${pageContext.request.contextPath}/board/addComments" method="post">
			<input type="hidden" name="id" value="${loginId}">
			<input type="hidden" name="anonyNo" value="${anonyByNo.anonyNo}">
			<textarea rows="3" cols="30" name="commentsContent"></textarea>
			<button type="submit">입력</button>
		</form>
	</div>
	<!-- 댓글 입력 폼 끝 -->
	
	<!-- 댓글 목록 시작 -->
	<div>
		<table>
			<tr>
				<td>commentsContent</td>
				<td>regId</td>
				<td>regDtime</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
				<c:forEach var="c" items="${commentsList}">
				<!-- 댓글내용 -->
					<tr id="comments${c.commentsNo}">
						<td>${c.commentsContent}</td>
						<td>익명이</td>
						<td>${c.regDtime}</td>
						<!-- 로그인한 직원과 작성자가 일치할때만 수정,삭제버튼 활성화 -->
						<c:if test="${loginId == c.regId}">
							<td>
								<a href="#" onclick="modCommentsBtn(${c.commentsNo},${c.anonyNo})">수정</a>
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/board/removeComments?commentsNo=${c.commentsNo}&anonyNo=${c.anonyNo}">삭제</a>
							</td>
						</c:if>
						<c:if test="${loginId != c.regId}">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</c:if>
					</tr>
				<!-- 댓글 수정폼 -->
					<tr id="modForm${c.commentsNo}" style="display: none">
						<td colspan="3">
							<form action="${pageContext.request.contextPath}/board/modifyComments" method="post" id="modComments${c.commentsNo}">
								<input type="hidden" name="id" value="${loginId}">
								<input type="hidden" name="anonyNo" value="${c.anonyNo}">
								<input type="hidden" name="commentsNo" value="${c.commentsNo}">
								<textarea rows="3" cols="30" name="commentsContent" id="commentsContent${c.commentsNo}">${c.commentsContent}</textarea>
								<button type="button" id="modSubmitBtn${c.commentsNo}">입력</button>
								<button type="button" id="cancelBtn${c.commentsNo}">취소</button>
							</form>
							<a href="${pageContext.request.contextPath}/board/anonyByNo?anonyNo="${c.anonyNo}>취소</a>
						</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	<!-- 댓글 목록 끝 -->
</div>
<script>
	// 좋아요 버튼 클릭시
	var likeCk = ${likeCk};
	
	let anonyNo = ${anonyByNo.anonyNo};
	let id = '${loginId}';
	
	if(likeCk > 0){
		console.log(likeCk + "좋아요 누름");
		$('#likeBtn').html("좋아요 취소");
		$('#likeBtn').click(function() {
			$.ajax({
				type :'post',
				url : '${pageContext.request.contextPath}/board/likeDown',
				data : {
					anonyNo : anonyNo,
					id : id
				},
				success : function(data) {
					alert('취소 성공');
					location.reload();
				},
			})
		})
	}else{
		console.log(likeCk + "좋아요 안누름")
		$('#likeBtn').html("좋아요");
		$('#likeBtn').click(function() {
			$.ajax({
				type :'post',
				url :'${pageContext.request.contextPath}/board/likeUp',
				data : {
					anonyNo : anonyNo,
					id : id
				},
				success : function(data) {
					alert('좋아요 성공');
					location.reload();
				},
			})
		})
	}

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
</script>
</body>
</html>