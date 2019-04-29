package MAIN.FILTER;


import java.util.ArrayList;

public class Wish {
   private int roomCode;
   private String contactHome;
   private int price;
   private String uploadDate;
   private String startDate;
   private String terminateDate;
   private ArrayList<Boolean> location;
   private ArrayList<Boolean> option;
   private boolean tState;
    private String roomStructure;
   
   
   public Wish() {
      
   }
   
   public Wish(int roomCode, String contactHome, int price, String uploadDate, String startDate, String terminateDate, ArrayList<Boolean> location, ArrayList<Boolean> option, boolean tstate) {
      
   }
   
   public int getroomCode() {
      return roomCode;
   }
   
   public void setroomCode(int roomCode) {
      this.roomCode = roomCode;
   }
   
   public String getcontactHome() {
      return contactHome;
   }
   
   public void setroomCode(String contactHome) {
      this.contactHome = contactHome;
   }
   
   public int getPrice() {
      return price;
   }
   
   public void setPrice(int price) {
      this.price = price;
   }
   
   public String getUploadeDate() {
      return uploadDate;
   }
   
   public void setUploadeDate(String uploadDate) {
      this.uploadDate = uploadDate;
   }
   
   public String getStartDate() {
      return startDate;
   }
   
   public void setStartDate(String startDate) {
      this.startDate = startDate;
   }
   
   public String getTerminateDate() {
      return terminateDate;
   }
   
   public void setTerminateDate(String terminateDate) {
      this.terminateDate = terminateDate;
   }
   
   public ArrayList<Boolean> getLocation(){
      return location;
   }
   
   public void setLocation(ArrayList<Boolean> location) {
      this.location = location;
   }
   
   public ArrayList<Boolean> getOption(){
      return option;
   }
   
   public void setOption(ArrayList<Boolean> option) {
      this.option = option;
   }
   
   public boolean gettState() {
      return tState;
   }
   
   public void settState(boolean tState) {
      this.tState = tState;
   }
   
    public String getRoomStructure() {
        return roomStructure;
    }
   
    public void setRoomStructure(String roomStructure) {
        this.roomStructure = roomStructure;
    }
    
    public void print_info(){

           System.out.println("***************************************");
           System.out.printf("방번호: %d\n", getroomCode());
           System.out.printf("집주인 연락처: %s\n", getcontactHome());
           System.out.printf("가격: %d", getPrice());
           System.out.printf("업로드 날짜: %s\n", getUploadeDate());
           System.out.printf("대여시작일: %s\n", getStartDate());
           System.out.printf("대여종료일: %s\n", getTerminateDate());
           System.out.printf("위치: %s\n", getLocation());
           System.out.printf("옵션: %s\n", getOption());
           System.out.printf("방구조: %s\n", getRoomStructure());
           System.out.println("***************************************");

        }
}
