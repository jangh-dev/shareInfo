<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#wrapper{
	text-align:center;
	width: 600px; height: 300px;
	margin: 0 auto;
	border: double 5px red;
	margin-top: 10%;
}
hr{
	border-color: pink;
	text-decoration: none;
}

#line{
	float: left;
	width: 50px;
	
}

td{
	width: 100px;
}
a{
	text-decoration: none;
}

</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script src="resources/js/sockjs.js"></script>
<script src="resources/js/stomp.js"></script>
<script type="text/javascript">
	$(function(){
		connect();
	});

	var sock;

	function connect(){
		sock = new SockJS("stomp");
		var client = Stomp.over(sock);

		client.connect({},function(){
			client.subscribe("/topic/message/1", function(event){var body = JSON.parse(event.body); alert(body.roomid+"로부터 "+body.message)});
			client.subscribe("/topic/message/2", function(event){var body = JSON.parse(event.body); alert(body.roomid+"로부터 "+body.message)});
			client.subscribe("/topic/message/3", function(event){var body = JSON.parse(event.body); alert(body.roomid+"로부터 "+body.message)});
		});
	}

</script>
</head>
<body>
	
	<div id="wrapper">
		<div>
			<h2>[ 게시판 ]</h2>
			<hr>
			<c:if test="${sessionScope.member.id == null}"><p>로그인을 해주세요</p></c:if>
			<c:if test="${sessionScope.member.id != null}"><p>${sessionScope.member.username}님, 안녕하세요</p></c:if>
			<a href="chat">채팅</a>
		</div>
		<div style="margin-top: 10%;">
		<table style="width: 500px; text-align: center; margin: 0 auto;">
			<tr>
				<c:if test="${sessionScope.member.id == null}">
				<td>
					<a href="signup">
					<img alt="signup" src='<c:url value="/resources/images/signup.png"/>' style="width: 55px; height: 50px;"><br>
					회원가입
					</a>
				</td>
				</c:if>
				
				<c:if test="${sessionScope.member.id == null}">
				<td>
					<a href="login">
					<img alt="login" src='<c:url value="/resources/images/login.png"/>' style="width: 50px; height: 50px;"><br>
					로그인
					</a>
				</td>
				</c:if>
				
				<c:if test="${sessionScope.member.id != null}">
				<td>
					<a href="logout">
					<img alt="logout" src='<c:url value="/resources/images/logout.png"/>' style="width: 50px; height: 50px;"><br>
					로그아웃
					</a>
				</td>
				</c:if>
				
				<c:if test="${sessionScope.member.id != null}">
				<td>
					<a href="modify">
					<img alt="modify" src='<c:url value="/resources/images/modify.png"/>' style="width: 50px; height: 50px;"><br>
					개인정보 수정
					</a>
				</td>
				</c:if>
				
				<c:if test="${sessionScope.member.id != null}">
<%-- 				<c:if test="${sessionScope.member.id == null}"> --%>
				<td>
					<a href="boardlist">
					<img alt="board" src='<c:url value="/resources/images/board.png"/>' style="width: 50px; height: 50px;"><br>
					게시판
					</a>
				</td>
				</c:if>
				
				<td>
					<a href="guestbook">
					<img alt="guestbook" src='<c:url value="/resources/images/guestbook.png"/>' style="width: 50px; height: 50px;"><br>
					방명록
					</a>
				</td>
			</tr>
		</table>
		</div>
		<div style="width: 600px; margin: 0 auto; text-align: center; margin-top: 30px;">
			<input id="create" type="button" value="채팅방 생성">
			<div id="list">
				<a href="chat?roomid=1">1</a>
				<a href="chat?roomid=2">2</a>
				<a href="chat?roomid=3">3</a>
			</div>
		</div>
	</div>
</body>
</html>