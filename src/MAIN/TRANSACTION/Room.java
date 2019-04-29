package MAIN.TRANSACTION;

import MAIN.Demo;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Room {
    private int roomCode;
    private String contactHome;
    private int price;
    private String uploadDate;
    private String startDate;
    private String terminateDate;
    private String location;
    private String option;
    private Boolean tState;
    private String roomStructure;
    private Boolean permissionCheck;


    public Room(String contactHome, int price, String uploadDate, String startDate, String terminateDate,
                String location, String option, Boolean tState, String roomStructure, Boolean permissionCheck) {
        this.contactHome = contactHome;
        this.price = price;
        this.uploadDate = uploadDate;
        this.startDate = startDate;
        this.terminateDate = terminateDate;
        this.location = location;
        this.option = option;
        this.tState = tState;
        this.roomStructure = roomStructure;
        this.permissionCheck = permissionCheck;
    }

    public Room(int roomCode, String contactHome, int price, String uploadDate, String startDate, String terminateDate,
                String location, String option, Boolean tState, String roomStructure, Boolean permissionCheck) {
        this.roomCode = roomCode;
        this.contactHome = contactHome;
        this.price = price;
        this.uploadDate = uploadDate;
        this.startDate = startDate;
        this.terminateDate = terminateDate;
        this.location = location;
        this.option = option;
        this.tState = tState;
        this.roomStructure = roomStructure;
        this.permissionCheck = permissionCheck;
    }
    //method
    public void callAlarm() {

    }

    public Boolean callPermission() {
        Boolean result;
        HouseHolder host = new HouseHolder(contactHome);
        result = host.requestPermit();
        return result;
    }

    public void recordInformation(String id) throws IOException {
        Demo demo = new Demo();
        roomCode = demo.getRoomcode();
        BufferedWriter out  = new BufferedWriter(new FileWriter("RoomList.txt",true));
        String newM = roomCode + " " + id + " " + contactHome + " " + price + " " + uploadDate + " " + startDate + " " + terminateDate + " " +
                location + " " + option + " " + tState + " " + roomStructure+"\n" ;
        out.write(newM);
        out.close();
    }

    //getter
    public int getRoomCode() {
        return roomCode;
    }

    public String getContactHome() {
        return contactHome;
    }

    public int getPrice() {
        return price;
    }

    public String getUploadDate() {
        return uploadDate;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getTerminateDate() {
        return terminateDate;
    }

    public String getLocation() {
        return location;
    }

    public String getOption() {
        return option;
    }

    public Boolean gettState() {
        return tState;
    }

    public String getRoomStructure() {
        return roomStructure;
    }

    public Boolean getPermissionCheck() {
        return permissionCheck;
    }


    //setter
    public void setRoomCode(int roomCode) {
        this.roomCode = roomCode;
    }

    public void setContactHome(String contactHome) {
        this.contactHome = contactHome;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setTerminateDate(String terminateDate) {
        this.terminateDate = terminateDate;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public void settState(Boolean tState) {
        this.tState = tState;
    }

    public void setRoomStructure(String roomStructure) {
        this.roomStructure = roomStructure;
    }

    public void setPermissionCheck(Boolean permissionCheck) {
        this.permissionCheck = permissionCheck;
    }
}
