<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
%>

<!--header-->
        <div class = "header">
            <h1>Room&nbsp;Share</h1>
        <h2 style = "align-content: center;">MEMBERSHIP</h2>
        </div>

        <!--center-->
        <div class = "container">
            <form>
                <fieldset>
                    <h3>login</h3>
                  
                    <div>
                        <input type = "text" placeholder="ID" id = "_id">
                        <input type ="password" placeholder="PW" name = "pw">
                        
                        <button type="button" class="btn" onclick = "login()">login</button>
                        <button onclick="location.href='Join.html'" type="button" class="btn">join us</button>
                        
                    </div>
                </fieldset>
            </form>
        </div>

        <script>
                function login() {
                        var id_ele = document.getElementById("_id");
                                //확인
                                if(1){
                                    sessionStorage.setItem("_id", id_ele.value);
                                    location.href = "Sup_Main.jsp";
                                    alert("로그인에 성공하였습니다.");
                                }
                                //취소
                                else{
                                    //이전으로 돌아가기
                                }    
                            }
                </script>

</html>