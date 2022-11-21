package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.RetirementSalaryTO;

@Mapper
public interface RetirementSalMapper {
	public ArrayList<RetirementSalaryTO> selectretirementSalaryList(String empCode);
}
