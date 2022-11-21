package kr.co.seoulit.insa.commsvc.foudinfomgmt.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.BaseWorkTimeTO;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.DeptTO;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.HolidayTO;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.PositionTO;

public interface FoudInfoMgmtService {

  //부서정보관리
  public void batchDeptProcess(ArrayList<DeptTO> deptTO);
  public ArrayList<DeptTO> findDeptList();

  //직위정보관리
  public ArrayList<PositionTO> findPositionList();
  public void modifyPosition(ArrayList<PositionTO> positionList);

  //공휴일정보관리
  public ArrayList<HolidayTO> findHolidayList();
  public String findWeekDayCount(String startDate, String endDate);
  public void batchHolidayProcess(ArrayList<HolidayTO> holidayList);

  //기준근무시간관리
  public ArrayList<BaseWorkTimeTO> findTimeList();
  public void batchTimeProcess(ArrayList<BaseWorkTimeTO> timeTO);

}
