package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.SocialInsTO;

@Mapper
public interface SocialInsMapper {
	public ArrayList<SocialInsTO> selectBaseInsureList(HashMap<String, Object> map);
	public void updateInsureData(SocialInsTO baseInsure);
	public void deleteInsureData(SocialInsTO baseInsure);
}