package MAIN.TRANSACTION;

import java.util.Date;
import java.util.Scanner;

public class Transaction {
    private String consumer;
    private String supplier;
    private Date completeDate;
    private Date rentalStateDate;
    private Date rentalFinishDate;
    private int roomCode;
    private Review r1;
    private Review r2;

    public Transaction(String Provider, String consumer, Date rentalStateDate, Date rentalFinishDate, int roomCode) {
        long lDate = System.currentTimeMillis();
        this.completeDate = new Date(lDate);
        this.rentalStateDate = rentalStateDate;
        this.rentalFinishDate = rentalFinishDate;
        this.roomCode = roomCode;
    }

    //method
    public void requestForScore(){
        Scanner sc = new Scanner(System.in);
        int consumToSupp, suppToConsum;
        long current = System.currentTimeMillis();
        long Finish = this.rentalFinishDate.getTime();
        if(Finish < current) {
            System.out.println(this.supplier + "님 " + this.consumer + "님에 대한 평점을 매겨주세요 : ");
            suppToConsum = sc.nextInt();
            System.out.println(this.consumer + "님 " + this.supplier + "님에 대한 평점을 매겨주세요 : ");
            consumToSupp= sc.nextInt();
            r1.updateScore(this.supplier, this.consumer, suppToConsum, this);
            r2.updateScore(this.consumer, this.supplier, consumToSupp, this);
        }
    }

    public void requestForReview(){
        Scanner sc = new Scanner(System.in);
        String consumToSupp, suppToConsum;
        long current = System.currentTimeMillis();
        long Finish = this.rentalFinishDate.getTime();
        if(Finish < current) {
            System.out.println(this.supplier + "님 " + this.consumer + "님에 대한 후기를 작성해 주세요 : ");
            suppToConsum = sc.nextLine();
            System.out.println(this.consumer + "님 " + this.supplier + "님에 대한 후기를 작성해 주세요 : ");
            consumToSupp= sc.nextLine();
            r1.updateReview(this.supplier, this.consumer, suppToConsum, this);
            r2.updateReview(this.consumer, this.supplier, consumToSupp, this);
        }
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public Date getRentalStateDate() {
        return rentalStateDate;
    }

    public void setRentalStateDate(Date rentalStateDate) {
        this.rentalStateDate = rentalStateDate;
    }

    public Date getRentalFinishDate() {
        return rentalFinishDate;
    }

    public void setRentalFinishDate(Date rentalFinishDate) {
        this.rentalFinishDate = rentalFinishDate;
    }

    public int getRoomCode() {
        return roomCode;
    }

    public void setRoomCode(int roomCode) {
        this.roomCode = roomCode;
    }
}
