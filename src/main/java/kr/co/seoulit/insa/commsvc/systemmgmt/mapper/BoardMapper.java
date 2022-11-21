package kr.co.seoulit.insa.commsvc.systemmgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BoardTO;
import kr.co.seoulit.insa.sys.util.BoardFile;

@Mapper
public interface BoardMapper {
	public ArrayList<BoardTO> selectAllBoardList();
	public BoardTO selectBoard(int board_seq);
	public void insertBoard(BoardTO board);
	public void insertReplyBoard(BoardTO board);
	public void insertBoardFile(BoardFile boardFiles);
	public ArrayList<BoardFile> selectBoardFile(int board_seq);
	public void updateHit(int board_seq);
	public int selectRowCount();
	public ArrayList<BoardTO> selectBoardList(HashMap<String, Object> map);
	public void deleteBoard(int board_seq);
	public void deleteBoardFile(int board_seq);
}
