package kr.co.seoulit.insa.attdsvc.attdmgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;

@Mapper
public interface ExcusedAttndMapper {
	
	public ArrayList<RestAttdTO> selectRestAttdList(HashMap<String, String> map);
	public ArrayList<RestAttdTO> selectRestAttdListCode(HashMap<String, String> map);	
	public void insertRestAttd(RestAttdTO restAttd);
	public void deleteRestAttd(RestAttdTO restAttd);
	
	public ArrayList<RestAttdTO> selectRestAttdListByAllDept(String applyDay,String workplaceCode);
	public ArrayList<RestAttdTO> selectRestAttdListByDept(HashMap<String , Object> map);
	public void updateRestAttd(RestAttdTO restAttd);
	
}
