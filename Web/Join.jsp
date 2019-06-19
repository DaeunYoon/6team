<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	function checkpw() {
		var pw = document.getElementById('PW').value;
		var pwch = document.getElementById('PWch').value;
		var ck = 0;
		var ck2 = 0;
		var i = 0;
		if (!pw) {
			alert("비밀번호를 입력하세요.");
			document.getElementById("PW").focus();
			return;
		}
		if (pw.length < 8) {
			alert("pw는 8자 이상 15이하로 입력하여 주십시오.");
			return;
		}
		//

		for (i = 0; i < pw.length; i++) {
			var c = pw.charAt(i);
			if ((c == '@' || c =='!' || c == '?')) {
				ck = 1;
				break;
			}
		}
		
		for (i = 0; i < pw.length; i++) {
			if ((pw.charCodeAt(i) < 0x5A && pw.charCodeAt(i) > 0x2f)) {
				ck2 = 1;
				break;
			}
		}

		if (ck == 0 || ck2 == 0) {
			alert("비밀번호에는 하나 이상의 특수문자( ? ! @)와 숫자가 포함되어야합니다. " + pw);
			return;
		}

		if (pw != pwch) {
			alert("비밀번호가 일치하지 않습니다.");
			document.getElementById("PW").focus();
			document.getElementById("state").value = "0";
		} else {
			alert("비밀번호가 일치합니다.");
			document.getElementById("name").focus();
			document.getElementById("state").value = "1";
		}
	}

	function ch_email() {
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (exptext.test(document.getElementById("ID").value) != true) {
			alert('이메일 형식이 올바르지 않습니다.');
			document.userInsertForm.oemail.focus();
			document.getElementById("ns").value = "0";
		}
		else {
			alert('올바른 이메일 형식입니다.');
		document.getElementById("ns").value = "1"; //맞으면 1
		}
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/style1.css" rel="stylesheet" type="text/css">
<title>RoomShare</title>
</head>
<body>

	<%
		/*db connection*/
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC", "root",
				"1234");
	%>

	<!--header-->
	<div class="header">
		<h1>Room&nbsp;Share</h1>
		<h2 style="align-content: center;">JOIN US</h2>
	</div>

	<!--center-->
	<div class="container">
		<form action="Join_process.jsp" method="post" name="userInsertForm">
			<fieldset>
				<h3>Join</h3>
				<div>
					<p>
						<input type="hidden" id="ns" name="ns" value="0"> <input
							type="hidden" id="state" name="state" value="0"> <input
							type="text" id="ID" name="ID" placeholder="ID (email)" required>
						<button class="btn" type="button" onclick="ch_email()">이메일
							확인</button>
						<input type="password" id="PW" name="PW" placeholder="PW"
							maxlength="15" required> <input type="password" id="PWch"
							name="PWch" maxlength="15" placeholder="PW CHECK" required>
					</p>
					<button class="btn" type="button" onclick="checkpw()">비밀번호
						확인</button>

					<p>
						<input type="text" id="name" name="name" placeholder="NAME"
							required>
					</p>
					<p>
						<input type="tel" name="tel" placeholder="TELEPHONE NUM" required>
					</p>
					<br>
					<p>
						<input type="radio" name="type" value="consumer">소비자<br>
						<input type="radio" name="type" value="supplier">공급자<br>
					</p>
					<br>
					<p>
						<button class="btn" type="submit">입력</button>
					</p>
				</div>
			</fieldset>




		</form>
	</div>
</html>