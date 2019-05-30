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
        <h2 style = "align-content: center;">JOIN US</h2>
        </div>

        <!--center-->
        <div class = "container">
            <form>
                <fieldset>
                    <h3>Join</h3>
                    <div>
                    <p>
                            <input type = "text" id = "ID" name="db_ID" placeholder="ID" required >
                            <input type ="password" id = "PW" name="db_PW" placeholder="PW" required>
                            <input type ="password" id = "PWcheck" name="db_PWch" placeholder="PW CHECK" required>
                    </p>
                    <p>
                            <input type="text" id = "name" name = "db_name" placeholder="NAME" required>
                    </p>
                    <p>
                        <input type="email" id="email" name="db_id" placeholder="E-MAIL" required>
                        <input type="tel" id = "tel" name="db_tel" placeholder="TELEPHONE NUM" required>
                    </p> 
                    <br>
                    <p>
                        <input type="radio" name="type" value="consumer">소비자<br>
                        <input type="radio" name="type" value="supplier">공급자<br>
                    </p>   
                    <br>
                    <p>
                            <button class="btn"  type="submit">입력</button>			
                    </p>        
                    </div>
                </fieldset>

               
            
            
            </form>
        </div>

       

</html>
