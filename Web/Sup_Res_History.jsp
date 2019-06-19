<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
	//신고기능 구현
	function notification() {
		var conf = confirm("사용자를 신고하시겠습니까?");
		if (conf) {
			var reason;

			reason = prompt("사유를 적어주세요", "신고 이유");
			//이유, 사용자 전송하는 내용 필요
			if (reason)
				alert = "신고가 완료되었습니다.";
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
	%>

	<!--header-->
	<div class="header">
		<a href="Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
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
	<form action="notifi.jsp" method="POST">
		<div class="container">
			<table>
				<caption style="font-weight: bold; font-size: 160%; padding: 5px">이용내역</caption>
				<tread>
				<tr>
					<th>방 이름</th>
					<th>날짜</th>
					<th>예약자</th>
					<th>신고하기</th>
				</tr>
				</tread>
				<tbody>
					<tr>
						<a href><td>방1</td></a>
						<td>2019-01-02</td>
						<a href><td>예약자</td>
							<td><button type="button" value="daeun" name="reser"
									onclick="location.href = 'notifi.jsp?reser=daeun'">신고하기</button>
						<tr>
								<a href><td>방2</td></a>
								<td>2019-01-03</td>
								<a href><td>예약자</td></a>
								<td><button type="button" value="예약자" name="reser"
										onclick="location.href = 'notifi.jsp?reser=daeun'">신고하기</button>
							</tr>
				</tbody>

			</table>
		</div>
	</form>

	<!--logout function-->
	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>

</body>

</html>