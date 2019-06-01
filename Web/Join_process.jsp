<%@page import="java.sql.*"%>

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
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC", "root","1234");
	
	String id = request.getParameter("ID");
	String pw = request.getParameter("PW");
	String name = request.getParameter("name");
	
	int stt = 0;//공급자
	String st = request.getParameter("type");
	
	if(st.equals("consumer"))	
		stt = 1; //소비자
		
	String em = request.getParameter("email");
	String tel = request.getParameter("tel");
	
	PreparedStatement pstmt = con.prepareStatement("insert into Account ('ID', 'PW', 'Username', 'state') values (?,?,?,?)");
	pstmt.setString(1,id);
	pstmt.setString(2,pw);
	pstmt.setString(3,name);
	pstmt.setInt(4,stt);
	
	pstmt.executeUpdate();

	pstmt.close();
	con.close();
%>

<script>
	alert("회원가입이 완료되었습니다.");
	location.href = "Main(common).jsp";
</script>

</body>

</html>