//package MAIN;
//import MAIN.TRANSACTION.USER.*;
package MAIN.MANAGEMENT;

import java.io.*;


import java.util.ArrayList;
import java.util.Scanner;
import java.util.StringTokenizer;

import MAIN.Demo;
import MAIN.TRANSACTION.USER.User;

public class Manager {

    private final String id="admin";
    private final String password="1111";
    public int answer_code = 0;
    Scanner sc = new Scanner(System.in);
    //method
    public void editUserScore(){
    	double Score, sub;
    	String line, repline, token, target_id;
    	boolean flag = false;
    	int tokens, i;
    	
    	String fileName = "MemberList.txt";
    	
    	File inputFile = new File(fileName);
    	File outputFile = new File(fileName+".temp");
    	
    	FileInputStream fileInputStream = null;
    	FileOutputStream fileOutputStream = null;
    	BufferedReader bufferedReader = null;
    	BufferedWriter bufferedWriter = null;
    	
    	try {
    		fileInputStream = new FileInputStream(inputFile);
    		fileOutputStream = new FileOutputStream(outputFile);
    		bufferedReader = new BufferedReader(new InputStreamReader(fileInputStream));
    		bufferedWriter = new BufferedWriter(new OutputStreamWriter(fileOutputStream));
    	
    	User user = new User();	
    	
    	System.out.println("차감할 회원의 ID를 입력하세요 : ");
    	target_id = sc.nextLine();
    	
    	if((user = offerUserInfo(target_id)) != null)
    	{
	    	Score = user.getAverageScore();
	    	System.out.println("차감할 평점을 입력하세요 : ");
	    	sub = sc.nextInt();
	    	user.setAverageScore(Score - sub);
	    	
	    	while((line = bufferedReader.readLine()) != null)
	    	{
	    		StringTokenizer st = new StringTokenizer(line," ");
	    		
	    		tokens = st.countTokens();
	    		
	    		for(i=0;i<tokens;i++)
	    		{
	    			token = st.nextToken();
	    			if(i==1 && token == target_id)
	    			{
	    				//continue;
	    				flag = true;
	    				continue;
	    			}
	    			//else break;
	    			
	    			if(i == tokens - 2)
	    			{
	    				//바뀐 줄로 출력
	    				repline = line.replace(String.valueOf(Score), String.valueOf(Score - sub));
	    				
	    				bufferedWriter.write(repline);
	    				bufferedWriter.newLine();
	    			}
	    		}
	    		if(flag == false)
	    		{
	    			//원래 줄로 출력
	    			bufferedWriter.write(line);
	    			bufferedWriter.newLine();
	    		}
	    		flag = false;
	    		
	    	}
    	}
    	}catch(IOException ex){
    		ex.printStackTrace();
    	}
    	
    	//close
    	try{
    		bufferedReader.close();
    	}catch(IOException ex1){
    		ex1.printStackTrace();
    	}
    	
    	try{
    		bufferedWriter.close();
    	}catch(IOException ex2){
    		ex2.printStackTrace();
    	}
    	
    	//원래 파일 지우고 바뀐 파일로 대체
    	inputFile.delete();
    	outputFile.renameTo(new File(fileName));
    	
    }

    public User offerUserInfo(String target_id){
    	Boolean flag = false;
    	int i;
        User user = new User();
        Demo demo = new Demo();
        ArrayList<User> members = demo.getMembers();
        
        String id;
        
        for(i=0;i<members.size();i++)
        {
            if(target_id.equals(members.get(i).getId())) {
                flag = true;
                break;
            }
        }
        if(flag== true)
        {
        	user = members.get(i);
        	return user;
        }
        else
        {
        	System.out.println("해당 회원 없음, 다시 시도 해주세요.");
        	return null;
        }
    }

    public void addToBlackList() throws IOException{ //파일에 user 정보 추가
    	String FileName = "blacklist.txt";
    	String target_id;
    	String reason;
    	User user = new User();
    	
    	System.out.println("블랙리스트에 추가할 회원의 ID를 입력하세요 : ");
    	target_id = sc.nextLine();
    	user = offerUserInfo(target_id);
        
    	System.out.println("블랙 사유 : ");
    	reason = sc.nextLine();
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(FileName, true));
        bufferedWriter.write(user.getId() + "\n" );
        bufferedWriter.write(user.getName() + "\n" );
        bufferedWriter.write(user.getContact() + "\n" );
        bufferedWriter.write( reason + "\n\n" );

        bufferedWriter.close();
    }

    public Answer writeAnswer() throws IOException{
    	String FileName = "answer.txt";
    	Answer a = new Answer();
        
        a.answer_code += 1; //답변글 번호
        System.out.println("답변글 작성 날짜  (ex.20171214) : ");
        a.date = sc.nextInt();
        sc.nextLine();
        
        System.out.println("한줄 답변 작성 : ");
        a.content = sc.nextLine();
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(FileName, true));
        bufferedWriter.write(a.answer_code + "\n" );
        bufferedWriter.write(a.date + "\n" );
        bufferedWriter.write(a.content + "\n" );
        
        bufferedWriter.close();
        
        return a;
    }
    
    public int Login() throws IOException{
        String ID;
        String Password;
        String check;
        //Demo new_demo = new Demo();
        while(true){
            System.out.print("아이디 : ");
            ID = sc.nextLine();
            System.out.print("비밀번호 : ");
            Password = sc.nextLine();
            if(ID.equals(id)&&Password.equals(password)) {
                System.out.println("관리자 모드로 접속하였습니다.");
                //Manager_Menu();
                return 1;
                //break;
            }
            if(!ID.equals(id)) System.out.println("관리자 아이디가 틀렸습니다.");
            else if(!Password.equals(password)) System.out.println("관리자 비밀 번호가 틀렸습니다.");
            else if(!ID.equals(id)|| !Password.equals(password))
                System.out.println("관리자 아이디와 비밀번호가 틀렸습니다.");
            System.out.println("종료를 원하시면 'q', 계속 로그인 하시려면 'c'를 눌러주세요 : ");
            check = sc.nextLine();
            if(check.equals('c')) continue;
            else if(check.equals('q')) break;
        }
        return 0;
    }
    
    public void Manager_Menu() throws IOException
    {
    	Scanner sc = new Scanner(System.in);

        System.out.println("관리자 메뉴 화면");
        System.out.println("메뉴를 선택해주세요.");
        System.out.println("1. 신고 회원 평점 차감하기 ");
        System.out.println("2. 블랙리스트 추가하기");
        System.out.println("3. 답변쓰기");
        System.out.println("4. 종료하기");

        int i = sc.nextInt();

        switch (i){
            case 0 :
                break;
            case 1 :
            	//manager.editUserScore();
            	editUserScore();
                break;
            case 2 :
            	//manager.addToBlackList();
            	addToBlackList();
                break;
            case 3 :
            	//manager.writeAnswer();
            	writeAnswer();
                break;
            case 4 :
                sc.close();
                //System_Exit();
        }
    }
}

