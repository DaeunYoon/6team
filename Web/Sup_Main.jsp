<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% LoginManager loginManager = LoginManager.getInstance(); %>
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
			response.sendRedirect("logout.jsp");
		} //세션 아이디가 로그인아니면
		String Id = null; //initializie to 0
		Id = (String) session.getAttribute("ID");
		/*db connection*/
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC", "root",
				"1234");
		System.out.println(Id);
		
		String sql = "select roomID from room_info where hostID = '" + Id + "'" ;
		Statement st = null;
		st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		System.out.println(sql);
				
	%>

	<!--header-->
	<div class="header">
		<a href="Sup_Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_New_Posting.jsp">새글쓰기</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_Res_History.jsp">이용내역</a></span>
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
						out.print("<tr><td><a href = 'Sup_Room_Info.jsp?rid="+ rid +"' style='text-decoration:none'>" + title +"</a></td>" );
						
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
		
					rs.close();
					st.close();
					con.close();
					%>
				</tbody>
			</table>
		</form>


		<!--logout function-->
		<script>
			document.getElementById("log").addEventListener("click", logout);
		</script>
</body>

</html>