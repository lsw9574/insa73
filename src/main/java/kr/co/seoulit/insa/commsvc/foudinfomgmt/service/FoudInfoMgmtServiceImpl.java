package kr.co.seoulit.insa.commsvc.foudinfomgmt.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper.BaseWorkTimeMapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper.DeptMapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper.HolidayMapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper.PositionMapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.BaseWorkTimeTO;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.DeptTO;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.HolidayTO;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.PositionTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.DetailCodeMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.DetailCodeTO;


@Service
public class FoudInfoMgmtServiceImpl implements FoudInfoMgmtService {
	
	@Autowired
	private HolidayMapper holidayMapper;
	@Autowired
	private BaseWorkTimeMapper baseWorkTimeMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private DetailCodeMapper detailCodeMapper;
	@Autowired
	private PositionMapper positionMapper;


	@Override
	public ArrayList<DeptTO> findDeptList() {

		ArrayList<DeptTO> deptList = null;
		deptList = deptMapper.selectDeptList();
		return deptList;

	}

	@Override
	public void batchDeptProcess(ArrayList<DeptTO> deptto) {

		DetailCodeTO detailCodeTO = new DetailCodeTO();

		for (DeptTO deptBean : deptto) {

			switch (deptBean.getStatus()) {

			case "update":
				deptMapper.updateDept(deptBean);
				detailCodeTO.setDetailCodeNumber(deptBean.getDeptCode());
				detailCodeTO.setDetailCodeName(deptBean.getDeptName());
				detailCodeTO.setCodeNumber("CO-07"); // co-07이 부서관련 코드
				detailCodeTO.setDetailCodeNameusing("Y"); // 새로 만들어져서 이렇게하다 .
				detailCodeMapper.updateDetailCode(detailCodeTO);
				break;

			case "insert":
				deptMapper.registDept(deptBean);
				detailCodeTO.setDetailCodeNumber(deptBean.getDeptCode()); // 디테일코드에는 모든 코드들이 있기때문에 입력해준다.
				detailCodeTO.setDetailCodeName(deptBean.getDeptName());
				detailCodeTO.setCodeNumber("CO-07");
				detailCodeTO.setDetailCodeNameusing("Y");
				detailCodeMapper.registDetailCode(detailCodeTO);
				break;

			case "delete":
				deptMapper.deleteDept(deptBean);
				detailCodeTO.setDetailCodeNumber(deptBean.getDeptCode());
				detailCodeTO.setDetailCodeName(deptBean.getDeptName());
				detailCodeMapper.deleteDetailCode(detailCodeTO);
				break;

			case "normal":
				break;
			}
		}
	}

	
	@Override
	public ArrayList<PositionTO> findPositionList() {

		ArrayList<PositionTO> positionList = null;
		positionList = positionMapper.selectPositonList();
		return positionList;

	}

	@Override
	public void modifyPosition(ArrayList<PositionTO> positionList) {

		if (positionList != null && positionList.size() > 0) { // 아무것도 없어거나 빈배열일경우를 대비

			for (PositionTO positionTO : positionList) {
				DetailCodeTO detailCodeTO = new DetailCodeTO();
				switch (positionTO.getStatus()) {

				case "update":
					positionMapper.updatePosition(positionTO);
					detailCodeTO.setDetailCodeNumber(positionTO.getPositionCode());
					detailCodeTO.setDetailCodeName(positionTO.getPosition());
					detailCodeTO.setCodeNumber("CO-04"); // 직급과련 코드.
					detailCodeTO.setDetailCodeNameusing("Y");
					detailCodeMapper.updateDetailCode(detailCodeTO);
					break;

				case "insert":
					positionMapper.insertPosition(positionTO);
					detailCodeTO.setDetailCodeNumber(positionTO.getPositionCode());
					detailCodeTO.setDetailCodeName(positionTO.getPosition());
					detailCodeTO.setCodeNumber("CO-04");
					detailCodeTO.setDetailCodeNameusing("Y");
					detailCodeMapper.registDetailCode(detailCodeTO);
					break;

				case "delete":
					positionMapper.deletePosition(positionTO);
					detailCodeTO.setDetailCodeNumber(positionTO.getPositionCode());
					detailCodeTO.setDetailCodeName(positionTO.getPosition());
					detailCodeMapper.deleteDetailCode(detailCodeTO);
					break;
				}
			}
		}

	}

	@Override
	public ArrayList<HolidayTO> findHolidayList() {

		ArrayList<HolidayTO> holidayList = null;
		holidayList = holidayMapper.selectHolidayList();
		return holidayList;

	}

	@Override
	public String findWeekDayCount(String startDate, String endDate) {
		HashMap<String , Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		String weekdayCount = null;
		weekdayCount = holidayMapper.selectWeekDayCount(map);
		return weekdayCount;

	}

	@Override
	public void batchHolidayProcess(ArrayList<HolidayTO> holiday) {

		for (HolidayTO holidayTO : holiday) {
			switch (holidayTO.getStatus()) {

			case "update":
				holidayMapper.updateCodeList(holidayTO);
				break;

			case "insert":
				holidayMapper.insertCodeList(holidayTO);
				break;

			case "delete":
				holidayMapper.deleteCodeList(holidayTO);
				break;

			}
		}

	}

	@Override
	public ArrayList<BaseWorkTimeTO> findTimeList() {

		ArrayList<BaseWorkTimeTO> timeList = null;
		timeList = baseWorkTimeMapper.selectTimeList();
		return timeList;

	}

	@Override
	public void batchTimeProcess(ArrayList<BaseWorkTimeTO> timeList) {

		for (BaseWorkTimeTO baseWorkTimeTO : timeList) {
			switch (baseWorkTimeTO.getStatus()) {

			case "update":
				baseWorkTimeMapper.updateTime(baseWorkTimeTO);
				break;

			case "insert":
				baseWorkTimeMapper.insertTime(baseWorkTimeTO);
				break;

			case "delete":
				baseWorkTimeMapper.deleteTime(baseWorkTimeTO);
				break;
			}
		}
	}

}
