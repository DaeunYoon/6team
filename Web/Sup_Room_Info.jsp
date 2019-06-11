<%@page import="java.sql.*"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	LoginManager loginManager = LoginManager.getInstance();
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

		String title = null, host = null, addr = null;
		int price = 0, broom = 0, kit = 0, inter = 0, park = 0;
		double score = 0;

		String rid = request.getParameter("rid");

		String sql = "select room_title, hostID, cost, add1, add2, add3, add4, roomscore from room_info where roomid = '"
				+ rid + "'";
		Statement stmt = null;
		stmt = con.createStatement();
		ResultSet rs = null;
		rs = stmt.executeQuery(sql);

		if (rs.next()) {
			title = rs.getString("room_title");
			host = rs.getString("hostID");
			for (int i = 1; i < 5; i++)
				if (i == 1)
					addr = rs.getString("add" + i) + " ";
				else
					addr += rs.getString("add" + i) + " ";
			price = rs.getInt("cost");
			score = rs.getDouble("roomscore");

		}

		sql = "select * from room_option where roomid = '" + rid + "'";
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);

		if (rs.next()) {
			broom = rs.getInt("BedNumber");
			kit = rs.getInt("Kitchen");
			inter = rs.getInt("internet");
			park = rs.getInt("parking");
		}
	%>

	<div class="header">
		<a href="Sup_Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_New_Posting.jsp">새글쓰기</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_Res_History.jsp">이용내역</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<br>

	<!--center-->
	<div class="container">
		<div class="contents">

			<div class="room_info_contents"
				style="margin-top: 24px; box-sizing: border-box; overflow: hidden;">
				<div class="roon_info_contents_left"
					style="margin: auto; text-align: center">
					<div style="font-size: 24px">
						<strong><%=title%></strong>
					</div>

					<div
						style="font-size: 12px; border-bottom: 1px solid #c2c2c2; padding-bottom: 4px;">
						<%=host%>
					</div>


					<div style="margin-top: 24px;"><%=addr%></div>

					<div style="margin-top: 24px">
						기타정보 <br> <span>침실수 : <%=broom%></span> <span>부엌</span>
						<%
							if (kit == 1)
								out.println("O");
							else
								out.println("X");
						%>
						<span>인터넷</span>
						<%
							if (inter == 1)
								out.println("O");
							else
								out.println("X");
						%>
						<span>주차장</span>
						<%
							if (park == 1)
								out.println("O");
							else
								out.println("X");
						%>

					</div>
				</div>

				<div style="width: 100%; box-sizing: border-box; padding: 16px;">
					<div style="margin: auto; text-align: center">
						<span style="font-size: 24px;"><strong><%=price%>원</strong></span>
						<span>/박</span>
					</div>
					<div style="margin: auto; text-align: center;">
						<%=score%>
						/ 10
					</div>
				</div>



	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>
</body>


</html>