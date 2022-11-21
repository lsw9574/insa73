package kr.co.seoulit.insa.attdsvc.attdmgmt.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.attdsvc.attdmgmt.to.DayAttdTO;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;

public interface AttdMgmtService {
	
	   public ArrayList<DayAttdTO> findDayAttdList(String empCode, String applyDay);
	   public ResultTO registDayAttd(DayAttdTO dayAttd);
	   public void removeDayAttdList(ArrayList<DayAttdTO> dayAttdList);
	   //public void insertDayAttd(DayAttdTO dayAttd);
	   public ArrayList<RestAttdTO> findRestAttdList(String empCode, String startDate, String endDate, String code);
	   public void registRestAttd(RestAttdTO restAttd);
	   public void removeRestAttdList(ArrayList<RestAttdTO> restAttdList);
	   
}
