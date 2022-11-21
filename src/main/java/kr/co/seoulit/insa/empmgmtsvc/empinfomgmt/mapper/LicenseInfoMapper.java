package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.LicenseInfoTO;

@Mapper
public interface LicenseInfoMapper {
	
	public ArrayList<LicenseInfoTO> selectLicenseList(String empCode);
	public void insertLicenseInfo(LicenseInfoTO licenscInfo);
	public void updateLicenseInfo(LicenseInfoTO licenscInfo);
	public void deleteLicenseInfo(LicenseInfoTO licenscInfo);
	
}
