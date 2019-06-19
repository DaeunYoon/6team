<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
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
var day = new Date();//오늘 날자(아래 모든 함수에 적용됨)
	
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
	
	
	function nextday(n) {//x일후 날자 구하기
	    var rtn = new Date(day.getTime());
	    rtn.setDate(rtn.getDate()+n);
	    return rtn;
	}
	function datediff(date1, date2) {//두 날자객체의 차이(=일) 구하기
	    return Math.round((date2.getTime()-date1.getTime())/(1000*60*60*24));
	}
	
	function expireSession()
	{
		alert("로그인 시간이 만료되었습니다. 다시 로그인해주세요");
		location.href = "logout.jsp";
		session.invalidate();
	}
	setTimeout('expireSession()', <%=request.getSession().getMaxInactiveInterval() * 60%>);
</script>
<title>RoomShare</title>
</head>
<body onload="setdate()">

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

		String title = null, host = null, addr = null, cont = null;
		int price = 0, broom = 0, kit = 0, inter = 0, park = 0, max = 0;
		double score = 0;

		String rid = request.getParameter("rid");

		String sql = "select state from account where id = '" + Id + "'";
		Statement stmt = null;
		stmt = con.createStatement();
		ResultSet rs = null;
		rs = stmt.executeQuery(sql);

		int st = 0;
		if (rs.next())
			st = rs.getInt("state");
		sql = "select room_title, hostID, cost, add1, add2, add3, add4, roomscore, max_p from room_info where roomid = '"
				+ rid + "'";
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);

		if (rs.next()) {
			title = rs.getString("room_title");
			host = rs.getString("hostID");
			for (int i = 1; i < 5; i++)
				if (i == 1)
					addr = rs.getString("add" + i) + " ";
				else
					addr += rs.getString("add" + i) + " ";
			price = rs.getInt("cost");
			score = rs.getDouble("roomscore");
			max = rs.getInt("max_p");

		}

		sql = "select * from room_option where roomid = '" + rid + "'";
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);

		if (rs.next()) {
			broom = rs.getInt("BedNumber");
			kit = rs.getInt("Kitchen");
			inter = rs.getInt("internet");
			park = rs.getInt("parking");
			cont = rs.getString("content");
		}
		if (rs.next()) {
			title = rs.getString("room_title");
			host = rs.getString("hostID");
			for (int i = 1; i < 5; i++)
				if (i == 1)
					addr = rs.getString("add" + i) + " ";
				else
					addr += rs.getString("add" + i) + " ";
			price = rs.getInt("cost");
			score = rs.getDouble("roomscore");

		}

		sql = "select * from room_option where roomid = '" + rid + "'";
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);

		if (rs.next()) {
			broom = rs.getInt("BedNumber");
			kit = rs.getInt("Kitchen");
			inter = rs.getInt("internet");
			park = rs.getInt("parking");
		}

		sql = "select * from room_reserve_info where roomid = '" + rid + "'";
		rs = stmt.executeQuery(sql);

		
				
		if (st == 1) {
	%>
	<script>
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
		//alert(d[0] +"-" +d[1] +"-"+d[2]);
		//alert(year + month + day);
		
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
			alert("check-in 날짜부터 입력해 주세요");
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
		
		/*check-in 날짜와 비교*/
		if(ind[0] > d[0]) {
			alert("check-out 날짜는 check-in 날짜보다 빠를 수 없습니다.");
			return;
		}
		else if(ind[0] == d[0]) {
			if(ind[1] > d[1]) {
				alert("check-out 날짜는 check-in 날짜보다 빠를 수 없습니다.");
				return;
			}
			else if(ind[1] == d[1]) {
				if(ind[2] >= d[2]) {
					alert("check-out 날짜는 check-in 날짜보다 빠를 수 없습니다.");
					return;
				}
			}
		}
		
		ch2 = 1;
	}
	</script>

	<!--header-->
	<div class="header">
		<a href="Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span><a
				href="Con_Appo.jsp">예약신청내역</a></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span><a href="App_History.jsp">완료내역</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span><a
				href="Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<%
		} else {
	%>
	<div class="header">
		<a href="Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
		<div class="menu">
			<span id="log">logout</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_New_Posting.jsp">새글쓰기</a></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="App_History.jsp">이용내역</a></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a
				href="Sup_Info_Manage.jsp">개인정보관리</a></span>
		</div>
	</div>
	<%
		}
	%>



	<!--center-->
	<div class="container">
		<div class="contents">

			<div class="room_info_contents"
				style="margin-top: 24px; box-sizing: border-box; overflow: hidden;">
				<div class="roon_info_contents_left"
					style="margin: auto; text-align: center">
					<div style="font-size: 24px">
						<strong><%=title%></strong>
					</div>

					<div
						style="font-size: 12px; border-bottom: 1px solid #c2c2c2; padding-bottom: 4px;">
						<a href="Look_Acco.jsp?uid=<%=host%>"
							style="font-decoration: none;"
							onmouseover="this.style.color='gray'"
							onmouseout="this.style.color='black'"><%=host%></a>
					</div>

					<div style="margin-top: 24px;">
						최대 인원
						<%=max%>
						명
					</div>

					<div style="margin-top: 24px;"><%=addr%></div>

					<div style="margin-top: 24px">
						기타정보 <br>
						<div>
							내용 :
							<%=cont%></div>
						<span>침실수 : <%=broom%></span> <span>부엌</span>
						<%
							if (kit == 1)
								out.println("O");
							else
								out.println("X");
						%>
						<span>인터넷</span>
						<%
							if (inter == 1)
								out.println("O");
							else
								out.println("X");
						%>
						<span>주차장</span>
						<%
							if (park == 1)
								out.println("O");
							else
								out.println("X");
						%>

					</div>
				</div>

				<div style="width: 100%; box-sizing: border-box; padding: 16px;">
					<div style="margin: auto; text-align: center">
						<span style="font-size: 24px;"><strong><%=price%>원</strong></span>
						<span>/박</span>
					</div>
					<div style="margin: auto; text-align: center;">
						<%=score%>
						/ 10
					</div>
				</div>

				<%
					if (st == 1) {
				%>
				<form action="Res_Update.jsp" method="post" onsubmit="checkdate()">
					
					
					<fieldset class="roon_info_contents_right" style="">
						<div>
							<input type="hidden" value="<%=rid%>" name="rid"> 게스트 
							<select name="people">
								<%
									for (int i = 1; i < max; i++)
											out.println("<option value = '" + i + "'>" + i + "</option>");
								%>
							</select> 
							<br> <br>
						</div>

						<div>
							check-in <input type="text" name="in" id="in"
								onchange="checkin()" placeholder="year-month-day" required>
							check-out <input type="text" name="out" id="out"
								onchange="checkout()" placeholder="year-month-day" required>
						</div>

						<div style="margin: auto; text-align: center">
							<button style="width: 50%; margin: auto;" type="submit" onclick = "if(!checkform()) return false;">예약요청</button>
						</div>

					</fieldset>
				</form>
				<%
					}
				%>

				<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>
</body>


</html>