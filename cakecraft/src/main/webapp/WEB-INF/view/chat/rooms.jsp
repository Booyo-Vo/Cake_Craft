<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
</head>
<body>
<c:import url="/layout/header.jsp"></c:import>

<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-6 col-sm-12">
						<div class="title">
							<h4>채팅방 목록</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">Chat Rooms</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<div class="bg-white border-radius-4 box-shadow mb-30">
				<div class="row px-3 py-3">
					<div class="col-6">
						<div class="card h-100">
							<div class="card-header bg-secondary text-white">
								<span class="fs-3">채팅방 목록</span>
							</div>
							<div class="card-body">
								<ul>
									<li>
										<c:forEach var="r" items="#{chatList}">
											<li><a href="${pageContext.request.contextPath}/chat/room?roomId=${r.roomId}&roomMember=${loginEmpBase.id}">${r.roomName}<span class="ml-2 badge badge-primary">${r.memberCnt}</span></a></li>
										</c:forEach>
									</li>
								</ul>
							</div>
						</div>
					</div>
					
					<div class="col-6">
						<form action="${pageContext.request.contextPath}/chat/room" method="post">
							<div class="card h-100">
								<div class="card-header bg-secondary">
									<div class="row">
										<div class="col-9">
											<input id="roomName" type="text" class="form-control" name="roomName" placeholder="방 이름을 입력하세요" value="">
										</div>
										<div class="col-3">
											<button id="createBtn" type="button" class="btn btn-primary">만들기</button>
										</div>
									</div>
								</div>
								<div class="card-body">
									<h5 class="card-title">사원목록</h5>
										<input type="hidden" name="regId" value="${loginEmpBase.id}">
										<input type="hidden" name="member" value="${loginEmpBase.id}">
										<div class="customscroll">
											<ul>
												<c:forEach var="e" items="${empList}">
													<c:if test="${e.empStatus.equals('재직자') && !e.id.equals(loginEmpBase.id)}">
														<li><input class="chatMember mr-1" type="checkbox" id="${e.id}" name="member" value="${e.id}"><label for="${e.id}">${e.empName}</label></li>
													</c:if>
												</c:forEach>
											</ul>
										</div>	
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="footer-wrap pd-20 mb-20 card-box">
			Illusty by <a href="https://kr.freepik.com/free-vector/delicious-hand-painted-desserts-set_13312763.htm#query=%EB%94%94%EC%A0%80%ED%8A%B8%20%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8&position=10&from_view=keyword&track=ais">작가 rawpixel.com</a> 출처 Freepik <a href="https://github.com/dropways" target="_blank"></a>
		</div>
	</div>
</div>
<script>
	let newRoomName = '${newRoomName}';
	if(newRoomName != ''){
		swal('채팅방알림', roomName+'방이 개설되었습니다.', 'info');
	}
	$('#createBtn').click(function(){
		let name = $('#roomName').val();
		if(name == ''){
			swal('이름입력필요', '채팅방 이름을 입력해주세요', 'warning');
		}else{
			$('form').submit();
		}
	})
</script>
</body>
</html>