package MAIN.MANAGEMENT.BOARD;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import MAIN.MANAGEMENT.Answer;
import MAIN.TRANSACTION.USER.User;

public class Board {

	private Answer answer;
	protected int boardCode;
	protected String title;
	protected String id_writer;
	protected Date writeDate;
	protected String contents;
	protected boolean goPublic;
	protected String head;

    private User user;
    
    public Board() {
    	setBoardCode(0);
    	setTitle("");
    	setId_writer("");
    	setWriteDate(null);
    	setContents("");
    	setGoPublic(true);
    	setHead("문의");
    	
    	answer = null;
    }


    public void writePost(){
    	
    	Scanner keyboard = new Scanner(System.in);

		System.out.print("제목: ");
		setTitle(keyboard.nextLine());
		
		System.out.println("내용입력(Enter사용금지):");
		setContents(keyboard.nextLine());
    	
		System.out.print("공개여부설정(O/X) : ");
		String P = keyboard.nextLine();
		if(P.equals("X"))
			setGoPublic(false);
		else
			setGoPublic(true);
    	
    }
    
    //답변 찾아서 출력
    public void lookForAnswer() throws IOException
    {
        int code, ocode;
        String temp;

        Scanner in = new Scanner(System.in);
        Scanner Afile = null;

        try
        {
            Afile = new Scanner(new FileInputStream("answer.txt"));
        }
        catch(FileNotFoundException e)
        {
            System.out.println("File Not Found");
            System.exit(0);
        }

        System.out.println("답글을 보고싶은 게시글 번호를 입력하세요 > ");
        ocode = in.nextInt(); //찾는 게시글 번호

        while(Afile.hasNext())
        {
            code = Afile.nextInt(); //게시글번호 날짜 답변 순으로 파일에 저장됨
            if(code == ocode)
            {
                System.out.println("게시글 번호	: " + code);
                System.out.println("게시 날짜	: " + Afile.nextLine());
                System.out.println("답변");
                System.out.println(Afile.nextLine());
                return;
            }
            temp = Afile.nextLine();
            temp = Afile.nextLine();
        }
        System.out.println("해당 게시글에 답변이 없습니다");

        return;

    }

    public void editPost(){

    }

    public void deletePost(){

    }
    
	public int getBoardCode() {
		return boardCode;
	}
	public String getTitle() {
		return title;
	}
	public String getId_writer() {
		return id_writer;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public String getContents() {
		return contents;
	}
	public boolean isGoPublic() {
		return goPublic;
	}
	public String getHead() {
		return head;
	}
    public void setBoardCode(int boardCode) {
		this.boardCode = boardCode;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setId_writer(String id_writer) {
		this.id_writer = id_writer;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public void setGoPublic(boolean goPublic) {
		this.goPublic = goPublic;
	}
	public void setHead(String head) {
		this.head = head;
	}
    
}
