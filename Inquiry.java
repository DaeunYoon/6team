package MAIN.MANAGEMENT.BOARD;

import java.io.*;
import java.util.*;

public class Inquiry extends Board{

    public Inquiry(){
    	super.setTitle("");
    	super.setId_writer("");
    	super.setWriteDate(null);
    	super.setContents(null);
    	super.setGoPublic(goPublic);
    	super.setHead("");
    	super.setBoardCode(0);
    }

    public Inquiry(String title, String id_writer, 
    		Date writeDate, String contents, 
    		boolean goPublic, String head){
    	
    	super.setTitle(title);
    	super.setId_writer(id_writer);
    	super.setWriteDate(writeDate);
    	super.setContents(contents);
    	super.setGoPublic(goPublic);
    	super.setHead(head);
//    	super.setBoardCode();

    }
    
    public void setInquiry(String id, Date wdate) throws IOException
    {
        int n;
        Inquiry i = new Inquiry();
        Scanner in = new Scanner(System.in);

        i.boardCode += 1;

        System.out.println("게시글 제목을 입력하세요 > ");
        i.title = in.nextLine();

        i.id_writer = id;

        i.writeDate = wdate;

        System.out.println("게시글 내용을 입력하세요 > ");
        i.contents = in.nextLine();

        System.out.println("게시글 공개여부를 입력하세요(1:공개, 0: 비공개) > ");
        i.goPublic = in.nextBoolean();

        i.head = "문의";

        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter("board.txt",true));
        bufferedWriter.write(i.boardCode + "\n");
        bufferedWriter.write(i.title + "\n");
        bufferedWriter.write(i.id_writer + "\n");
        bufferedWriter.write(i.writeDate + "\n");
        bufferedWriter.write(i.contents + "\n");
        bufferedWriter.write(i.goPublic + "\n");
        bufferedWriter.write(i.head + "\n");
		/*
		 게시글 번호 / 제목 / id / 날짜 / 내용 / 공개여부 / 말머리
		 */
    }



}