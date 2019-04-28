package MAIN.TRANSACTION.USER;

import java.util.ArrayList;
import java.util.Scanner;

import MAIN.Demo;
import MAIN.FILTER.SearchingFilter;
import MAIN.FILTER.Wish;
import MAIN.MANAGEMENT.BOARD.Board;
import MAIN.TRANSACTION.Review;

public class User {

    //Basic variable
    private String name;
    private String id;
    private String password;
    private String contact;
    private int occupation;
    private String preferredArea;
    private Boolean pushAgreement;
    private double averageScore;
    private String UserState;
    private int transCount;
    private ArrayList<Wish> wishRoom;
    private ArrayList<Review> review;
    private Array<SearchingFilter> sf;

    //Additional variable
    Scanner sc = new Scanner(System.in);
    Demo demo;
    ArrayList<User> userList = demo.getMembers();
    //ArrayList<Board> boardList = demo.getBoardList();

    //Constructor
    public User(){
    	
    }

    public User(String name, String id, String password, String contact,
            int occupation, String preferredArea, Boolean pushAgreement, double averageScore, String userState, int TransCnt) {
    this.name = name;
    this.id = id;
    this.password = password;
    this.contact = contact;
    this.occupation = occupation;
    this.preferredArea = preferredArea;
    this.pushAgreement = pushAgreement;
    this.averageScore = averageScore;
    this.UserState = userState;
    this.transCount = TransCnt;
}


public User(User user)
{
    this.name = user.getName();
    this.id = user.getId();
    this.password = user.getPassword();
    this.contact = user.getContact();
    this.occupation = user.getOccupation();
    this.preferredArea = user.getPreferredArea();
    this.pushAgreement = user.getPushAgreement();
    this.averageScore =  user.getAverageScore();
    this.UserState = user.getUserState();
    this.transCount = user.getTransCount();
}


    //method

    public void convertUserState(String userState) {
        if (getUserState().equals(userState)) {
            System.out.println("error");
        } else {
            for (int i = 0; i <= userList.size(); i++) {
                if (userList.get(i).getId().equals(this.id)) {
                    userList.get(i).setUserState(userState);
                    break;
                }
            }
            System.out.println("USER STATE CHANGE!");
        }
    }

    public void deactivateAccount() {
        for (int i = 0; i <= userList.size(); i++) {
            if (userList.get(i).getId().equals(this.id)) {
                userList.remove(userList.get(i));
                break;
            }
        }
    }

    //ADD WISH ROOM TO WISHLIST
    public void addToWishRoom(Wish room) {
        wishRoom.add(room);
    }

    //LOOK FOR ROOM WISHLIST
    public void lookForWishRoom() {
        Scanner input = new Scanner(System.in);
        System.out.println("WishRoom List");

        printWishRoomCode();

        System.out.print("Enter the roomCode you want to search > ");
        int search_room = input.nextInt();
        
        for (int i = 0; i < wishRoom.size(); i++) {
           Wish proom = wishRoom.get(i);
            if (search_room == proom.getroomCode()) {
                proom.print_info();
            }
        }
    }

    // DELETE THE ONE ROOM OF WISHLIST()
    public void deleteWishRoom() {
        int i, delete_roomCode;
        Scanner input = new Scanner(System.in);
        System.out.println("WishRoom List");
        printWishRoomCode();

        System.out.print("Enter the roomCode you want to delete > ");
        int delete_room = input.nextInt();
        for(i=0; i<wishRoom.size(); i++) {
            Wish proom = wishRoom.get(i);
            if(delete_room == proom.getroomCode()) {
                break;
            }
        }

        if(i==wishRoom.size()) {
            System.out.printf("Room %d is not exists in wishlist!\n", delete_room);
        }
        else {
            wishRoom.remove(i);
            System.out.printf("Room %d deleted\n", delete_room);
        }
    }


    public void printWishRoomCode() {
        int i;
        for(i=0; i<wishRoom.size(); i++) {
            Wish room = wishRoom.get(i);
            System.out.printf("%d / ", room.getroomCode());
        }
    }

    public void updateUserList(){
    	
    	//변경사항을 리스트에 적용한다
        for (int i = 0; i <= userList.size(); i++) {
            if (userList.get(i).getId().equals(this.id)) {
            	userList.remove(i);
            	userList.add(this);
            	break;
            }
        }
        
        
    }
    
    
    public void editPushAgreement(boolean pAgreement){
    	setPushAgreement(pushAgreement);
    	if(pushAgreement==true)
    		System.out.println("알림 수신이 동의되었습니다.");
    	else
    		System.out.println("알림 수신이 거부되었습니다.");
    	
    	updateUserList();
    }
    
    public void editPreferredArea(String PreferredArea){
    	setPreferredArea(PreferredArea);
    	System.out.println("관심지역이 변경되었습니다.");
    	
    	updateUserList();

    }
    
    public void editOccupation(int job){
    	setOccupation(job);
    	System.out.println("직업 변경이 완료되었습니다.");
    	
    	updateUserList();

    }
    
