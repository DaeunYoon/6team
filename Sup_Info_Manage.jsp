<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                                if(conf){
                                    sessionStorage.clear();
                                    location.href = "Main(common).jsp";
                                }
                                //취소
                                else{
                                    //이전으로 돌아가기
                                }    
                            }
                </script> 
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
            <a href = "Sup_Main.jsp"><h1 style="color: black;">Room&nbsp;Share</h1></a>
            <div class = "menu">
                <span id = "log">logout</span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a href = "Sup_New_Posting.jsp">새글쓰기</a></span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a href = "Sup_Res_History.jsp">이용내역</a></span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a href = "Sup_Info_Manage.jsp">개인정보관리</a></span>
            </div>
        </div>
        <br>

        <!--center-->
        <form>
                <fieldset>
                        <h3>내 별점</h3>
                        3.3 / 5 점
                    </fieldset>
                <fieldset>
                    <h3>개인정보관리</h3>
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
                            <button class="btn"  type="submit">수정</button>			
                    </p>        
                    </div>
                </fieldset>
       
        </form>

        <!--logout function-->
        <script>
                document.getElementById("log").addEventListener("click", logout);
                
        </script>
        </body>

</html>