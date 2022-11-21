package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import java.util.ArrayList;
import java.util.List;

import kr.co.seoulit.insa.sys.util.BoardFile;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BoardTO {
	private int board_seq;		// 게시글번호
	private int ref_seq;		// 그룹번호
	private int reply_seq;		// 어미글번호
	private int reply_level;	// 답변깊이
	private String reg_date;    // 작성일자
	private String name;		// 작성자
	private String title;		// 제목
	private String content;		// 내용
	private int hit;			// 조회수
	
	private List<BoardFile> boardFiles = new ArrayList<BoardFile>();
	
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public int getRef_seq() {
		return ref_seq;
	}
	public void setRef_seq(int ref_seq) {
		this.ref_seq = ref_seq;
	}
	public int getReply_seq() {
		return reply_seq;
	}
	public void setReply_seq(int reply_seq) {
		this.reply_seq = reply_seq;
	}
	public int getReply_level() {
		return reply_level;
	}
	public void setReply_level(int reply_level) {
		this.reply_level = reply_level;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public void setBoardFiles(List<BoardFile> boardFiles) {
		this.boardFiles = boardFiles;
	}
	public void addBoardFile(BoardFile boardFile){
		boardFiles.add(boardFile);
	}
	public List<BoardFile> getBoardFiles(){
		return boardFiles;
	}
	
}
