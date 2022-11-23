package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.DeptTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.*;

public interface EmpInfoService {
	public EmpTO getEmp(String name); //selectEmp
	public String findLastEmpCode();
	public EmpTO findAllEmpInfo(String empCode);	
	public ArrayList<EmpTO> findEmpList(String dept,String workplaceCode); //findEmployeeListByDept
	public void registEmployee(EmpTO empto);
	public void modifyEmployee(EmpTO emp);
	public void deleteEmpList(ArrayList<EmpTO> empList);
	public ArrayList<DeptTO> findDeptList();
	
	public void registEmpEval(EmpEvalTO empevalto);
	public ArrayList<EmpEvalTO> findEmpEval(String workplaceCode);
	public ArrayList<EmpEvalTO> findEmpEval(String dept, String year,String workplaceCode);
	public void removeEmpEvalList(String emp_code , String apply_day);
	
	public void modifyEmpEvalList(ArrayList<EmpEvalTO> empevalList);

    public ArrayList<EmpAppointmentInfoTO> allEmpAppointInfo();

	public ArrayList<EmpAppointmentTypeTO> findAllAppointEmp(String hosu);

	public EmpAppointmentTO countAppointmentEmp(String hosu);

	public ArrayList<EmpAppointmentTypeTO> findAppointmentInfoEmp(String hosu, String type);

	public String increasingAppointmentSeq();

	public EmpAppointmentInfoTO generateHosu();


	public void registAppoint(ArrayList<ArrayList<EmpAppointmentRegTO>> arr);

	public void registAppointmentNumber(EmpAppointmentTO appointmentto);

	public ArrayList<EmpAppointmentTO> findAppointmentList();

	public ArrayList<EmpAppointmentTO> findDetailAppointmentList(String hosu);

	public ArrayList<EmpAppointmentTO> findChangeDetailList(String empCode, String hosu);

	public void modifyAppointment(ArrayList<EmpAppointmentTO> confirmAppointment);
}