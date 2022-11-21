package kr.co.seoulit.insa.newempsvc.documentmgmt.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.newempsvc.documentmgmt.to.RecruitmentTO;

@Mapper
public interface NewempApprovalMapper {

	public ArrayList<RecruitmentTO> findnewempcruit(Map<String, Object> map);

	public void RegisterEmp(RecruitmentTO recruitList);

}
