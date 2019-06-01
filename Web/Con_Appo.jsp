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
			<p>예약목록</p>
			<table border="0" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="112px">
					<col width="auto">
					<col width="150px">
					<col width="190px">
				</colgroup>

				<tbody>
					<tr>
						<th>날짜</th>
						<th>방정보</th>
						<th>예약상태</th>
						<th>예약취소</th>
					</tr>
					<tr>
						<td>2019-02-25</td>
						<td>2</td>
						<td>3</td>
						<td><button type="button">취소</button></td>
					</tr>
					<tr>
						<td>24</td>
						<td>2</td>
						<td>–</td>
						<td><button type="button">취소</button></td>
					</tr>
					<tr>
						<td>기준</td>
						<td>일</td>
						<td>–</td>
						<td><button type="button">취소</button></td>
					</tr>
					<tr>
						<td>1개</td>
						<td>2일</td>
						<td>–</td>
						<td><button type="button">취소</button></td>
					</tr>
				</tbody>
			</table>



			<p style="margin-top: 150px;">완료내역</p>
			<table border="0" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="112px">
					<col width="auto">
					<col width="150px">
					<col width="190px">
				</colgroup>

				<tbody>
					<tr>
						<th>날짜</th>
						<th>방정보</th>
						<th>공급자</th>
						<th>비고</th>
					</tr>
					<tr>
						<td>2019-03-02</td>
						<td>2</td>
						<td>3</td>
						<td><button type="button" style="margin-right: 5px;">후기</button>
							<button type="button" value="공급자" name="공급자"
								onclick="notification()">신고</button></td>
					</tr>
					<tr>
						<td>24</td>
						<td>2</td>
						<td>–</td>
						<td><button type="button" style="margin-right: 5px;">후기</button>
							<button type="button" value="공급자" name="공급자"
								onclick="notification()">신고</button></td>
					</tr>
					<tr>
						<td>기준</td>
						<td>일</td>
						<td>–</td>
						<td><button type="button" style="margin-right: 5px;">후기</button>
							<button type="button" value="공급자" name="공급자"
								onclick="notification()">신고</button></td>
					</tr>
					<tr>
						<td>1개</td>
						<td>2일</td>
						<td>–</td>
						<td><button type="button" style="margin-right: 5px;">후기</button>
							<button type="button" value="공급자" name="공급자"
								onclick="notification()">신고</button></td>
					</tr>
				</tbody>
			</table>

		</div>
	</div>




	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>




</body>


</html>