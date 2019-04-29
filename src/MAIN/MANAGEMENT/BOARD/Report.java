package MAIN.MANAGEMENT.BOARD;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class Report extends Board {
	private String target;
	private Date caseTime;

	public Report() {
		super.setTitle("");
		super.setBoardCode(0);
		super.setContents("");
		super.setHead("");
		super.setWriteDate(null);
		super.setId_writer("");
		super.setGoPublic(true);

		setTarget("");
		setCaseTime(null);
	}

	public Report(String title, String id_writer, Date writeDate, String contents, boolean goPublic, String head,
			String target, Date casetime) {
		super.setTitle(title);
		super.setId_writer(id_writer);
		super.setWriteDate(writeDate);
		super.setContents(contents);
		super.setGoPublic(goPublic);
		super.setHead(head);
		// super.setBoardCode();

		setTarget(target);
		setCaseTime(casetime);
	}

	@Override
	public void writePost() {
		super.writePost();
		
		super.setHead("신고");

		writeReport();
	}

	private void writeReport() {

		Scanner in = new Scanner(System.in);

		setBoardCode(getBoardCode() + 1);

		System.out.println("신고 대상의 ID를 입력하세요 > ");
		setTarget(in.nextLine());
		
		System.out.println("신고 사건의 발생 날짜를 입력하세요(yyyyMMdd > ");
		String dd = in.nextLine();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		try {
			setCaseTime(transFormat.parse(dd));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	public void writeToFile(){
		
		BufferedWriter bufferedWriter;
		try {
			bufferedWriter = new BufferedWriter(new FileWriter("board.txt", true));
			bufferedWriter.write(getBoardCode() + "\n");
			bufferedWriter.write(getTitle() + "\n");
			bufferedWriter.write(getId_writer() + "\n");
			bufferedWriter.write(getWriteDate() + "\n");
			bufferedWriter.write(getContents() + "\n");
			bufferedWriter.write(isGoPublic() + "\n");
			bufferedWriter.write(getHead() + "\n");
			bufferedWriter.write(getTarget() + "\n");
			bufferedWriter.write(getCaseTime() + "\n");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*
		 * 게시글 번호 / 제목 / id / 날짜 / 내용 / 공개여부 / 말머리
		 */

		/*
		 * 신고대상 / 사건날짜
		 */
	}
	
	public String getTarget() {
		return target;
	}

	public Date getCaseTime() {
		return caseTime;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public void setCaseTime(Date caseTime) {
		this.caseTime = caseTime;
	}

}
