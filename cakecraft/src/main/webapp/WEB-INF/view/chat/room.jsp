<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
<style>
</style>
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
							<h4>채팅</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/schedule/schedule">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/chat/rooms">Chat Rooms</a></li>
								<li class="breadcrumb-item active" aria-current="page">Chat</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<div class="bg-white border-radius-4 box-shadow mb-30">
				<div class="row">
					<div class="col-9">
						<div class="chat-detail">
							<div class="chat-profile-header clearfix">
								<div class="row">
									<div class="col left">
										<div class="clearfix">
											<div>
												<h3>${room.roomName}</h3>
											</div>
										</div>
									</div>
									<div class="col text-right">
										<div class="clearfix">
											<div>
												<button type="button" class="btn btn-sm btn-primary" id="leaveBtn">나가기</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="chat-box">
								<div class="chat-desc customscroll" id="scroll">
									<ul id="msgArea">
										<c:if test="${messageList != null }">
											<c:forEach var="m" items="${messageList}">
												<c:if test="${loginEmpBase.empName.equals(m.writer)}">
													<li class="clearfix admin_chat">
														<span class="chat-img">
															${m.writer}
														</span>
														<div class="chat-body clearfix">
															<p>${m.message}</p>
														</div>
													</li>
												</c:if>
												<c:if test="${!loginEmpBase.empName.equals(m.writer)}">
													<li class="clearfix">
														<span class="chat-img">
															${m.writer}
														</span>
														<div class="chat-body clearfix">
															<p>${m.message}</p>
														</div>
													</li>
												</c:if>
											</c:forEach>
										</c:if>
									</ul>
								</div>
								<div class="chat-footer">
									<div class="col-10 chat_text_area ml-3">
										<textarea id="msg" placeholder="메시지를 입력하세요"></textarea>
									</div>
									<div class="col-2 chat_send">
										<button class="btn btn-link" id="sendBtn" type="button"><i class="icon-copy fa fa-send" aria-hidden="true"></i></button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col card px-0">
						 <div class="card-header bg-secondary text-white">참여인원</div>
						<div class="card-body">
							<ul>
								<c:forEach var="m" items="${memberList}">
									<li>
										<span class="chat-img">
											<img width="20px" height="20px" src="${pageContext.request.contextPath}/profileImg/${m.profileFilename}">
										</span>
										${m.empName}
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 푸터 시작 -->
<c:import url="/layout/footer.jsp"></c:import>
<!-- 푸터 끝 -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
	//스크롤바 위치 조정
	$('#scroll').scrollTop($('#scroll')[0].scrollHeight);

	const roomName = '${room.roomName}';
	const roomId = '${room.roomId}';
	const username = '${loginEmpBase.empName}';
	
	console.log(roomName + ", " + roomId + ", " + username);
	
	//1. websocket 내부에 들고있는 stomp를 내어준다
	const websocket = new WebSocket("ws://43.202.82.110:80/cakecraft/stomp");
	const stomp = Stomp.over(websocket);
	
	//2. connection이 맺어지면 실행
	stomp.connect({}, function(){
		console.log("STOMP Connection")
		
		//4.subscribe(path, callback)으로 메시지를 받을 수 있다
		stomp.subscribe('/sub/chat/room'+roomId, function(chat){
			let content = JSON.parse(chat.body);
			let writer = content.writer;
			let message = content.message;
			let str = '';
			
			if(writer === username){
				str = "<li class='clearfix admin_chat'>";
				str += "<span class='chat-img'>" + writer + "</span>";
				str += "<div class='chat-body clearfix'>"
				str += "<p> "+message+ "</p></div></li>";
			} else{
				str = "<li class='clearfix'>";
				str += "<span class='chat-img'>" + writer + "</span>";
				str += "<div class='chat-body clearfix'>"
				str += "<p> "+message+ "</p></div></li>";
			}
			
			$('#msgArea').append(str);
			$('#msgArea').scrollTop($('#msgArea')[0].scrollHeight);
		})
		
		//3.send(path, header, message)로 메세지를 보낼 수 있다
		stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
		//roomId와 usename정보를 JSON형식으로 바꾸어 전송
	})
	
	$('#sendBtn').click(function(){
		let msg = $('#msg').val();
		console.log(username + ':' + msg);
		stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg, writer: username}))
		$.ajax({
			url : '${pageContext.request.contextPath}/chat/addMessage',
			type : 'post',
			data : {
				roomId : roomId,
				message : msg,
				writer : username,
				regId : ${loginEmpBase.id}
			},
			success : function(){
				console.log('ajax성공');
			},
			error : function(){
				console.log('ajax실패');
			}
		})
		$('#msg').val('');
		$('#scroll').scrollTop($('#scroll')[0].scrollHeight);
	})
	
	$('#leaveBtn').click(function(){
		swal({
			title: '채팅방을 나가시겠습니까?',
			text: "",
			type: 'warning',
			confirmButtonText: '예',
			cancelButtonText: '아니오',
			showCancelButton: true,
		}).then((result) => {
			console.log(result);
			if (result.value == true) {
				window.location.href = "${pageContext.request.contextPath}/chat/removeChatRoom?roomId="+roomId+"&roomMember=${loginEmpBase.id}";
			}
		});
	})
	
</script>
</body>
</html>