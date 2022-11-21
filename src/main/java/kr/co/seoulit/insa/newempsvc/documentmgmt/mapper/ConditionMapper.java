package kr.co.seoulit.insa.newempsvc.documentmgmt.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.ConditionTO;

@Mapper
public interface ConditionMapper {
	public void registCondition(ConditionTO nemp);

	public ArrayList<ConditionTO> FindAllTermlist();
}
