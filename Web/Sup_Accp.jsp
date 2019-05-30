<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/sup_style.css" rel="stylesheet" type="text/css"> 
<title>RoomShare</title>

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
        <div class = "container">
                <table>
                    <caption style ="font-weight: bold; font-size:160%; padding:5px">1번방 신청내역</caption>
                        <tbody>
                            <tr>
                                <th>날짜</th>
                                <th>신청자</th>
                                <th>승인/거절</th>
                            </tr>
                            <tr>
                                <td>2019-03-02</td>
                                <td>홍길동</td>
                                <td>
                                <button type="button" value = "y">승인</button>
                                <button type="button" value = "n">거절</button>
                            </tr>
                            <tr>
                                <td>2019-03-02</td>
                                <td>홍길동</td>
                                <td>
                                <button type="button" value = "y">승인</button>
                                <button type="button" value = "n">거절</button>
                            </tr>
                        </tbody>
                </table>        
                
            </div>
        </div>

        <!--logout function-->
        <script>
                document.getElementById("log").addEventListener("click", logout);
                
        </script>
        
    </body>

</html>
