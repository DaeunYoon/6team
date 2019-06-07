<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
				href="Sup_Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<br>

	<!--center-->
	<div class="container">
		<form>
			<table>
				<caption style="font-weight: bold; font-size: 160%; padding: 5px">예약신청내역</caption>
				<tbody>
					<tr>
						<th>방정보</th>
						<th>신청인원</th>
					</tr>
					<tr>
						<td>1번방</td>
						<td><button type="button" name="rname" value="1번방"
								onclick="location.href='Sup_Accp.jsp'"
								style="border: 0px; width: 30px;">3</button></td>
					</tr>
					<tr>
						<td>2번방</td>
						<td><button type="button" name="rname" value="1번방"
								onclick="location.href='Sup_Accp.jsp'"
								style="border: 0px; width: 30px;">3</button></td>
					</tr>
				</tbody>
			</table>
		</form>


		<!--logout function-->
		<script>
			document.getElementById("log").addEventListener("click", logout);
		</script>
</body>

</html>