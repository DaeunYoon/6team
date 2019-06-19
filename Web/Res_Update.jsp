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

	function date_mask(formd, textid) {

		/*
		 input onkeyup에서
		 formd == this.form.name
		 textid == this.name
		 */

		var form = eval("document." + formd);
		var text = eval("form." + textid);

		var textlength = text.value.length;

		if (textlength == 4) {
			text.value = text.value + "-";
		} else if (textlength == 7) {
			text.value = text.value + "-";
		} else if (textlength > 9) {
			//날짜 수동 입력 Validation 체크
			var chk_date = checkdate(text);

			if (chk_date == false) {
				return;
			}
		}
	}

	function expireSession() {
		alert("로그인 시간이 만료되었습니다. 다시 로그인해주세요");
		location.href = "logout.jsp";
		session.invalidate();
	}
	setTimeout('expireSession()',
<%=request.getSession().getMaxInactiveInterval() * 60%>
	);
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

		request.setCharacterEncoding("utf-8");

		String sql = "Select max(reserveNum) from room_reserve_info";
		Statement stmt = null;
		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		int rn = 0;
		if (rs.next()) {
			rn = rs.getInt(1) + 1;
		}

		String rid = request.getParameter("rid");
		String ind = request.getParameter("in");
		String outd = request.getParameter("out");
		String guest = request.getParameter("poeple");
		
		sql = "Select StartDate,EndDate from room_reserve_info where RoomID = '" +rid+"'";
		rs = stmt.executeQuery(sql);
		/*예약된 날짜 추가*/
		while (rs.next()) {
			String chin = rs.getString("StartDate");
			String chout = rs.getString("EndDate");

			String[] cin = new String[3];
			String[] cout = new String[3];
			String[] rin = new String[3];
			String[] rout = new String[3];

			/*예약된 날짜*/
			cin = chin.split("-");
			cout = chout.split("-");
			/*예약할날짜*/
			rin = ind.split("-");
			rout = outd.split("-");

			System.out.println(chin +" " + chout);

			/*날짜 검사*/
			/*check out 날짜검사*/
			int ch = 0;
			if (Integer.parseInt(cin[0]) < Integer.parseInt(rout[0])) {
				ch = 1; //예약된 날짜가 더 큼
			}
			else if(Integer.parseInt(cin[0]) == Integer.parseInt(rout[0])) {
				if (Integer.parseInt(cin[1]) < Integer.parseInt(rout[1])) {
					ch = 1;
				} 
				else if (Integer.parseInt(cin[1]) == Integer.parseInt(rout[1])) {
					if (Integer.parseInt(cin[2]) < Integer.parseInt(rout[2])) {
						ch = 1;
					} 
					else if (Integer.parseInt(cin[2]) == Integer.parseInt(rout[2])) {
						ch = 0;
					}
					else {
						ch = 2;
					}
				} 
				else {
						ch = 2; //예약할 날짜가 더 큼
				}
			} 
			else {
				ch = 2; //예약할 날짜가 더 큼
			}
			

			if (Integer.parseInt(cin[0]) < Integer.parseInt(rin[0])) {
				//ok
			} 
			else {
				if (Integer.parseInt(cin[0]) == Integer.parseInt(rin[0])) {
					if (Integer.parseInt(cin[1]) < Integer.parseInt(rin[1])) {
						//ok
					} 
					else {
						if (Integer.parseInt(cin[1]) == Integer.parseInt(rin[1])) {
							if (Integer.parseInt(cin[2]) > Integer.parseInt(rin[2])) {
								//ok
							} else if (Integer.parseInt(cin[2]) == Integer.parseInt(rin[2])) {
								//체크인 날짜가 같은 경우
								out.println("<script>alert('예약이 되어있는 날짜입니다.'); location.href ='Room_Info.jsp?rid="+rid+"'; </script>");
							} else {
								//체크아웃 검사해야함 (예약된 체크인 일 < 예약할 체크인 일)
								if(ch == 2 || ch == 0){
								//ok	
								}
								else{
									out.println("<script>alert('예약이 되어있는 날짜입니다.'); location.href ='Room_Info.jsp?rid="+rid+"'; </script>");
								}
							}
						} 
						else {
							//체크아웃 검사해야함 (예약된 체크인 월 < 예약할 체크인 월 )
							if(ch == 2 || ch == 0){
							//ok	
							}
							else{
								out.println("<script>alert('예약이 되어있는 날짜입니다.'); location.href ='Room_Info.jsp?rid="+rid+"'; </script>");
							}
						}
					}
				}

			}

		}
		
		sql = "INSERT INTO room_reserve_info (`reserveNum`, `RoomID`,`StartDate`, `EndDate`, `guestID`) values ("
				+ "'" + rn + "', '" + rid + "','" + ind + "', '" + outd + "', '" + Id + "')";

		PreparedStatement pstmt = null;
		pstmt = con.prepareStatement(sql);
		pstmt.execute();

		stmt.close();
		pstmt.close();
		con.close();
	%>

	<script>
		alert("정상적으로 예약되었습니다.");
		location.href = "Con_Appo.jsp";
	</script>

</body>

</html>