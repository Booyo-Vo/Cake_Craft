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
	<div class="col-6">
		<label><b>채팅방</b></label>
	</div>
	<div>
		<div id="msgArea" class="col">
		</div>
		<div class="col-6">
			<div class="input-group mb-3">
				<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	const username = '${loginEmpBase.empName}';
	
	$("#disconn").click(function(){
		disconnect();
	})
	
	$("#button-send").click(function(){ 
		send(); //전송버튼을 누르면 send()함수 실행
	})
	
	const websocket = new WebSocket("ws://localhost:80/cakecraft/ws/chat/chat");
	
	websocket.onmessage = onMessage;
	websocket.onopen = onOpen;
	websocket.onclose = onClose;
	
	function send(){ 
	
	    let msg = $('#msg').val();
	
	    console.log(username + ":" + msg);
	    websocket.send(username + ":" + msg); //해당 메시지를 websocket으로 전송
	    $('#msg').val(''); //입력창을 공백으로 만든다
	}
	
	//채팅창에서 나갔을 때
	function onClose(evt) {
	    let str = username + ": 님이 방을 나가셨습니다.";
	    websocket.send(str); //websocket으로 방을 나갔다는 메시지 전송
	}
	
	//채팅창에 들어왔을 때
	function onOpen(evt) {
	    let str = username + ": 님이 입장하셨습니다.";
	    websocket.send(str); //websocket으로 방에 입장했다는 메시지 전송
	}
	
	function onMessage(msg) { //전송된 메시지를 받아서
	    let data = msg.data; //그 중 보낸 메시지 정보를 반환
	    let sessionId = null;
	    //데이터를 보낸 사람
	    let message = null;
	    let arr = data.split(":"); //data에서 username과 메세지를 나눈다
	
	    for(let i=0; i<arr.length; i++){
	        console.log('arr[' + i + ']: ' + arr[i]);
	    }
	
	    var cur_session = username;
	
	    //현재 세션에 로그인 한 사람
	    console.log("cur_session : " + cur_session);
	    sessionId = arr[0];
	    message = arr[1];
	
	    console.log("sessionID : " + sessionId);
	    console.log("cur_session : " + cur_session);
	
	    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	    if(sessionId == cur_session){ //나의 메시지 표시
	        let str = "<div class='col-6'>";
	        str += "<div class='alert alert-secondary'>";
	        str += "<b>" + sessionId + " : " + message + "</b>";
	        str += "</div></div>";
	        $("#msgArea").append(str);
	    }
	    else{ //다른 사람의 메시지 표시
	        let str = "<div class='col-6'>";
	        str += "<div class='alert alert-warning'>";
	        str += "<b>" + sessionId + " : " + message + "</b>";
	        str += "</div></div>";
	        $("#msgArea").append(str);
	    }
	}
</script>
</body>
</html>