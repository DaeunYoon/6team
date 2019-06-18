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
	function logout()
	{
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
	
	function expireSession()
	{
		alert("로그인 시간이 만료되었습니다. 다시 로그인해주세요");
		location.href = "logout.jsp";
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
		
		String sql = "select state from account where id = '" + Id + "'";
		Statement stmt = null;
		stmt = con.createStatement();
		ResultSet rs = null;
		rs = stmt.executeQuery(sql);
		
		int st = 0;
		if(rs.next())
			st = rs.getInt("state");
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

					sql = "select RoomID,room_title, hostID, cost, add1, add2, add3, add4, roomscore from room_info";
					stmt = con.createStatement();
					rs = null;
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
	<%}
		
		else {
			sql = "select roomID from room_info where hostID = '" + Id + "'" ;
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			System.out.println(sql);
		%>
		
		<!--header-->
	<div class="header">
		<a href="Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_New_Posting.jsp">새글쓰기</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="App_History.jsp">이용내역</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<br>

	<!--center-->
	<div class="container">
		<form action = "Sup_Accp.jsp" method = "post">
			<table>
				<caption style="font-weight: bold; font-size: 160%; padding: 5px">예약신청내역</caption>
				<tbody>
					<tr>
						<th>방정보</th>
						<th>신청인원</th>
					</tr>
					
					<%
					while(rs.next())
					{
						int rid = 0;
						rid = rs.getInt(1);
						
						
						String sql2 = "select room_title from room_info where RoomID = '" + rid +"'";
						Statement st2 = null;
						st2 = con.createStatement();
						ResultSet rs2 = st2.executeQuery(sql2);
						String title = null;
						if(rs2.next())
							title = rs2.getString(1);
						out.print("<tr><td><a href = 'Room_Info.jsp?rid="+ rid +"' style='text-decoration:none' onmouseover=\"'this.style.color='gray'\" onmouseout=\"this.style.color='black'\">" + title +"</a></td>" );
						
						sql2 = "select Count(guestID) from room_reserve_info where RoomID = '" + rid +"' and conform = '0'";

						rs2 = st2.executeQuery(sql2);
						System.out.println(sql2);
						int n = 0;
						if(rs2.next())
							n = rs2.getInt(1);
						if(n!=0)
							out.println("<td><button type='submit' name='rid' value='"
								+ rid +"' style='border: 0px; width: 30px;'>"+ n +"</button></td></tr>");
						else
							out.println("<td>0</td></tr>");
						st2.close();
						rs2.close();
						
					}
					%>
				</tbody>
			</table>
		</form>
		
		
		<%
		} 
		stmt.close();
		rs.close();
		con.close();
		%>

	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>
</body>