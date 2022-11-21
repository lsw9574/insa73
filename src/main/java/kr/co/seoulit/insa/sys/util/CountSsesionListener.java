package kr.co.seoulit.insa.sys.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class CountSsesionListener
 *
 */
public class CountSsesionListener implements HttpSessionListener {
	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public void sessionCreated(HttpSessionEvent sessionEvent)  { // 세션이 생성될 때마다 호출
    	
    	HttpSession session=sessionEvent.getSession();
    	ServletContext application=session.getServletContext();
    	
    	if(application.getAttribute("ac")==null) {
    		application.setAttribute("ac", 0);    		
    	}
    		
    	int activeCnt=(Integer)application.getAttribute("ac");    	    	
    	application.setAttribute("ac", ++activeCnt); 
    }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent sessionEvent)  { // 세션이 사라질 때마다 호출
    	
    	HttpSession session=sessionEvent.getSession();    	
    	ServletContext application=session.getServletContext();
    	//int activeCnt=(Integer)application.getAttribute("ac");
    	//application.setAttribute("ac", --activeCnt);
    }
	
}
