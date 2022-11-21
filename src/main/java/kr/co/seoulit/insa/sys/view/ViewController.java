package kr.co.seoulit.insa.sys.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {

	@RequestMapping("/{viewName}/view")
	public String view(@PathVariable String viewName) {
		System.out.println("요청온 url: " + viewName);
		return viewName;
	}

	@RequestMapping("/{pack}/{viewName}/view")
	public String packView(@PathVariable String pack, @PathVariable String viewName) {
		System.out.println("요청온 url: " + pack + " " + viewName);
		return pack + "/" + viewName;

	}

}
