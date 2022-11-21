package kr.co.seoulit.insa.commsvc.systemmgmt.mapper;

import java.util.*;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.DetailCodeTO;

@Mapper
public interface DetailCodeMapper {
	public ArrayList<DetailCodeTO> selectDetailCodeList(String codetype);
	public ArrayList<DetailCodeTO> selectDetailCodeListRest(HashMap<String, String> map);

	public void updateDetailCode(DetailCodeTO detailCodeto);
	public void registDetailCode(DetailCodeTO detailCodeto);
	public void deleteDetailCode(DetailCodeTO detailCodeto);
	
}