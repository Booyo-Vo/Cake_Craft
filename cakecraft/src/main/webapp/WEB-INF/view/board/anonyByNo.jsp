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
	<a href="${pageContext.request.contextPath}/board/removeAnony?anonyNo=${anonyByNo.anonyNo}">삭제</a>
	<a href="${pageContext.request.contextPath}/board/modifyAnony?anonyNo=${anonyByNo.anonyNo}">수정</a>
	<button type="button" id="likeBtn"></button>
	<!-- 게시글 상세 정보 끝 -->
</div>
<script>
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
</script>
</body>
</html>