package kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.DeptTO;

@Mapper
public interface DeptMapper {
	public ArrayList<DeptTO> selectDeptList();
	
	public void updateDept(DeptTO dept);
	public void registDept(DeptTO dept);
	public void deleteDept(DeptTO dept);
}
