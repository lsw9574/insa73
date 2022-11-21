package kr.co.seoulit.insa.retirementsvc.retirementmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RetirementReceiptTO {
    private String
            empName,
            deptName,
            birthdate,
            position,
            address,
            retirementRange,
            hiredate,
            retiredate,
            retirementPayCheckDate,
            retirementPayDate,
            retirementPay,
            workplaceName,
            workplaceAddress,
            today;
}