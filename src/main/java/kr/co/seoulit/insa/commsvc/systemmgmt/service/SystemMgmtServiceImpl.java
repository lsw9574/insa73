package kr.co.seoulit.insa.commsvc.systemmgmt.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.HolidayTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.exception.WorkplaceMissMatchException;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.commsvc.systemmgmt.exception.IdNotFoundException;
import kr.co.seoulit.insa.commsvc.systemmgmt.exception.PwMissMatchException;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.AuthCodeMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.BoardMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.CodeMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.DetailCodeMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.MenuMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.ReportMapper;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper.EmpMapper;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpTO;
import kr.co.seoulit.insa.sys.util.BoardFile;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.AppointmentTO;

@Service
public class SystemMgmtServiceImpl implements SystemMgmtService {

	@Autowired
	private EmpMapper empMapper;
	@Autowired
	private AuthCodeMapper adminMapper;
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private DetailCodeMapper detailCodeMapper;
	@Autowired
	private ReportMapper reportMapper;
	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private CodeMapper codeMapper;


	@Override
	public EmpTO findEmp(String workplaceCode,String empName, String empCode, HttpServletRequest request, HttpServletResponse response)
			throws IdNotFoundException, PwMissMatchException, WorkplaceMissMatchException {
		EmpTO emp = empMapper.selectEmp(empName);

		if (emp == null) {

			throw new IdNotFoundException("사원명이 존재하지 않습니다");

		} else {

			if (emp.getEmpCode().equals(empCode)) {
				if(emp.getWorkplaceCode().equals(workplaceCode)) {
					if (request.getParameter("box") == null) { // loginForm에서 id기억시키기 항목을 체크하지 않았다면, 쿠키삭제 진행

						Cookie[] array = request.getCookies();

						if (array != null) {
							for (Cookie coo : array) {
								if (coo.getName().equals("id")) {
									Cookie c = new Cookie("id", "");
									c.setMaxAge(0);
									response.addCookie(c);
								}
							}
						}

					} else { // 아이디 기억하기에 체크를 한 경우 응답객체에 쿠키를 담아 날려 보낸다 . 2시간 지속 ~
						Cookie coo = new Cookie("name", empName);
						coo.setMaxAge(60 * 120); // 2시간
						response.addCookie(coo);
					}

					return emp;
				} else { throw new WorkplaceMissMatchException("회사코드가 일치하지 않습니다람쥐");
				}
			} else { // 사원번호가 일치하지 않는경우
				throw new PwMissMatchException("사원번호가 일치하지 않습니다");
			}
		}
	}

	@Override
	public ArrayList<DetailCodeTO> findDetailCodeList(String codetype) {

		ArrayList<DetailCodeTO> detailCodeto = null;
		detailCodeto = detailCodeMapper.selectDetailCodeList(codetype);
		return detailCodeto;

	}

	@Override
	public ArrayList<DetailCodeTO> findDetailCodeListRest(String code1, String code2, String code3) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("code1", code1);
		map.put("code2", code2);
		map.put("code3", code3);
		ArrayList<DetailCodeTO> detailCodeto = null;
		detailCodeto = detailCodeMapper.selectDetailCodeListRest(map);
		return detailCodeto;

	}

	@Override
	public void registEmpImg(String empCode, String imgExtend) {

		EmpTO emp = empMapper.selectEmployee(empCode);
		if (emp == null) {
			emp = new EmpTO();
			emp.setEmpCode(empCode);
			emp.setStatus("insert");
		} else {
			emp.setStatus("update");
		}

		emp.setImgExtend(imgExtend);

		empMapper.updateEmployee(emp);

	}

	@Override
	public ArrayList<CodeTO> findCodeList() {

		ArrayList<CodeTO> codeto = null;
		codeto = codeMapper.selectCode();
		return codeto;

	}


	@Override
	public ArrayList<AppointmentTO> findAppList() {

		ArrayList<AppointmentTO> appointmentto = null;
		appointmentto = codeMapper.selectAppointment();
		return appointmentto;

	}


	@Override
	public ReportTO viewReport(String empCode) {

		ReportTO to = null;
		to = reportMapper.selectReport(empCode);
		return to;

	}

	@Override
	public ReportSalaryTO viewSalaryReport(String empCode, String applyMonth) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("applyMonth", applyMonth);
		ReportSalaryTO to = null;
		to = reportMapper.selecSalarytReport(map);
		return to;

	}

	@Override
	public ArrayList<BoardTO> getBoardList() {

		ArrayList<BoardTO> list=null;
		list = boardMapper.selectAllBoardList();
		return list;

	}

	@Override
	public void addBoard(BoardTO board) {

		if (board.getReply_seq() == 0) {
			boardMapper.insertBoard(board);
		} else {
			boardMapper.insertReplyBoard(board);
		}
		List<BoardFile> files = board.getBoardFiles();
		for (BoardFile file : files) {
			boardMapper.insertBoardFile(file);
		}

	}

	@Override
	public BoardTO getBoard(int board_seq) {

		BoardTO board=null;
		board = boardMapper.selectBoard(board_seq);
		ArrayList<BoardFile> fileList = boardMapper.selectBoardFile(board_seq);
		for (BoardFile file : fileList) {
			board.addBoardFile(file);
		}
		return board;

	}

	@Override
	public void changeHit(int board_seq) {

		boardMapper.updateHit(board_seq);

	}

	@Override
	public BoardTO getBoard(String sessionId, int board_seq) {

		BoardTO board=null;
		board = boardMapper.selectBoard(board_seq);
		if (!sessionId.equals(board.getName())) {
			changeHit(board_seq);
		}

		ArrayList<BoardFile> fileList = boardMapper.selectBoardFile(board_seq);
		for (BoardFile file : fileList) {
			board.addBoardFile(file);
		}
		return board;

	}

	@Override
	public int getRowCount() {

		int dbCount=0;
		dbCount = boardMapper.selectRowCount();
		return dbCount;

	}

	@Override
	public ArrayList<BoardTO> getBoardList(int sr, int er) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("start", sr);
		map.put("end", er);
		ArrayList<BoardTO> list=null;
		list = boardMapper.selectBoardList(map);
		return list;

	}

	public void removeBoard(int board_seq) {

		boardMapper.deleteBoard(board_seq);
		boardMapper.deleteBoardFile(board_seq);

	}

	@Override
	public ArrayList<MenuTO> findMenuList() {

		ArrayList<MenuTO> menuList=null;
		menuList = menuMapper.selectMenuList();
		return menuList;

	}

	@Override
	public ArrayList<AdminCodeTO> adminCodeList() {

		ArrayList<AdminCodeTO> amdList=null;
		amdList = adminMapper.selectAdminCodeList();
		return amdList;

	}

	@Override
	public void modifyAuthority(String empCode, String adminCode) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("adminCode", adminCode);

		adminMapper.updateAuthority(map);

	}

	@Override
	public ArrayList<AdminCodeTO> authadminCodeList(String empno) {

		ArrayList<AdminCodeTO> authadminList=null;
		authadminList = adminMapper.selectAuthAdminCodeList(empno);
		return authadminList;

	}
	@Override
	public void batchCodelistProcess(ArrayList<DetailCodeTO> detailCodeList){
		for (DetailCodeTO detailCodeTO : detailCodeList) {
			switch (detailCodeTO.getStatus()) {

				case "update":
					detailCodeMapper.updateDetailCode(detailCodeTO);
					break;

				case "insert":
					detailCodeMapper.registDetailCode(detailCodeTO);
					break;

				case "delete":
					detailCodeMapper.deleteDetailCode(detailCodeTO);
					break;

			}
		}
	}
}