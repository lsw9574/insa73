package kr.co.seoulit.insa.commsvc.foudinfomgmt.to;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BaseWorkTimeTO extends BaseTO {
	
  String applyYear, attendTime, quitTime, lunchStartTime, lunchEndTime, dinnerStartTime,
      dinnerEndTime, overEndTime, nightEndTime;

public String getApplyYear() {
	return applyYear;
}

public void setApplyYear(String applyYear) {
	this.applyYear = applyYear;
}

public String getAttendTime() {
	return attendTime;
}

public void setAttendTime(String attendTime) {
	this.attendTime = attendTime;
}

public String getQuitTime() {
	return quitTime;
}

public void setQuitTime(String quitTime) {
	this.quitTime = quitTime;
}

public String getLunchStartTime() {
	return lunchStartTime;
}

public void setLunchStartTime(String lunchStartTime) {
	this.lunchStartTime = lunchStartTime;
}

public String getLunchEndTime() {
	return lunchEndTime;
}

public void setLunchEndTime(String lunchEndTime) {
	this.lunchEndTime = lunchEndTime;
}

public String getDinnerStartTime() {
	return dinnerStartTime;
}

public void setDinnerStartTime(String dinnerStartTime) {
	this.dinnerStartTime = dinnerStartTime;
}

public String getDinnerEndTime() {
	return dinnerEndTime;
}

public void setDinnerEndTime(String dinnerEndTime) {
	this.dinnerEndTime = dinnerEndTime;
}

public String getOverEndTime() {
	return overEndTime;
}

public void setOverEndTime(String overEndTime) {
	this.overEndTime = overEndTime;
}

public String getNightEndTime() {
	return nightEndTime;
}

public void setNightEndTime(String nightEndTime) {
	this.nightEndTime = nightEndTime;
}

}
