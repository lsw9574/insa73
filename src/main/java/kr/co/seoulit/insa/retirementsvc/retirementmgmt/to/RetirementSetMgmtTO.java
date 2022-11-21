package kr.co.seoulit.insa.retirementsvc.retirementmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RetirementSetMgmtTO {
    private String moelCheck, moelCheckCode, retirementRange, retirementRangeCode, monthOrDay, monthOrDayCode, retiredayCheck, retiredayCheckCode;
}