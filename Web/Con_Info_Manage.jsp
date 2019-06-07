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
	function checkpw() {
		var pw = document.getElementById('PW').value;
		var pwch = document.getElementById('PWch').value;

		if (pw != pwch) {
			alert("비밀번호가 일치하지 않습니다.");
			document.getElementById("PW").focus();
		} else {
			alert("비밀번호가 일치합니다.");
			document.getElementById("name").focus();
		}

	}
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

			String sql = "select ID, PW, Username, state, tel from account where id = '" + Id + "'";
			Statement stmt = null;
			stmt = con.createStatement();
			ResultSet rs = null;
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
			String name = null;
			String tel = null;
			String pw = null;
			String id = null;
			int st = 0;

			if (rs.next()) {
				id = rs.getString("ID");
				pw = rs.getString("PW");
				name = rs.getString("Username");
				st = rs.getInt("state");
				tel = rs.getString("tel");
			}
	%>

	<!--header-->
	<div class="header">
		<a href="Con_Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Con_Appo.jsp">이용내역</a></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Con_Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>


<!--center-->
	<form action="Info_process.jsp" method="post">
		<fieldset>
			<h3>내 별점</h3>
			3.3 / 5 점
		</fieldset>
		<fieldset>
			<h3>개인정보관리</h3>
			<div>
				<p>
					ID <input type="text" id="ID" name="ID" value="<%=id%>"
						readonly> 
					PW <input type="password" id="PW" name="PW"
						value="<%=pw%>" required> 
					<input type="password"
						id="PWcheck" name="db_PWch" value="<%=pw%>" required>
				</p>
				<button class="btn" type="button" onclick="checkpw()">비밀번호
					확인</button>
				<p>
					NAME <input type="text" id="name" name="name" value="<%=name%>"
						required>
				</p>
				<%
					if (st == 1)
						out.println("<p><input type = 'text' name = 'type' value = 'consumer' readonly></p>");
					else
						out.println("<p><input type = 'text' name = 'type' value = 'provider' readonly></p>");
				%>
				<p>
					TEL <input type="tel" id="tel" name="tel" value="<%=tel%>"
						required>
				</p>
				<br>
				<p>
					<button class="btn" type="submit">수정</button>
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