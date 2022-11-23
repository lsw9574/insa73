package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpTO;

@Mapper
public interface EmpMapper {
	
	public EmpTO selectEmp(String empName);
	public String selectLastEmpCode();
	public ArrayList<EmpTO> selectEmpList(String workplaceCode);
	public ArrayList<EmpTO> selectEmpListD(String dept,String workplaceCode);
	public ArrayList<EmpTO> selectEmpListN(String name,String workplaceCode);
	public String getEmpCode(String name);
	public EmpTO selectEmployee(String empCode);

	public void registEmployee(HashMap<String, Object> map);
	public void updateEmployee(EmpTO emp);
	public void deleteEmployee(HashMap<String, String> map);
	
}
