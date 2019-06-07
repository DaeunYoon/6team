<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<title>login_manager</title>


<body>
	<script>
		var conf = confirm("사용자를 신고하시겠습니까?");
		if (conf) {
			var reason = null;

			reason = prompt("사유를 적어주세요", "신고 이유");
			//이유, 사용자 전송하는 내용 필요
		}
		else
			location.href = 'Sup_Res_History.jsp'
		 
	</script>

	<%
	
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC", "root",
				"1234");

		String res = request.getParameter("reser");
		System.out.println(res);
		String sql = "select report from Account where id = '" + res + "'";

		Statement stmt = null;
		stmt = con.createStatement();

		ResultSet rs = null;
		rs = stmt.executeQuery(sql);

		String report = null;
		int rep = 0;
		if (rs.next()) {
			report = rs.getString(1);
		}
		if (report == null)
			rep = 1;
		else
			rep = Integer.parseInt(report) + 1;

		sql = "update Account set report ='" + rep + "' where id = '" + res + "'";
		stmt.execute(sql);

		stmt.close();
		con.close();
	%>
	<script>
		alert("신고되었습니다.");
		location.href("Sup_Res_History.jsp");
	</script>

</body>
</html>