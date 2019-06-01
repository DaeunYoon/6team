package login;
 
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.util.Hashtable;
import java.util.Enumeration;
 
public class LoginManager implements HttpSessionBindingListener
{
             private static LoginManager loginManager = null;
             private static Hashtable loginUsers = new Hashtable();
             private LoginManager(){
                           super();
             }
             public static synchronized LoginManager getInstance(){
                           if(loginManager == null){
                                        loginManager = new LoginManager();
                           }
                           return loginManager;
             }
 
             //�븘�씠�뵒媛� 留욌뒗吏� 泥댄겕
             public boolean isValid(String userID, String userPW){
            	 
                           return true;   //�옄�꽭�븳 濡쒖쭅�� 誘멸뎄�쁽
             }
 
             //�빐�떦 �꽭�뀡�뿉 �씠誘� 濡쒓렇�씤 �릺�엳�뒗吏� 泥댄겕
             public boolean isLogin(String sessionID){
                           boolean isLogin = false;
                           Enumeration e = loginUsers.keys();
                           String key = "";
                           while(e.hasMoreElements()){
                                        key = (String)e.nextElement();
                                        if(sessionID.equals(key)){
                                                     isLogin = true;
                                        }
                           }
                           return isLogin;
             }
 
             //以묐났 濡쒓렇�씤 留됯린 �쐞�빐 �븘�씠�뵒 �궗�슜以묒씤吏� 泥댄겕
             public boolean isUsing(String userID){
                           boolean isUsing = false;
                           Enumeration e = loginUsers.keys();
                           String key = "";
                           while(e.hasMoreElements()){
                                        key = (String)e.nextElement();
                                        if(userID.equals(loginUsers.get(key))){
                                                     isUsing = true;
                                        }
                           }
                           return isUsing;
             }
 
             //�꽭�뀡 �깮�꽦
             public void setSession(HttpSession session, String userID){
                           loginUsers.put(session.getId(), userID);
                           session.setAttribute("login", this.getInstance());
             }
 
             //�꽭�뀡 �꽦由쎈맆 �븣
             public void valueBound(HttpSessionBindingEvent event){
             }
 
             //�꽭�뀡 �걡湲몃븣
             public void valueUnbound(HttpSessionBindingEvent event){
                           loginUsers.remove(event.getSession().getId());
             }
 
             //�꽭�뀡 ID濡� 濡쒓릿�맂 ID 援щ텇
             public String getUserID(String sessionID){
                           return (String)loginUsers.get(sessionID);
             }
 
             //�쁽�옱 �젒�냽�옄�닔
             public int getUserCount(){
                           return loginUsers.size();
             }
};

