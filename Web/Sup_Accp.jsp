<%@page import="java.sql.*"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% LoginManager loginManager = LoginManager.getInstance(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/sup_style.css" rel="stylesheet" type="text/css">
<title>RoomShare</title>

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
		String rid = request.getParameter("rid");
		
		String sql = "select room_title from room_info where RoomID ='" +rid+"'";
		Statement st = null;
		st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		String rname = null;
		
		//get room title
		if(rs.next())
			rname = rs.getString(1);
		
		//get reserve info
		sql = "select guestID,StartDate,EndDate,reserveNum from room_reserve_info where RoomId = '" + rid +"' and conform = '0'";
		rs = st.executeQuery(sql);
		
		
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
		<table>
			<caption style="font-weight: bold; font-size: 160%; padding: 5px"><%=rname %>
				신청내역</caption>
			<tbody>
				<tr>
					<th>날짜</th>
					<th>신청자</th>
					<th>승인/거절</th>
				</tr>
				<%
				while(rs.next()) {
				String guestID = rs.getString(1);
				String sdate = rs.getString(2);
				String edate = rs.getString(3);
				String resn = rs.getString(4);
				
				%>
				<td> <%=sdate %> ~ <%=edate %></td><td> <a href = "Look_Acco.jsp?uid=<%=guestID%>" style = "font-decoration : none;" 
				onmouseover="this.style.color='gray'" onmouseout="this.style.color='black'"><%=guestID%></a>
						</td> <td>
						
						<a href = "Res_yes.jsp?rnum=<%=resn%>" style = "font-decoration : none; background-color : blue; color:white;">승인</a> 
						<a href = "Res_no.jsp?rnum=<%=resn%>" style = "font-decoration : none; background-color : red; color:white;">거절</a>
				</td></tr>
				<%
				}
				%>
				
			</tbody>
		</table>

	</div>
	</div>

	<!--logout function-->
	<script>
		document.getElementById("log").addEventListener("click", logout);
		
		
	</script>

</body>

</html>