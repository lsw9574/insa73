package kr.co.seoulit.insa.retirementsvc.retirementmgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RetirementPayTO {
    private String empName, retirementPay,retirementRange, hiredate, retiredate, retirementBonus, retirementAwards;
}