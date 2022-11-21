package kr.co.seoulit.insa.commsvc.systemmgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.AdminCodeTO;

@Mapper
public interface AuthCodeMapper {
	public ArrayList<AdminCodeTO> selectAdminCodeList();
	public void updateAuthority(HashMap<String, String> map);
	public ArrayList<AdminCodeTO> selectAuthAdminCodeList(String empno);
}
