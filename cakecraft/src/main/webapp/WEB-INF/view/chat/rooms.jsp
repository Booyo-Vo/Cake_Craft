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
							<h4>메신저 리스트</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">홈</a></li>
								<li class="breadcrumb-item active" aria-current="page">메신저 리스트</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<div class="bg-white border-radius-4 box-shadow mb-30">
				<div class="row no-gutters">
					<div class="col-lg-6">
						<div class="chat-list bg-light-gray">
							<div class="chat-search">
								<div>메신저 리스트</div>
							</div>
							<div class="notification-list chat-notification-list customscroll">
								<ul>
									<li>
										<c:forEach var="r" items="#{chatList}">
											<li><a href="${pageContext.request.contextPath}/chat/room?roomId=${r.roomId}&roomMember=${loginEmpBase.id}">${r.roomName}</a></li>
										</c:forEach>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="chat-list bg-white">
							<div class="chat-search">
								<span class="ti-search"></span>
								<input type="text" placeholder="사원 찾기">
							</div>
							<div class="notification-list chat-notification-list">
								<form action="${pageContext.request.contextPath}/chat/room" method="post">
									<input type="hidden" name="regId" value="${loginEmpBase.id}">
									<input type="hidden" name="member" value="${loginEmpBase.id}">
									<div class="customscroll">
										<ul>
											<c:forEach var="e" items="${empList}">
												<c:if test="${e.empStatus.equals('재직자') && !e.id.equals(loginEmpBase.id)}">
													<li><input class="chatMember" type="checkbox" id="${e.id}" name="member" value="${e.id}"><label for="${e.id}">${e.empName}</label></li>
												</c:if>
											</c:forEach>
										</ul>
									</div>	
									<label for="roomName">채팅방 이름</label>
									<input id="roomName" type="text" class="form" name="roomName" value="">
									<button id="createBtn" type="button" class="btn btn-secondary">개설하기</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="footer-wrap pd-20 mb-20 card-box">
			DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
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