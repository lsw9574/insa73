package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.FamilyInfoTO;

@Mapper
public interface FamilyInfoMapper {
	
	public ArrayList<FamilyInfoTO> selectFamilyList(String empCode);
	public void insertFamilyInfo(FamilyInfoTO familyInfo);
	public void updateFamilyInfo(FamilyInfoTO familyInfo);
	public void deleteFamilyInfo(FamilyInfoTO familyInfo);
	
}
