package kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.BaseWorkTimeTO;

@Mapper
public interface BaseWorkTimeMapper {
  public ArrayList<BaseWorkTimeTO> selectTimeList();
  public void updateTime(BaseWorkTimeTO timeBean);
  public void insertTime(BaseWorkTimeTO timeBean);
  public void deleteTime(BaseWorkTimeTO timeBean);
}
