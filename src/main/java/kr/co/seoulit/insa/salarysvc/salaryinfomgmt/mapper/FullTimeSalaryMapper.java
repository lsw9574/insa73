package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.FullTimeSalTO;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.PayDayTO;

@Mapper
public interface FullTimeSalaryMapper {
	
	public HashMap<String, Object> selectFullTimeSalary(HashMap<String, Object> map); 
	public ArrayList<FullTimeSalTO> findAllMoney(String empCode); 
	public void updateFullTimeSalary(FullTimeSalTO fullTimeSalary); 
	public ArrayList<PayDayTO> selectPayDayList();
	
}