    public void editContact(String contact){
    	if(contact.equals(this.contact)){
    		System.out.println("현재 사용중인 번호입니다.");
    	}
    	else{
    		setContact(contact);
    		System.out.println("번호 변경이 완료되었습니다.");
    	}
    	
    	updateUserList();

    }
    
    public void editPasswd(String pass){
    	if(pass.equals(this.password)){
    		System.out.println("현재 사용중인 비밀번호입니다.");
    	}
    	else{
    		setPassword(pass);
    		System.out.println("비밀번호가 변경되었습니다.");
    	}
    	
    	updateUserList();

    }



//    private void editPush(){
//
//    }

//    public void searchRoom(){
//    	
//    }

//    public void writeScore(){
//
//    }
//
//    public void writeReview(){
//
//    }
    
    public void deleteMyBoard(){
    	ArrayList<Board> boardList = demo.getBoardList();
    	int i;
    	System.out.println("***************************************");
    	System.out.println("내 글 목록 >");
    	for(i=0; i<boardList.size(); i++){
    		Board b = boardList.get(i);
    		if(b.getId_writer().equals(id)){
				System.out.printf("\n게시글번호: %d\n 제목: %s\n 작성자: %s\n 작성일시: %s\n", 
    					b.getBoardCode(), b.getTitle(), b.getId_writer(), b.getWriteDate().toString());
    		}
    	}
    	System.out.println("***************************************\n");
    	System.out.print("삭제할 글 번호 >");
    	Scanner keyboard = new Scanner(System.in);
    	int code = keyboard.nextInt();
    	for(i=0; i<boardList.size(); i++){
    		Board b = boardList.get(i);
    		if(b.getBoardCode()==code){//글번호와 ID모두 일치해야함.
    			if(b.getId_writer()!=this.id){
    				System.out.println("본인의 게시글이 아닙니다.");
    				break;
    			}
    			boardList.remove(i);
    			System.out.printf("\n게시글 %d가 삭제되었습니다.\n",code);
    			break;
    		}
    	}
    	if(i==boardList.size()){
    		System.out.println("삭제할 게시글이 존재하지 않습니다.\n");
    	}
    }
    
    public void editMyBoard(){
    	ArrayList<Board> boardList = demo.getBoardList();
    	int i;
    	System.out.println("***************************************");
    	System.out.println("내 글 목록 >");
    	for(i=0; i<boardList.size(); i++){
    		Board b = boardList.get(i);
    		if(b.getId_writer().equals(id)){
				System.out.printf("\n게시글번호: %d\n 제목: %s\n 작성자: %s\n 작성일시: %s\n", 
    					b.getBoardCode(), b.getTitle(), b.getId_writer(), b.getWriteDate().toString());
    		}
    	}
    	System.out.println("***************************************\n");
    	System.out.print("\n수정할 글 번호 >");
    	Scanner keyboard = new Scanner(System.in);
    	int code = keyboard.nextInt();
    	for(i=0; i<boardList.size(); i++){
    		Board b = boardList.get(i);
    		if(b.getBoardCode()==code){//글번호와 ID모두 일치해야함.
    			if(b.getId_writer()!=this.id){
    				System.out.println("본인의 게시글이 아닙니다.");
    				break;
    			}
    			System.out.print("수정할 제목 > ");
    			String line = keyboard.nextLine();
    			b.setTitle(line);
    			System.out.print("수정할 내용 > ");
    			line = keyboard.nextLine();
    			b.setContents(line);
    			System.out.println("\n변경이 완료되었습니다.");
    			break;
    		}
    	}
    	if(i==boardList.size()){
    		System.out.println("변경할 게시글이 존재하지 않습니다.\n");
    	}
    }

    public void lookForBoard(){
    	ArrayList<Board> boardList = demo.getBoardList();
    	int i;
		System.out.println("***************************************");
    	for(i=0; i<boardList.size(); i++){
    		Board b = boardList.get(i);
    		if(b.getId_writer().equals(id)){
				System.out.printf("\n게시글번호: %d\n 제목: %s\n 작성자: %s\n 작성일시: %s\n", 
    					b.getBoardCode(), b.getTitle(), b.getId_writer(), b.getWriteDate().toString());
				System.out.printf("내용: \n%s\n", b.getContents());
    		}
    	}
		System.out.println("***************************************");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public int getOccupation() {
        return occupation;
    }

    public void setOccupation(int occupation) {
        this.occupation = occupation;
    }

    public String  getPreferredArea() {
        return preferredArea;
    }

    public void setPreferredArea(String preferredArea) {
        this.preferredArea = preferredArea;
    }

    public Boolean getPushAgreement() {
        return pushAgreement;
    }

    public void setPushAgreement(Boolean pushAgreement) {
        this.pushAgreement = pushAgreement;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

    public String getUserState() {
        return UserState;
    }

    public void setUserState(String userState) {
        UserState = userState;
    }

    public ArrayList<Review> getReview() {
        return review;
    }

    public void setReview(ArrayList<Review> review) {
        this.review = review;
    }
    
    public int getTransCount() {
        return transCount;
    }

    public void setTransCount(int transCount) {
        this.transCount = transCount;
    }
    
}
