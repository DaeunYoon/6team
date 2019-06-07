<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
				href="Sup_Info_Manage.jsp">개인정보관리</a></span>
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
					<button type="submit" onclick="alert('Hello world')">검색</button>
				</form>
			</div>

			<div class="room_sample">
				<a href="con_main.html"> <img src="img/SAM_6355.jpg" width="300"
					align="top">
				</a>
			</div>
		</div>
	</div>



	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>




</body>