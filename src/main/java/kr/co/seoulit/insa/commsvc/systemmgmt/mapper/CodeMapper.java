package kr.co.seoulit.insa.commsvc.systemmgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.CodeTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.AppointmentTO;

@Mapper
public interface CodeMapper {

	public ArrayList<CodeTO> selectCode();
	public ArrayList<AppointmentTO> selectAppointment();

}