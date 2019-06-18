<%@page import="java.sql.*"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	LoginManager loginManager = LoginManager.getInstance();
//consumer의 정보 사용자가 볼 수 있는 페이지
%>
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

		String id = request.getParameter("uid");
		String sql = "select * from account where id = '" + id + "'";
		System.out.println(sql);
		Statement stmt = null;
		stmt = con.createStatement();
		ResultSet rs = null;
		rs = stmt.executeQuery(sql);
		String name = null;
		String tel = null;
		String pw = null;
		double eval = 0.0;
		int st = 0;

		if (rs.next()) {
			st = rs.getInt("state");
			name = rs.getString("Username");
			tel = rs.getString("phonenumber");
			eval = rs.getDouble("evaluation");
		}

	if(st == 1) {
	%>

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

	<br>

	<!--center-->
	<form action="Info_process.jsp" method="post">
		<fieldset>
			<h3> 별점</h3>
			<%=eval %> / 5 점
		</fieldset>
		<fieldset>
			<h3>개인정보열람</h3>
			<div>
				<p>
					<h4>ID</h4> <%=id%> <br> <br>
				</p>
					<h4>NAME</h4> <%=name %> <br> <br>
				</p>
				<p>
					<h4>TEL</h4> <%=tel%> <br>
						
				</p>
			</div>
		</fieldset>
	</form>
	<%
		rs.close();
		stmt.close();
		con.close();
	%>

	<!--logout function-->
	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>
</body>

</html>