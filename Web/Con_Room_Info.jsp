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
			<div class="roon_info_img">
				<div class="room_info_img_1">
					<img src="img/SAM_6355.jpg">
				</div>
				<div class="room_info_img_2">
					<div class="room_info_img_2_1">
						<img src="img/SAM_6355.jpg">
					</div>
					<div class="room_info_img_2_1">
						<img src="img/SAM_6355.jpg">
					</div>
				</div>

				<div class="room_info_img_2">
					<div class="room_info_img_2_1">
						<img src="img/SAM_6355.jpg">
					</div>
					<div class="room_info_img_2_1">
						<img src="img/SAM_6355.jpg">
					</div>
				</div>

				<div class="all_img">
					<button class="all_img_btn" style="cursor: pointer;">사진 보기</button>
				</div>

			</div>

			<div class="room_info_contents"
				style="margin-top: 24px; box-sizing: border-box; overflow: hidden;">
				<div class="roon_info_contents_left" style="">
					<div style="font-size: 24px">
						<strong>방제목</strong>
					</div>

					<div
						style="font-size: 12px; border-bottom: 1px solid #c2c2c2; padding-bottom: 4px;">등록자ID
						별점</div>

					<div style="margin-top: 24px;">주소</div>

					<div style="margin-top: 24px">날짜</div>

					<div style="margin-top: 24px">기타정보</div>
				</div>

				<div class="roon_info_contents_right" style="">
					<div style="width: 100%; box-sizing: border-box; padding: 16px;">
						<div style="">
							<span style="font-size: 24px;"><strong>140,000원</strong></span> <span>/박</span>
						</div>
						<div>★★★★★</div>
					</div>

					<div style="width: 100%; box-sizing: border-box; padding: 16px;">
						<div style="margin-bottom: 2px;">날짜</div>
						<div class="check_InOut" style="">

							<div
								style="width: 42%; height: 24px; box-sizing: border-box; float: left; overflow: hidden;">
								<input type="text" placeholder="체크인" style="padding-left: 2px;">
							</div>

							<div
								style="width: 24px; height: 24px; box-sizing: border-box; float: left; margin-left: 3px; margin-right: 3px;">
								<svg> <path
									d="m0 12.5a.5.5 0 0 0 .5.5h21.79l-6.15 6.15a.5.5 0 1 0 .71.71l7-7v-.01a.5.5 0 0 0 .14-.35.5.5 0 0 0 -.14-.35v-.01l-7-7a .5.5 0 0 0 -.71.71l6.15 6.15h-21.79a.5.5 0 0 0 -.5.5z">
								</path> </svg>
							</div>

							<div
								style="width: 42%; height: 24px; box-sizing: border-box; float: left; overflow: hidden;">
								<input type="text" placeholder="체크아웃" style="padding-left: 2px;">
							</div>
						</div>

						<div style="margin-top: 24px; margin-bottom: 2px;">인원</div>
						<div class="room_person">
							<div style="float: left;">게스트 1명</div>

							<div style="float: right;">
								<button type="button">
									<span> <svg viewBox="0 0 24 24"
											style="height: 1em; width: 1em; display: block; fill: currentcolor;">
										<rect height="2" rx="1" width="12" x="6" y="11"></rect> <rect
											height="12" rx="1" width="2" x="11" y="6"></rect> </svg>
									</span>
								</button>
							</div>

							<div style="float: right; margin-right: 4px;">
								<button type="button">
									<span> <svg viewBox="0 0 24 24"
											style="height: 1em; width: 1em; display: block; fill: currentcolor;">
										<rect height="2" rx="1" width="12" x="6" y="11"></rect> </svg>
									</span>
								</button>
							</div>
						</div>
					</div>

					<div style="width: 100%; box-sizing: border-box; padding: 16px;">
						<button type="submit"
							style="width: 100%; height: 32px; letter-spacing: 1px; border-radius: 4px; cursor: pointer; background: rgb(255, 90, 95); border-color: transparent; color: white;">예약요청</button>
					</div>
				</div>

			</div>
		</div>
	</div>



	<script>
		document.getElementById("log").addEventListener("click", logout);
	</script>




</body>


</html>