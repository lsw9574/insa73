package kr.co.seoulit.insa.retirementsvc.retirementmgmt.to;


import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RetirementPersonTO {
    private String  empCode, empName, deptName, retirementDate, workplaceName;
}
