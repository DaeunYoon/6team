package MAIN.MANAGEMENT.BOARD;

import java.io.*;
import java.util.*;

public class Suggestion extends Board{

    public Suggestion(){
    	super.setTitle("");
    	super.setId_writer("");
    	super.setWriteDate(null);
    	super.setContents(null);
    	super.setGoPublic(goPublic);
    	super.setHead("");
    	super.setBoardCode(0);
    }

    public Suggestion(String title, String id_writer, 
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

    public void setSuggestion(String id, Date wdate) throws IOException
    {
        int n;
        
        Suggestion s = new Suggestion();
        Scanner in = new Scanner(System.in);

        s.boardCode += 1;

        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter("board.txt",true));
        bufferedWriter.write(s.boardCode + "\n");
        bufferedWriter.write(s.title + "\n");
        bufferedWriter.write(s.id_writer + "\n");
        bufferedWriter.write(s.writeDate + "\n");
        bufferedWriter.write(s.contents + "\n");
        bufferedWriter.write(s.goPublic + "\n");
        bufferedWriter.write(s.head + "\n");
		/*
		 게시글 번호 / 제목 / id / 날짜 / 내용 / 공개여부 / 말머리
		 */
    }
}
