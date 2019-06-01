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

			<div class="search_result">
				<!-- Grid-->
				<div class="room_grid">
					<div class="room_all">
						<a href="#"><img src="img/SAM_6355.jpg"></a> <a href="#"
							class="room_tit"><strong>제목</strong></a><br> <span
							class="room_price">가격</span> <span class="room_cont">내용</span> <span>등록일</span>
					</div>

					<div class="room_all">
						<a href="#"><img src="img/SAM_6355.jpg"></a> <a href="#"
							class="room_tit"><strong>제목</strong></a><br> <span
							class="room_price">가격</span> <span class="room_cont">내용</span> <span>등록일</span>
					</div>

					<div class="room_all">
						<a href="#"><img src="img/SAM_6355.jpg"></a> <a href="#"
							class="room_tit"><strong>제목</strong></a><br> <span
							class="room_price">가격</span> <span class="room_cont">내용</span> <span>등록일</span>
					</div>

					<div class="room_all">
						<a href="#"><img src="img/SAM_6355.jpg"></a> <a href="#"
							class="room_tit"><strong>제목</strong></a><br> <span
							class="room_price">가격</span> <span class="room_cont">내용</span> <span>등록일</span>
					</div>

					<div class="room_all">
						<a href="#"><img src="img/SAM_6355.jpg"></a> <a href="#"
							class="room_tit"><strong>제목</strong></a><br> <span
							class="room_price">가격</span> <span class="room_cont">내용</span> <span>등록일</span>
					</div>

					<div class="room_all">
						<a href="#"><img src="img/SAM_6355.jpg"></a> <a href="#"
							class="room_tit"><strong>제목</strong></a><br> <span
							class="room_price">가격</span> <span class="room_cont">내용</span> <span>등록일</span>
					</div>

				</div>

				<!-- //Grid -->



				<div class="paging">
					<tbody>
						<span class="button_first"><a href="#">처음페이지</a></span>
						<span class="button_prev"><a href="#">이전페이지</a></span>
						<span> <a class="on" href="#">1</a> <a href="#">2</a> <a
							href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a>
							<a href="#">7</a> <a href="#">8</a> <a href="#">9</a> <a href="#">10</a>
						</span>
						<span class="button_next"><a href="#">다음페이지</a></span>
						<span class="button_last"><a href="#">마지막페이지</a></span>
					</tbody>
				</div>
			</div>

		</div>
	</div>



	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>




</body>


</html>