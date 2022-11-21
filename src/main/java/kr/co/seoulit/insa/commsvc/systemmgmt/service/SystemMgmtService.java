package kr.co.seoulit.insa.commsvc.systemmgmt.service;

import kr.co.seoulit.insa.commsvc.systemmgmt.exception.IdNotFoundException;
import kr.co.seoulit.insa.commsvc.systemmgmt.exception.PwMissMatchException;
import kr.co.seoulit.insa.commsvc.systemmgmt.exception.WorkplaceMissMatchException;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.*;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public interface SystemMgmtService {
	//Login Part
	public EmpTO findEmp(String workplaceCode,String name, String empCode,HttpServletRequest request, HttpServletResponse response)
			throws IdNotFoundException, PwMissMatchException, WorkplaceMissMatchException;

	//Code Part
	public ArrayList<DetailCodeTO> findDetailCodeList(String codetype);
	public ArrayList<DetailCodeTO> findDetailCodeListRest(String code1,String code2,String code3);
	public ArrayList<CodeTO> findCodeList();

	public ArrayList<AppointmentTO> findAppList();

	//IO part
	public void registEmpImg(String empCode, String imgExtend);



	// Ireport Part
	public ReportTO viewReport(String empCode);
	public ReportSalaryTO viewSalaryReport(String empCode, String applyMonth);

	//Board Part
	public ArrayList<BoardTO> getBoardList();
	public void addBoard(BoardTO board);
	public BoardTO getBoard(int board_seq);
	public BoardTO getBoard(String sessionId,int board_seq);
	public void changeHit(int board_seq);
	public int getRowCount();
	public ArrayList<BoardTO> getBoardList(int sr, int er);
	public void removeBoard(int board_seq);
	// Menu Part
	public ArrayList<MenuTO> findMenuList();

	//Authority Part
	public ArrayList<AdminCodeTO> adminCodeList();
	public void modifyAuthority(String empCode, String adminCode);

	public ArrayList<AdminCodeTO> authadminCodeList(String empno);
}