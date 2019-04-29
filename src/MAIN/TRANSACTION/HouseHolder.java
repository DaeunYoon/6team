package MAIN.TRANSACTION;

import java.util.Scanner;

public class HouseHolder {
    private String contact;

    public HouseHolder(String contact) {
        this.contact = contact;
    }
    //method

    public Boolean requestPermit(){
        Scanner sc = new Scanner(System.in);

        String answer;
        System.out.println("************************************");
        System.out.println("방이 '4방8방 방구하기' 시스템에 등록되었습니다");
        System.out.println("등록을 허가 하시겠습니까 (수락/거절) ?");
        answer = sc.nextLine();
        System.out.println("************************************");
        if (answer.equals("수락"))
            return true;
        else
            return false;
    }
}
