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

		String id = request.getParameter("ID");
		String pw = request.getParameter("PW");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		
		String sql = null;

		if(id != null) {
			int stt = 0;//공급자
			String st = request.getParameter("type");

			if(st.equals("consumer")) {
				stt = 1; //소비자
			}
			sql = "Update account set Username ='"+name+"', PhoneNumber = '" +tel+ "' Where ID = '"+Id+"'";
		}
		else {
			sql = "Update account set PW ='"+pw+"' where ID = '" + Id +"'";
		}
		
		PreparedStatement pstmt = null;
		pstmt = con.prepareStatement(sql);
		pstmt.execute();
		System.out.println(sql);	


		pstmt.close();
		con.close();
	%>
	<script>
	alert("개인정보가 변경되었습니다.");
	
	location.href = "Main.jsp";
	
	</script>

	<!--logout function-->
	<script>
		document.getElementById("log").addEventListener("click", logout);
		
	</script>
</body>

</html>