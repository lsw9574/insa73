package kr.co.seoulit.insa.newempsvc.newempinfomgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.ApplicantTO;

@Mapper
public interface SuccessApplicantMapper {
	public ArrayList<ApplicantTO> FindAllSuccessApplicant(HashMap<String, Object> map);
}
