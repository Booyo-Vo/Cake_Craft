<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <jsp:include page="/layout/cdn.jsp"></jsp:include> --%>
<!-- css파일 -->
	<!-- <link href="/style.css" type="text/css" rel="stylesheet"> -->
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

</head>
<body>
<%-- <jsp:include page="/layout/header.jsp"></jsp:include> --%>
<div class="main-container">
	<h1>게시글 상세보기</h1>
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
	</table>
	<a href="${pageContext.request.contextPath}/board/anonyList">취소</a>
	<a href="${pageContext.request.contextPath}/board/removeAnony?anonyNo=${anonyByNo.anonyNo}">삭제</a>
	<a href="${pageContext.request.contextPath}/board/modifyAnony?anonyNo=${anonyByNo.anonyNo}">수정</a>
	<button type="button" id="likeBtn"></button>
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