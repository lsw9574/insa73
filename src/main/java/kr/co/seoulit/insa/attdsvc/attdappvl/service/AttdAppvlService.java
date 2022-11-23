package kr.co.seoulit.insa.attdsvc.attdappvl.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.attdsvc.attdappvl.to.DayAttdMgtTO;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.MonthAttdMgtTO;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.AnnualLeaveMgtTO;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;

public interface AttdAppvlService {
	   public ArrayList<DayAttdMgtTO> findDayAttdMgtList(String applyDay,String workplaceCode);
	   public void modifyDayAttdMgtList(ArrayList<DayAttdMgtTO> dayAttdMgtList);
	   public ArrayList<MonthAttdMgtTO> findMonthAttdMgtList(String applyYearMonth,String workplaceCode);
	   public void modifyMonthAttdMgtList(ArrayList<MonthAttdMgtTO> monthAttdMgtList);
	   public ArrayList<AnnualLeaveMgtTO> findAnnualVacationMgtList(String applyYearMonth,String workplaceCode);
	   public void modifyAnnualVacationMgtList(ArrayList<AnnualLeaveMgtTO> annualVacationMgtList);
	   public void cancelAnnualVacationMgtList(ArrayList<AnnualLeaveMgtTO> annualVacationMgtList);
	   public ArrayList<RestAttdTO> findRestAttdListByDept(String deptName, String startDate, String endDate,String workplaceCode);
	   public void modifyRestAttdList(ArrayList<RestAttdTO> restAttdList);
}
