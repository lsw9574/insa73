package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MenuTO {

  private String menu_name, super_menu_code, menu_code, depth, is_collapse, menu_url, navbar_name;

public String getMenu_name() {
	return menu_name;
}

public void setMenu_name(String menu_name) {
	this.menu_name = menu_name;
}

public String getSuper_menu_code() {
	return super_menu_code;
}

public void setSuper_menu_code(String super_menu_code) {
	this.super_menu_code = super_menu_code;
}

public String getMenu_code() {
	return menu_code;
}

public void setMenu_code(String menu_code) {
	this.menu_code = menu_code;
}

public String getDepth() {
	return depth;
}

public void setDepth(String depth) {
	this.depth = depth;
}

public String getIs_collapse() {
	return is_collapse;
}

public void setIs_collapse(String is_collapse) {
	this.is_collapse = is_collapse;
}

public String getMenu_url() {
	return menu_url;
}

public void setMenu_url(String menu_url) {
	this.menu_url = menu_url;
}

public String getNavbar_name() {
	return navbar_name;
}

public void setNavbar_name(String navbar_name) {
	this.navbar_name = navbar_name;
}

}
