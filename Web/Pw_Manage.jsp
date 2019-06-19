<%@page import="java.sql.*"%>
<%@page import="login.LoginManager"%>
<% LoginManager loginManager = LoginManager.getInstance(); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/style1.css" rel="stylesheet" type="text/css">
<link href="css/sup_style.css" rel="stylesheet" type="text/css">
<script>
	function logout() {
		var conf = confirm("logout하시겠습니까 ? ");
		//확인
		if (conf) {
			location.href = "logout.jsp";

		}
		//취소
		else {
			//이전으로 돌아가기
		}
	}
	
	var ck = 0;
	var ck2 = 0;
	function checkpw()
	{
		var pw = document.getElementById("PW").value;
		var pwch = document.getElementById("PWcheck").value;
		
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
			alert("비밀번호에는 하나 이상의 특수문자( ? ! @)와 숫자가 포함되어야합니다. ");
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
	
	
	
	function expireSession()
	{
		alert("로그인 시간이 만료되었습니다. 다시 로그인해주세요");
		location.href = "Login.jsp";
		session.invalidate();
	}
	setTimeout('expireSession()', <%= request.getSession().getMaxInactiveInterval() * 60 %>);
</script>
<title>RoomShare</title>
</head>
<body>

	<%
	//get ID value
			if (!loginManager.isLogin(session.getId())) {
				throw new Exception("");
			} //세션 아이디가 로그인아니면
			String Id = null; //initializie to 0
			Id = (String) session.getAttribute("ID");
			/*db connection*/
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC", "root",
					"1234");

			String sql = "select PW,state from account where id = '" + Id + "'";
			Statement stmt = null;
			stmt = con.createStatement();
			ResultSet rs = null;
			rs = stmt.executeQuery(sql);

			String pw = null;

			int st = 0;

			if (rs.next()) {
				pw = rs.getString("PW");
				st = rs.getInt("state");
			}
			
			if(st == 1) {
	%>
	<script>
	function checkForm()
	{
		if(ck == 1 && ch2 ==1)
			return true;
		else {
			alert("비밀번호 확인이 일치하지 않습니다");
			return false;
		}		
	}
</script>
	<!--header-->
	<div class="header">
		<a href="Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span><a href="Con_Appo.jsp">예약신청내역</a></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span><a href="App_History.jsp">완료내역</a></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span><a href="Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<%
			}
			else {
	%>
	<div class="header">
		<a href="Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_New_Posting.jsp">새글쓰기</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="App_History.jsp">이용내역</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<%
			}
	%>

<!--center-->
	<form action="Info_process.jsp" method="post">
		<fieldset>
			<h3>개인정보관리</h3>
			<div>			
				<p>
					새로운 PW <input type="password" id="PW" name="PW"
						 required> 
					PW 확인 <input type="password"
						id="PWcheck" name="db_PWch" required>
				</p>
				<button class="btn" type="button" onclick="checkpw()">비밀번호
					확인</button>
					<button class="btn" type="submit" onclick = "if(!checkForm()) return false;">수정</button>
				</p>
			</div>
		</fieldset>
	</form>
	<%
		rs.close();
		stmt.close();
		con.close();
	%>

	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>




</body>