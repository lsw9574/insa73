package kr.co.seoulit.insa.sys.util;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BoardTO;

public class BoardFile {
	private int file_seq = 0;
	private BoardTO board = null;
	private String fileName = null;
	private String tempFileName = null;
	public int getFile_seq() {
		return file_seq;
	}
	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}
	public BoardTO getBoard() {
		return board;
	}
	public void setBoard(BoardTO board) {
		this.board = board;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getTempFileName() {
		return tempFileName;
	}
	public void setTempFileName(String tempFileName) {
		this.tempFileName = tempFileName;
	}
}

