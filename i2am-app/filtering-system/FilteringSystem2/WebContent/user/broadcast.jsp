<%@page import="knu.cs.dke.prog.esper.EsperEngine"%>
<%@page import="knu.cs.dke.prog.util.Constant" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script>
history.pushState(null, null, location.href); 
window.onpopstate = function(event) { 
history.go(1); 
}
</script>
<meta charset="UTF-8" >
<title>�ǽð� ���͸�</title>

</head>
<body onload="document.broadcasting.reset();">
	<form name='broadcasting'>
		<!-- �۽� �޽��� �ۼ��ϴ� â -->
		<!-- <input id="textMessage" type="text"> -->
		<!-- �۽� ��ư -->
		<!-- <input onclick="sendMessage();disconnect();" value="Start" type="button">-->
		<!-- ���� ��ư -->
		<br><br>
		<p align='center'>
		<% if(Constant.InputType.equals("input_file")){ %>
		<!-- ���� input�϶�-->
		<img align='center' src='image/save.png' width='50' onclick="disconnect();location.href='..\\return_file?file=1'">
		<% } else {%>
		<!-- �ӽ÷� �� ���Ŀ� �ý��� ���� ��, �ǽð� ���·� ������ ������ ���͸� ��� ������ �ٽ� �����ؾ� �� -->
		<img align='center' src='image/save.png' width='50' onclick="disconnect();location.href='..\\return_file?file=1'">
		<!-- <input type='button' name ='file' onclick="disconnect();location.href='..\\setting?file=1'" value='���� �� ����'> -->
		<% } %>
		<!-- ó�� �������� -->
		<img align='center' src='image/home.png' width='50' onclick="disconnect();location.href='..\\return_file?file=0'">
		<!-- �ǵ�� -->
		<img align='center' src='image/feedback.png' height='45' >
		<br />
		</p>
	<!-- ��� �޽��� �����ִ� â -->
	<p align='center'>
	<textarea id="messageTextArea" rows="50" cols="100"></textarea>
	</p>
	</form>
	

	<script type="text/javascript">
	
        //WebSocketEx�� ������Ʈ �̸�
        //websocket Ŭ���� �̸�
        var webSocket = new WebSocket("ws://SERVER_IP:PORT/FilteringSystem/user/broadcasting_web");
        var messageTextArea = document.getElementById("messageTextArea");
        //�� ������ ����Ǿ��� �� ȣ��Ǵ� �̺�Ʈ
        webSocket.onopen = function(message){
            //messageTextArea.value += "Server connect...\n";
        };
        //�� ������ ������ �� ȣ��Ǵ� �̺�Ʈ
        webSocket.onclose = function(message){
        	//alert("ininninini");
            //messageTextArea.value += "Server Disconnect...\n";
        };
        //�� ������ ������ ���� �� ȣ��Ǵ� �̺�Ʈ
        webSocket.onerror = function(message){
            messageTextArea.value += "error...\n";
        };
        //�� ���Ͽ��� �޽����� ������� �� ȣ��Ǵ� �̺�Ʈ
        webSocket.onmessage = function(message){
            //messageTextArea.value += "Recieve From Server => "+message.data+"\n";
        	 messageTextArea.value += message.data+"\n";
        };
        //Send ��ư�� ������ ����Ǵ� �Լ�
        function sendMessage(){
            //var message = document.getElementById("textMessage");
            //messageTextArea.value += "Send to Server => "+message.value+"\n";
            //���������� textMessage��ü�� ���� ������.
            messageTextArea.value += "Send to Server => disconnect\n";
            webSocket.send("disconnect");
            //textMessage��ü�� �� �ʱ�ȭ
            //message.value = "";
        }
        //������ ����
        function disconnect(){
            webSocket.close();
            
        }
    </script>
</body>
</html>