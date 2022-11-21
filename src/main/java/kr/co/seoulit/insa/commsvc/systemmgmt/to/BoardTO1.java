package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BoardTO1 extends BaseTO{

    private int num;
    private String subject;
    private String passwardBoard;
    private String reg_date;
    private String writer;
    private int ref;
    private int re_step;
    private int re_lever;
    private String content;
    private String filedBoard;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPasswardBoard() {
		return passwardBoard;
	}
	public void setPasswardBoard(String passwardBoard) {
		this.passwardBoard = passwardBoard;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_lever() {
		return re_lever;
	}
	public void setRe_lever(int re_lever) {
		this.re_lever = re_lever;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFiledBoard() {
		return filedBoard;
	}
	public void setFiledBoard(String filedBoard) {
		this.filedBoard = filedBoard;
	}
      
}
