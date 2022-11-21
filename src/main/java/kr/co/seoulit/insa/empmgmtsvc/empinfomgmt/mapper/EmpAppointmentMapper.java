package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper;

import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentInfoTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentRegTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.EmpAppointmentTypeTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface EmpAppointmentMapper {

	public ArrayList<EmpAppointmentInfoTO> findAppointmentInfo();


	public ArrayList<EmpAppointmentTO> findAppointmentEmp(String hosu);

	public ArrayList<EmpAppointmentTypeTO> selectAppointmentInfoEmp(HashMap<String, String> map);

	public ArrayList<EmpAppointmentTypeTO> selectAllAppointEmp(String hosu);

	public EmpAppointmentTO countAppointmentEmp(String hosu);

	public String IncreasingAppointmentSeq();

	public String getHosu();

	public void insertEmpAppointment2(EmpAppointmentRegTO empAppointmentRegTO);

	public void insertAppointmentNumber(EmpAppointmentTO appointmentto);

	public ArrayList<EmpAppointmentTO> selectAppointmentList();

	public ArrayList<EmpAppointmentTO> selectDetailAppointmentList(String hosu);

	public ArrayList<EmpAppointmentTO> selectChangeDetailList(String empCode, String hosu);

	public void updateAppointment(EmpAppointmentTO appointmentTO);
}
