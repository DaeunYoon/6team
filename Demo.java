package MAIN;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;
import java.util.StringTokenizer;

import MAIN.FILTER.SearchingFilter;
import MAIN.MANAGEMENT.Manager;
import MAIN.MANAGEMENT.BOARD.Board;
import MAIN.MANAGEMENT.BOARD.Inquiry;
import MAIN.MANAGEMENT.BOARD.Report;
import MAIN.MANAGEMENT.BOARD.Suggestion;
import MAIN.TRANSACTION.Room;
import MAIN.TRANSACTION.USER.Consumer;
import MAIN.TRANSACTION.USER.Supplier;
import MAIN.TRANSACTION.USER.User;


public class Demo {
    private static User user;
    private static Manager manager;
    private static Demo demo;
    private static ArrayList<User> members;
    private static ArrayList<Room> rooms;
    private static ArrayList<Board> boardList;
    private Supplier supplier;
    private Consumer consumer;
    private static String fileName_mem;
    private static String fileName_room;
    private static String fileName_board;
    private static int roomcode=0;
    //private static ArrayList<Consumer> consumers;
    //private static ArrayList<Supplier> suppliers;

    
    public static void main(String[] args) throws IOException {
        demo = new Demo();
    	manager = new Manager();
//        user = new User();
        members = new ArrayList<>();
        rooms = new ArrayList<>();
        boardList = new ArrayList<>();
        fileName_mem = "MemberList.txt";
        fileName_room = "RoomList.txt";
        String fileName_load = "boardList.txt";
        //  consumers = new ArrayList<>();
        //  suppliers = new ArrayList<>();
        demo.load_Members();
        demo.load_Rooms();
        try {
            demo.Main_Menu();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    

    public void load_Members(){
        try{
        	
            File file = new File(fileName_mem);
            Scanner sc = new Scanner(file);

            while(sc.hasNextLine())
            {
                //User temp_user = new User();
                String data = sc.nextLine();
                StringTokenizer tokens = new StringTokenizer(data);
                //System.out.println(data);

                String name = tokens.nextToken(" ");
                String id = tokens.nextToken(" ");
                String password = tokens.nextToken(" ");
                String contact = tokens.nextToken(" ");
                int occupation = Integer.parseInt(tokens.nextToken(" "));
                String preferredarea = tokens.nextToken(" ");
                Boolean pushagreement = Boolean.parseBoolean(tokens.nextToken(" "));
                double averagescore = Double.parseDouble(tokens.nextToken(" "));
                String userstate = tokens.nextToken(" ");
                int tranCnt = Integer.parseInt(tokens.nextToken(" "));

                if(userstate.equals("공급자")) {
                    Supplier sp = new Supplier(name,id,password,contact,occupation,preferredarea,pushagreement,averagescore,userstate,tranCnt);
                    //  suppliers.add(sp);
                    members.add(sp);
                } else {
                    Consumer cs = new Consumer(name,id,password,contact,occupation,preferredarea,pushagreement,averagescore,userstate,tranCnt);
                    //consumers.add(cs);
                    members.add(cs);
                }
            }

            sc.close();

        } catch (FileNotFoundException e){
            e.printStackTrace();
        }
    }

    public void load_Board(){
        try{
        	
            File file = new File(fileName_board);
            Scanner sc = new Scanner(file);

            while(sc.hasNextLine())
            {            
                String data = sc.nextLine();
                StringTokenizer tokens = new StringTokenizer(data);
                System.out.println(data);
                
                String answer = tokens.nextToken(" ");
                int boardCode = Integer.parseInt(tokens.nextToken(" "));
                String title = tokens.nextToken(" ");
                String id_writer = tokens.nextToken(" ");
        		String WriterDate = tokens.nextToken(" ");
                Boolean goPublic = Boolean.parseBoolean(tokens.nextToken(" "));
                String head = tokens.nextToken("|");
                String contents = tokens.nextToken("|");
                
            }

            sc.close();

        } catch (FileNotFoundException e){
            e.printStackTrace();
        }
    }

    public void load_Rooms(){
        try{
            File file = new File(fileName_room);
            Scanner sc = new Scanner(file);

            while(sc.hasNextLine())
            {
                //User temp_user = new User();
                String data = sc.nextLine();
                StringTokenizer tokens = new StringTokenizer(data);


                roomcode = Integer.parseInt(tokens.nextToken(" "));
                //String name = tokens.nextToken(" ");
                String id = tokens.nextToken(" ");
                String contacthome = tokens.nextToken(" ");
                int price  = Integer.parseInt(tokens.nextToken(" "));
                String uploaddate = tokens.nextToken(" ");
                String startdate = tokens.nextToken(" ");
                String terminatedate = tokens.nextToken(" ");
                String location = tokens.nextToken(" ");
                String option = tokens.nextToken(" ");
                Boolean tstate = Boolean.parseBoolean(tokens.nextToken(" "));
                String roomstruct = tokens.nextToken(" ");

                Room room = new Room(roomcode,contacthome,price,uploaddate,startdate,terminatedate,location,option,tstate,roomstruct,
                        null);

                rooms.add(room);

            }

            sc.close();

        } catch (FileNotFoundException e){
            e.printStackTrace();
        }
    }





    public void Main_Menu() throws IOException {
        Scanner sc = new Scanner(System.in);


        while(true) {
            System.out.println("메뉴를 선택해주세요.");
            System.out.println("0. 관리자 모드");
            System.out.println("1. 로그인");
            System.out.println("2. 회원 가입");
            System.out.println("3. 종료");
            System.out.print("번호입력> ");
            int i = sc.nextInt();
            switch (i) {
                case 0:
                    manager.Login();
                    break;
                case 1:
                    user = Login();
                    if (user.getUserState().equals("공급자"))
                        Provider_Menu();
                    else
                        Consumer_Menu();
                    break;
                case 2:
                    registerMembers();
                    break;
                case 3:
                    sc.close();
                    System_Exit();
            }
        }


    }

    public void Consumer_Menu() {

        Scanner sc = new Scanner(System.in);

        System.out.println("소비자 메뉴 화면");
        System.out.println("메뉴를 선택해주세요.");
        System.out.println("1. 방 검색하기");
        System.out.println("2. 마이페이지 관리하기");
        System.out.println("3. 고객의 소리 이용하기");
        System.out.println("4. 종료하기");

        int i = sc.nextInt();

        switch (i){
            case 0 :
                break;
            case 1 :
                break;
            case 2 :
                enterConsumerPage();   //마이페이지 접속
                break;
            case 3 :
                enterBoard();   //게시판 접속
                break;
            case 4 :
                sc.close();
                System_Exit();
        }


    }




    public void Provider_Menu() throws IOException {
        SearchingFilter temp;
        Scanner sc = new Scanner(System.in);

        while(true) {
            System.out.println("공급자 메뉴 화면");
            System.out.println("메뉴를 선택해주세요.");
            System.out.println("0. 방 등록하기");
            System.out.println("1. 방 검색하기");
            System.out.println("2. 마이페이지 관리하기");
            System.out.println("3. 고객의 소리 이용하기");
            System.out.println("4. 종료하기");

            int i = sc.nextInt();

            switch (i) {
                case 0:
                    supplier.roomUpdate();
                    break;
                case 1:
                	//X
                    break;
                case 2:
                    enterSupplierPage();
                    break;
                case 3:
                    enterBoard();
                    break;
                case 4:
                    sc.close();
                    System_Exit();
            }

        }


    }

    public void enterBoard(){
        
        System.out.println("*************");
        System.out.println("1. 게시글 작성");
        System.out.println("2. 게시글 조회");
        System.out.println("*************");

        Scanner keyboard = new Scanner(System.in);
        System.out.print("번호 입력> ");
        int option = keyboard.nextInt();
        if(option == 1){
            System.out.println("1. 신고   2. 문의   3. 건의");
            System.out.print("번호입력> ");
           option = keyboard.nextInt();
           switch(option){
           case 1:
              Report report = new Report();
              report.writePost();
              break;
           case 2:
              Inquiry inquiry = new Inquiry();
              inquiry.writePost();
              break;
           case 3:
              Suggestion suggestion = new Suggestion();
              suggestion.writePost();
              break;
           }
        }
        else if(option == 2){
           //게시글 조회
           
           //순회하면어 글번호랑 제목을 전부 찍는다.
           for(int i = 0; i < boardList.size(); i++ ){
              Board b = boardList.get(i);
              System.out.printf("%d %s %s %s\n", 
                    b.getBoardCode(), b.getTitle(), b.getId_writer(), b.getWriteDate().toString());
              
              //혹시 toString안되면
              /*
               * DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
               * Date nowDate = new Date();
               * String tempDate = sdFormat.format(nowDate);
               * */

           }
           
          
          System.out.print("조회할 번호입력> ");
          int code = keyboard.nextInt();
          
           for(int i = 0; i < boardList.size(); i++ ){
              Board b = boardList.get(i);
              if(b.getBoardCode() == code){
                  if(b.isGoPublic()==false && b.getId_writer()!=user.getId()){
                	  System.out.println("비공개 게시글입니다.");
                	  break;
                  }
                 System.out.println("***************************************");
                 System.out.printf("게시글번호: %d\n 제목: %s\n 작성자: %s\n 작성일시: %s\n", 
                        b.getBoardCode(), b.getTitle(), b.getId_writer(), b.getWriteDate().toString());
                 System.out.printf("내용: \n%s\n", b.getContents());
                 System.out.println("***************************************");
                 
                 break;
              }

           }
        }
        else{
           System.out.println("잘못된 번호를 입력하셨습니다.");
        }
        
     }

    public User Login() {
        Scanner sc = new Scanner(System.in);
//        Demo demo = new Demo();
        Boolean flag;
        String id;
        String password;

        System.out.println("방 있어요!\n로그인");
        do {

            flag = false;
            System.out.print("아이디 : ");
            id = sc.nextLine();
            System.out.print("비밀번호 : ");
            password = sc.nextLine();

            for(int i =0; i<members.size();i++)
            {
                if(id.equals(members.get(i).getId()))
                {
                    if(password.equals(members.get(i).getPassword()))
                    {
                        flag = true;
                        System.out.println("접속되었습니다.");
                        if(members.get(i).getUserState().equals("공급자")) {
                            supplier = new Supplier(members.get(i));
                            return supplier;
                        } else {
                            consumer = new Consumer(members.get(i));
                            return consumer;
                        }
                    }
                    else {
                        System.out.println("비밀번호가 일치하지 않습니다!");
                        System.out.println("비밀 번호와 아이디를 다시 입력해주세요!");
                        break;
                    }
                }
            }


        } while(!flag);

        return null;
    }

    public void registerMembers() {
 //       Demo demo = new Demo();
        //ArrayList<User> members = demo.getMembers();
        String pw_check;
        Boolean flag;
        String id;
        Scanner sc = new Scanner(System.in);

        System.out.println("방 있어요!\n 회원가입");
        System.out.print("실명 : ");
        String name = sc.nextLine();

        do {
            System.out.print("아이디 : ");
            id = sc.nextLine();

            flag=true;

            for(int i=0;i<members.size();i++)
            {
                if(id.equals(members.get(i).getId())) {
                    System.out.println("아이디 중복. 다시 입력해주세요!");
                    flag = false;
                    break;
                }
            }

        } while(!flag);
        System.out.println("중복된 아이디가 없습니다. 정상 등록되었습니다.");
        System.out.print("비밀번호 : ");
        String password = sc.nextLine();
        do {
            System.out.print("비밀번호 재확인 : ");
            pw_check = sc.nextLine();
            if(password.equals(pw_check))
                System.out.println("비밀번호가 일치합니다");
            else
                System.out.println("비밀번호가 다릅니다. 다시 입력부탁드립니다.");
        } while(!password.equals(pw_check));
        System.out.print("휴대전화번호 : ");
        String contact = sc.nextLine();
        System.out.println("직업\n 1. 학생 2. 직장인 3. 기타");
        int occupation = sc.nextInt();
        sc.nextLine();
        System.out.println("선호지역 선택 (북문 / 동문 / 서문 / 정문 / 수영장문 / 테크노문 / 농장문 / 솔로문 / 조은문 / 쪽문)");
        String preferredarea = sc.nextLine();
        System.out.println("푸쉬 알림 동의? (O/X)");
        String check = sc.nextLine();
        Boolean pushagreement;
        if(check.equals("O"))
            pushagreement = true;
        else
            pushagreement = false;
        double averagescore = 5.0;
        System.out.print("선택 : 공급자/수요자 ");
        //sc.nextLine();
        String userstate = sc.nextLine();

        if(userstate.equals("공급자")) {
            Supplier sp = new Supplier(name,id,password,contact,occupation,preferredarea,pushagreement,averagescore,userstate, 0);
            members.add(sp);
        } else {
            Consumer cs = new Consumer(name,id,password,contact,occupation,preferredarea,pushagreement,averagescore,userstate, 0);
            members.add(cs);
        }

    }

    public void enterConsumerPage(){
    	
    	System.out.println("*****************");
        System.out.println("수요자 마이페이지");
        System.out.println("옵션을 선택해주세요.");
        System.out.println("0. 정보수정");
        System.out.println("1. 관심방 보기");
        System.out.println("2. 탈퇴");
        System.out.println("3. 거래내역");
        System.out.println("4. 내 게시글 관리");
    	System.out.println("*****************");
    	
    	Scanner keyboard = new Scanner(System.in);
    	int option = keyboard.nextInt();
    	switch(option){
    	case 0: 
    		selectEditOpt();
    		break;
    	case 1: 
    		
    		break;
    	case 2: 
    		
    		break;
    	case 3:
    		
    		break;
    	case 4:
    		//내가 쓴 게시글 보기
    		manageMyBoard();
    		break;
    	default: 
    		break;
    	}
    	
    }
    

    public void enterSupplierPage(){

    	System.out.println("*****************");
        System.out.println("공급자 마이페이지");
        System.out.println("옵션을 선택해주세요.");
        System.out.println("0. 정보수정");
        System.out.println("1. 방 등록");
        System.out.println("2. 나의 방 목록");
        System.out.println("3. 거래 내역");
        System.out.println("4. 내 게시글 관리");
    	System.out.println("*****************");
    	
    	Scanner keyboard = new Scanner(System.in);
    	int option = keyboard.nextInt();
    	switch(option){
    	case 0: 
    		selectEditOpt();
    		break;
    	case 1: 
    		
    		break;
    	case 2: 
    		
    		break;
    	case 3:
    		
    		break;
    	case 4:
    		//내가 쓴 게시글 보기
    		manageMyBoard();
    		break;
    	default: 
    		break;
    	}
    }
    
    public void manageMyBoard(){//내가 작성한 게시글 보기
    	System.out.println("*********************");
    	System.out.println("0. 게시글 조회");
    	System.out.println("1. 게시글 수정");
    	System.out.println("2. 게시글 삭제");
    	System.out.println("*********************");
    	
    	Scanner keyboard = new Scanner(System.in);
    	int option = keyboard.nextInt();
    	switch(option){
    	case 0:
    		user.lookForBoard();
    		break;
    	case 1:
    		user.editMyBoard();
    		break;
    	case 2:
    		user.deleteMyBoard();
    		break;
  		default:
    			System.out.println("잘못누르셨습니다.");
    			break;
    	}
    }
    
    public void selectEditOpt(){

        System.out.println("********************");
        System.out.println("0. 비밀번호");
        System.out.println("1. 연락처");
        System.out.println("2. 직업");
        System.out.println("3. 관심위치");
        System.out.println("4. 알림수신동의여부");
        System.out.println("********************");

        Scanner keyboard = new Scanner(System.in);
        System.out.print("옵션입력> ");
        int option = keyboard.nextInt();
        keyboard.nextLine();
        switch(option){
            case 0:
                System.out.print("새 비밀번호> ");
                String passwd = keyboard.nextLine();
                user.editPasswd(passwd);
                break;
            case 1:
                System.out.print("새 연락처> ");
                String contact = keyboard.nextLine();
                user.editContact(contact);
                break;
            case 2:
                System.out.println("\n1. 학생 2. 직장인 3. 기타");
                System.out.println("번호입력> ");
                int job = keyboard.nextInt();
                user.editOccupation(job);
                break;
            case 3:
                System.out.println("선호지역 선택 (북문 / 동문 / 서문 / 정문 / 수영장문 / 테크노문 / 농장문 / 솔로문 / 조은문 / 쪽문)");
                System.out.println("지역 입력> ");
                String PreferredArea = keyboard.nextLine();
                user.editPreferredArea(PreferredArea);
                break;
            case 4:
                System.out.print("(true / false)> ");
                Boolean pAgreement = keyboard.nextBoolean();
                user.editPushAgreement(pAgreement);
                break;
            default:
                System.out.println("잘못 누르셨습니다");
                break;
        }
    }

    public void System_Exit()
    {
        File file = new File(fileName_mem);

        try {
            FileWriter fw = new FileWriter(file);

            for(User for_user:members){
                String data = for_user.getName()+ " " + for_user.getId()+ " " + for_user.getPassword() + " " +
                        for_user.getContact() + " " + for_user.getOccupation() + " " + for_user.getPreferredArea() + " " +
                        for_user.getPushAgreement() +" "+ for_user.getAverageScore() + " " + for_user.getUserState()+"\n";
                fw.write(data);
                fw.flush();
            }
            fw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }


        System.exit(0);
    }


    //////////////Getter, Setter ////////////////////////////
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public void setConsumers(Consumer consumers) {
        this.consumer = consumers;
    }

    public static ArrayList<User> getMembers() {
        return members;
    }

    public static void setMembers(ArrayList<User> members) {
        Demo.members = members;
    }

    public static ArrayList<Room> getRooms() {
        return rooms;
    }

    public static void setRooms(ArrayList<Room> rooms) {
        Demo.rooms = rooms;
    }

    public static int getRoomcode() {
        return roomcode;
    }

    public static void setRoomcode(int roomcode) {
        Demo.roomcode = roomcode;
    }

	public ArrayList<Board> getBoardList() {
		return boardList;
	}
	
	public static void setBoardList(ArrayList<Board> boardList){
		Demo.boardList = boardList;
	}
}