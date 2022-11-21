package kr.co.seoulit.insa.newempsvc.documentmgmt.to;

public class GanttDataTO
{
	private int duration;
	private String text,start_date, end_date, id, parent, open;
	//id 媛믪씠 �젙�닔�삎�쑝濡� �릺�뼱�엳吏�留� int蹂대떎 �겙 long�쓣 �뜥�룄 �뜲�씠�꽣媛� �꽆移섍린�뿉 String�쑝濡� 二쇱뼱吏�,,overflow 諛⑹�
	public String getId() {
		return id;
	}
	public String setId(String id) {
		return this.id = id;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public String getParent() {
		return parent;
	}
	public void setParent(String parent) {
		this.parent = parent;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public void setOpen(String open) {
		this.open = "true";
	}
	public String getOpen() {
		return "true";
	}
}
