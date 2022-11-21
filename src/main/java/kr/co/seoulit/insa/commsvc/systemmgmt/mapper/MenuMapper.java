package kr.co.seoulit.insa.commsvc.systemmgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.MenuTO;

@Mapper
public interface MenuMapper {
	public ArrayList<MenuTO> selectMenuList();
}
