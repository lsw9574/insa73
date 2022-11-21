package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.BaseSalaryTO;

@Mapper
public interface BaseSalaryMapper {
	public ArrayList<BaseSalaryTO> selectBaseSalaryList();
	public void updateBaseSalary(BaseSalaryTO baseSalary);
	public void insertPosition(BaseSalaryTO position);
	public void deletePosition(BaseSalaryTO position);
}
