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
                
                function sendData() {

                }
                function date_mask(formd, textid) {

/*
input onkeyup에서
formd == this.form.name
textid == this.name
*/

                    var form = eval("document."+formd);
                    var text = eval("form."+textid);

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

 

                function checkdate(input) {
                    var validformat = /^\d{4}\-\d{2}\-\d{2}$/; //Basic check for format validity 
                    var returnval = false;
                    if (!validformat.test(input.value)) {
                        alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
                    } else { //Detailed check for valid date ranges 
                        var yearfield = input.value.split("-")[0];
                        var monthfield = input.value.split("-")[1];
                        var dayfield = input.value.split("-")[2];
                        var dayobj = new Date(yearfield, monthfield - 1, dayfield);
                    }
                    if ((dayobj.getMonth() + 1 != monthfield)
                        || (dayobj.getDate() != dayfield)
                        || (dayobj.getFullYear() != yearfield)) {
                        alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
                    } else {
                    //alert ('Correct date'); 
                        returnval = true;
                    }
                    if (returnval == false) {
                        input.select();
                    }
                    return returnval;
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
        <div class = "container">
            <table>
                <thead>
                    <caption> 글쓰기 </caption>
                </thead>
                <tbody>
                    <tr>
                        <th>제목 : </th>
                        <td><input type = "text" placeholder = "제목을 입력하세요. " name= "subject" required/></td>
                    </tr>
                    <tr>
                        <th>내용 : </th>
                        <td><textarea class = "noresize" cols = 70 rows = 20 placeholder="내용을 입력하세요. " name = "content" require></textarea></td>
                    </tr>
                    <tr>
                        <th>주소 : </th>
                        <td><input type = "text" placeholder = "주소를 입력하세요. " name= "price" required/></td>
                    </tr>
                    <tr>
                        <th>대여가능날짜 : </th>
                        <td><input type = "text" name = "start_date" maxlength = "10" onkeyup="javascipt:date_mask(this.form.name, this.name);" placeholder="YYYY-MM-DD" require></textarea>
                         ~ <input type = "text" name = "end_date" maxlength = "10" onkeyup="javascipt:date_mask(this.form.name, this.name);" placeholder="YYYY-MM-DD" required></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>일박요금 : </th>
                        <td><input type = "text" placeholder = "금액을 입력하세요. " name= "price"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="등록" onclick="sendData()"/>
                        </td>
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
