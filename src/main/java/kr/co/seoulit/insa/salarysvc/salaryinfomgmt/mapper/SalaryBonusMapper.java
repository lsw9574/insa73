package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.SalaryBonusTO;

@Mapper
public interface SalaryBonusMapper {
	public ArrayList<SalaryBonusTO> selectBonusSalary(String empCode);
	
	
}
