package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpEvalTO;

@Mapper
public interface EmpEvalMapper {
	
	public ArrayList<EmpEvalTO> selectEmpEval();
	public ArrayList<EmpEvalTO> selectEmpEvalDept(HashMap<String, String> map);
	
	public void insertEmpEval(EmpEvalTO empevalto);
	public void updateEmpEval(EmpEvalTO empeval);
	public void deleteEmpEval(HashMap<String, String> map);
	
}
