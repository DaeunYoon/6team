<%@page import="java.sql.*"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
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

		//get id and pw
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		//check input id and pw
		if (id == "" || pw == "") {
			out.println("<script>alert('ID와 PW를 입력하세요!'); location.href='Main(common).jsp'</script>");
		}

		//check id and pw are correct
		String sql = "SELECT ID, PW " + "FROM Account" + " WHERE EXISTS" + " (SELECT * FROM Account WHERE"
				+ " ID = '" + id + "'" + " And PW = '" + pw + "')";

		Statement stmt = null;
		stmt = con.createStatement();

		ResultSet rs = null;
		rs = stmt.executeQuery(sql);

		if (rs.next()) {
			//login success

			sql = "SELECT state, report From Account Where ID = '" + id + "'";
			rs = stmt.executeQuery(sql);

			LoginManager loginManager = LoginManager.getInstance();
			int st = 3;
			int rp = 0;

			while (rs.next()) {
				st = rs.getInt(1);
				rp = rs.getInt(2);
			}

			if (rp > 5) {
				System.out.println("신고횟수: " + rp);	
				%>
				<script>
				alert('다섯번이상 경고를 받은 회원은 로그인할 수 없습니다.');
				location.href('Main(common).jsp');
				</script>
				<%
			} 
			else {
				loginManager.setSession(session, id);
				session.setAttribute("ID", id);
				if (st == 1 || st == 0)
					response.sendRedirect("Main.jsp");
				else
					System.out.println("error!");
			}
		} 
		else {
			//login fail
			out.println("<script>alert('Id or Password Error !'); location.href='Main(common).jsp'</script>");
		}

		stmt.close();
		con.close();
	%>

</body>

</html>