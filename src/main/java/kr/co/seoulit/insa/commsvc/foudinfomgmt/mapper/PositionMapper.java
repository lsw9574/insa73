package kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.PositionTO;

@Mapper
public interface PositionMapper {
	public void updatePosition(PositionTO position);
	public void insertPosition(PositionTO position);
	public void deletePosition(PositionTO position);
	public ArrayList<PositionTO> selectPositonList();
}
