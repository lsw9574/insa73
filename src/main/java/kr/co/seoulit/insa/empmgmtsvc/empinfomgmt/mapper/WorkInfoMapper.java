package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.WorkInfoTO;

@Mapper
public interface WorkInfoMapper {
	
	public ArrayList<WorkInfoTO> selectWorkList(String empCode);
	public void insertWorkInfo(WorkInfoTO workInfo);;
	public void updateWorkInfo(WorkInfoTO workInfo);
	public void deleteWorkInfo(WorkInfoTO workInfo);
	
}
