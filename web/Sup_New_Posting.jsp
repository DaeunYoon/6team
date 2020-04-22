<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="login.LoginManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% LoginManager loginManager = LoginManager.getInstance(); %>
<!DOCTYPE html>
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
	
	function isNum() 
	{
		var a = document.getElementById("max");
		var b = document.getElementById("bedroom");
		var c = document.getElementById("price");
		var ch = true;
		if(isNaN(a.value)) {
			alert("수용 인원에는 숫자를 입력하세요");
			ch = false;
		}
		else {
			if(a.value <= 0) {
				alert("수용 인원은 한명이상입니다 ");
				ch = false;
			}
		}
		if(isNaN(b.value)) {
			alert("침실수에는 숫자를 입력하세요");
			ch = false;
		}
		else {
			if(b.value <= 0) {
				alert("침실수는 한개이상입니다 ");
				ch = false;
			}			
		}
		
		if(isNaN(c.value)) {
			alert("일박요금에는 숫자를 입력하세요");
			ch = false;
		}
		else {
			if(c.value < 5000) {
				alert("가격은 5000원 이상입니다 ");
				ch = false;
			}			
		}
		
		if(ch)
			return true;
		else
			return false;
	}
	
	var ch1 = 0, ch2 = 0;
	function checkform()
	{
		if(ch1 == 0 || ch2 == 0) {
			alert("날짜를 확인하세요");
			return false;
		}
		return true;
	}
	
	function checkin()
	{
		var d = document.getElementById("in").value;
		
		/*오늘 날짜 받아오기*/
		var dt = new Date();
   	 	dt.setMonth(dt.getMonth() + 1 );
    	var year = dt.getFullYear();
    	var month = dt.getMonth();
    	var day = dt.getDate();
		
		d = d.split('-');
		
		/*날짜 형식 확인*/
		if(isNaN(d[0])){
			alert("날짜 형식은 0000-00-00 입니다 (연, 월, 일)");
			document.getElementById("out").value = null;
			return;
		}
		
		if(d[1] == 1 || d[1] == 3 || d[1] == 5 || d[1] == 7 || d[1] == 8 || d[1] == 10 || d[1] == 12){
			if(d[2] > 32 || d[2] < 0){
				alert("날짜를 다시 확인하십시오.");
				return;

			}
		}
		else if(d[1] == 3 || d[1] == 4 || d[1] == 6 || d[1] == 9 || d[1] == 11){
			if(d[2] > 31 || d[2] < 0){
				alert("날짜를 다시 확인하십시오.");
				return;
			}
		}
		else {
			alert("날짜를 다시 확인하십시오.");
			return;
		}
		
		if(d[1] == 2){
			if( (d[0]%4) && ((d[0]%100) || (d[0] % 400)) ){
				if(d[2] > 29 || d[2] < 0){
					alert("날짜를 다시 확인하십시오.");
					return;
					}
			}
			else{
				if(d[2] > 28 || d[2] < 0){
					alert("날짜를 다시 확인하십시오.");
					return;
				}
			}
		}
		
		if(year > d[0]) {
			alert("오늘 날짜 이전은 선택할 수 없습니다.");
			return;
		}
		else if(year == d[0]) {
			if(month > d[1]) {
				alert("오늘 날짜 이전은 선택할 수 없습니다.");
					return;
			}
			else if(month == d[1]) {
				if(day > d[2]) {
					alert("오늘 날짜 이전은 선택할 수 없습니다.");
					return;
				}
			}
		}
		
		ch1 = 1;
	}
	
	function checkout()
	{
		var d = document.getElementById("out").value;
		var ind = document.getElementById("in").value;
		d = d.split('-');
		//alert(d[0] +"-" +d[1] +"-"+d[2]);
		
		if(!ind) {
			alert("시작 날짜부터 입력해 주세요");
			document.getElementById("out").value = null;
			document.getElementById("out").focus();
			return;
		}
		ind = ind.split('-');
		
		if(isNaN(d[0])){
			alert("날짜 형식은 0000-00-00 입니다 (연, 월, 일)");
			document.getElementById("out").value = null;
			return;
		}
		
		if(d[1] == 1 || d[1] == 3 || d[1] == 5 || d[1] == 7 || d[1] == 8 || d[1] == 10 || d[1] == 12){
			if(d[2] > 31 || d[2] < 0){
				alert("날짜를 다시 확인하십시오.");
				return;

			}
		}
		else if(d[1] == 3 || d[1] == 4 || d[1] == 6 || d[1] == 9 || d[1] == 11){
			if(d[2] > 30 || d[2] < 0){
				alert("날짜를 다시 확인하십시오.");
				return;
			}
		}
		else {
			alert("날짜를 다시 확인하십시오.");
			return;
		}
		
		if(d[1] == 2){
			if( (d[0]%4) && ((d[0]%100) || (d[0] % 400)) ){
				if(d[2] > 29 || d[2] < 0){
					alert("날짜를 다시 확인하십시오.");
					return;
					}
			}
			else{
				if(d[2] > 28 || d[2] < 0){
					alert("날짜를 다시 확인하십시오.");
					return;
				}
			}
		}
		
		/*check-in 날짜와 비교*/
		if(ind[0] > d[0]) {
			alert("종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
			return;
		}
		else if(ind[0] == d[0]) {
			if(ind[1] > d[1]) {
				alert("종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
				return;
			}
			else if(ind[1] == d[1]) {
				if(ind[2] >= d[2]) {
					alert("종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
					return;
				}
			}
		}
		
		ch2 = 1;
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
				href="App_History.jsp">이용내역</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<br>

	<!--center-->
	<form action = "Update.jsp" method = "post" id = "posting">
		<div class="container">
			<table>
				<thead>
				<caption>글쓰기</caption>
				</thead>
				<tbody>
					<tr>
						<th>제목 :</th>
						<td><input type="text" placeholder="제목을 입력하세요. "
							name="title" required /></td>
					</tr>
						<tr>
						<th>내용 :</th>
						<td><textarea class="noresize" cols=70 rows=20
								placeholder="내용을 입력하세요. " name="cont" require></textarea></td>
					</tr>
					<tr>
						<th>주소 :</th>
						<td><input type="text" placeholder="도/광역시를 입력하세요. " name="adr1"
							required /><input type="text" placeholder="시/구를 입력하세요. " name="adr2"
							required /><input type="text" placeholder="동을 입력하세요. " name="adr3"
							required /><input type="text" placeholder="세부주소를 입력하세요. " name="adr4"
							required /></td>
					</tr>
					<tr>
						<th>수용 인원 :</th>
						<td><input type="text" placeholder="최대 수용인원을 입력하세요. " name="max"
							id = "max" required /></td>
					</tr>
					<tr>
						<th>침실수 :</th>
						<td><input type="text" placeholder="침실수를 입력하세요. " name="bedroom" id="bedroom"
							required /></td>
					</tr>
					<tr>
						<th>부엌 :</th>
						<td>YES<input type="radio" name="kitchen" value = "1" required />
						NO<input type="radio" name="kitchen" value = "0" required /></td>
						
					</tr>
					<tr>
						<th>인터넷 :</th>
						<td>YES<input type="radio" name="internet" value = "1" required />
						NO<input type="radio" name="internet" value = "0" required /></td>
					</tr>
					<tr>
						<th>주차장 :</th>
						<td>YES<input type="radio" name="parking" value = "1" required />
						NO<input type="radio" name="parking" value = "0" required /></td>
					</tr>
					<tr>
						<th>대여가능날짜 :</th>
						<td>
						<input type="text" name="start_date" id="in"
								onchange="checkin()" placeholder="year-month-day" required>
								~
						<input type="text" name="end_date" id="out"
								onchange="checkout()" placeholder="year-month-day" required>
						</td>
					</tr>
					<tr>
						<th>일박요금 :</th>
						<td ><input type="text" placeholder="금액을 입력하세요. " name="price" id="price" /></td>
					</tr>
					<tr style="margin:auto; text-align:center;">
						<td colspan="2"><input style="width: 20%; margin: auto; height: 30px" type="submit" onclick = "if(!isNum()) return false;" value="등록" /></td>
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