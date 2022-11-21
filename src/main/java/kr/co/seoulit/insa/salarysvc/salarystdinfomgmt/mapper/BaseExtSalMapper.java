package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.BaseExtSalTO;

@Mapper
public interface BaseExtSalMapper {
	public ArrayList<BaseExtSalTO> selectBaseExtSalList();
	public void updateBaseExtSal(BaseExtSalTO baseExtSal);
}
