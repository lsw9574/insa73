package kr.co.seoulit.insa.newempsvc.newempinfomgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PersonalityInterviewTO
{
	private String p_code, p_name;
	private int p_age, p_challenge, p_creativity, p_passion, p_cooperation, p_globalmind,
				i_attitude, i_scrupulosity, i_reliability, i_creativity, i_positiveness;
	
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getP_age() {
		return p_age;
	}
	public void setP_age(int p_age) {
		this.p_age = p_age;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public int getP_challenge() {
		return p_challenge;
	}
	public void setP_challenge(int p_challenge) {
		this.p_challenge = p_challenge;
	}
	public int getP_creativity() {
		return p_creativity;
	}
	public void setP_creativity(int p_creativity) {
		this.p_creativity = p_creativity;
	}
	public int getP_passion() {
		return p_passion;
	}
	public void setP_passion(int p_passion) {
		this.p_passion = p_passion;
	}
	public int getP_cooperation() {
		return p_cooperation;
	}
	public void setP_cooperation(int p_cooperation) {
		this.p_cooperation = p_cooperation;
	}
	public int getP_globalmind() {
		return p_globalmind;
	}
	public void setP_globalmind(int p_globalmind) {
		this.p_globalmind = p_globalmind;
	}
	public int getI_attitude() {
		return i_attitude;
	}
	public void setI_attitude(int i_attitude) {
		this.i_attitude = i_attitude;
	}
	public int getI_scrupulosity() {
		return i_scrupulosity;
	}
	public void setI_scrupulosity(int i_scrupulosity) {
		this.i_scrupulosity = i_scrupulosity;
	}
	public int getI_reliability() {
		return i_reliability;
	}
	public void setI_reliability(int i_reliabilty) {
		this.i_reliability = i_reliabilty;
	}
	public int getI_creativity() {
		return i_creativity;
	}
	public void setI_creativity(int i_creativity) {
		this.i_creativity = i_creativity;
	}
	public int getI_positiveness() {
		return i_positiveness;
	}
	public void setI_positiveness(int i_positiveness) {
		this.i_positiveness = i_positiveness;
	}
	
}
