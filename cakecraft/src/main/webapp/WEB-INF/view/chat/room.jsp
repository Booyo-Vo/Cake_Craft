<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
<style>
	#msgArea{
		height: 300px;
		overflow-y: scroll;
	}
</style>
</head>
<body>
<c:import url="/layout/header.jsp"></c:import>
<div class="main-container">
	<div class="col-6">
		<label><b>${room.roomName}</b></label>
	</div>
	<div>
		<div id="msgArea" class="col">
			<c:if test="${messageList != null }">
				<c:forEach var="m" items="${messageList}">
					<c:if test="${loginEmpBase.id eq m.writer}">
						<div class="col-6">
							<div class='alert alert-secondary'>
								<b>${m.writer} : ${m.message}</b>
							</div>
						</div>
					</c:if>
					<c:if test="${!loginEmpBase.id eq m.writer}">
						<div class="col-6">
							<div class='alert alert-warning'>
								<b>${m.writer} : ${m.message}</b>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
		<div>
		<div class="col-6">
			<div class="input-group mb-3">
			<input type="text" id="msg" class="form-control">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" id="sendBtn">전송</button>
				</div>
			</div>
		</div>
</div>
<div class="col-6"></div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
	const roomName = '${room.roomName}';
	const roomId = '${room.roomId}';
	const username = '${loginEmpBase.empName}';
	
	console.log(roomName + ", " + roomId + ", " + username);
	
	//1. websocket 내부에 들고있는 stomp를 내어준다
	const websocket = new WebSocket("ws://localhost:80/cakecraft/stomp"); //배포 전 배포주소로 바꾸기
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
				str = "<div class='col-6'>";
				str += "<div class='alert alert-secondary'>";
				str += "<b>" + writer + " : " + message + "</b>";
				str += "</div></div>";
			} else{
				str = "<div class='col-6'>";
				str += "<div class='alert alert-warning'>";
				str += "<b>" + writer + " : " + message + "</b>";
				str += "</div></div>";
			}
			
			$('#msgArea').append(str);
			$('#msgArea').scrollTop($('#msgArea')[0].scrollHeight); //가장 아래의 채팅을 보여주기 위함
		})
		
		//3.send(path, header, message)로 메세지를 보낼 수 있다
		stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
		//roomId와 usename정보를 JSON형식으로 바꾸어 전송
	})
	
	$('#sendBtn').click(function(){
		let msg = $('#msg').val();
		console.log(username + ':' + msg);
		stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg, writer: username}))
		$('#msg').val('');
	})
</script>
</body>
</html>