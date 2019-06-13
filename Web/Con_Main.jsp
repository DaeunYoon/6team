<%@page import="java.sql.*"%>
<%@page import="login.LoginManager"%>
<%
	LoginManager loginManager = LoginManager.getInstance();
%>
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
	<div class="container">
		<div class="contents">
			<div class="search">
				<form>
					<select>
						<option value="search_all">전체</option>
						<option value="search_date">날짜</option>
						<option value="search_person">인원</option>
						<option value="search_location">위치</option>
					</select> <input type="text">
					<button type="button" onclick="alert('Hello world')">검색</button>
				</form>
			</div>
		</div>
	</div>

	<form action="Room_Info.jsp" method="post">
		<div class="room_grid">

			<div class="room_all">

				<table>
				<caption style="font-weight: bold; font-size: 160%; padding: 5px">방정보</caption>
				<tread>
				<tr>
					
					<th>방이름</th>
					<th>가격</th>
					<th>방주인</th>
					<th>별점</th>
					<th>상세정보</th>
					
				</tr>
				</tread>
				<tbody>
					
			

			
				<%
					String title = null, host = null, addr = null, rid = null;
					int price = 0;
					double score = 0;

					String sql = "select RoomID,room_title, hostID, cost, add1, add2, add3, add4, roomscore from room_info";
					Statement stmt = null;
					stmt = con.createStatement();
					ResultSet rs = null;
					rs = stmt.executeQuery(sql);
					System.out.println(sql);

					while (rs.next()) {
						rid = rs.getString("RoomID");
						title = rs.getString("room_title");
						host = rs.getString("hostID");
						for (int i = 1; i < 5; i++)
							addr += rs.getString("add" + i);
						price = rs.getInt("cost");
						score = rs.getDouble("roomscore");
						
						out.println("<tr><td><class='room_tit'><strong>" + title + "</strong></td> <td><span class='roomprice'>" + price
								+ "</span></td> <td><span class='room_host'>" + host + "</span></td> <td><span class='room_score'>" + score
								+ "</span></td><td><button type = 'submit' name = 'rid' value = '"+rid+"'<td>detail</tr>");
					}

					
				%>
					</tbody>
					</table>
			</div>


		</div>
	</form>

	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>
</body>