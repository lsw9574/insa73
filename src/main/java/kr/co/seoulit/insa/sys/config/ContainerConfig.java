package kr.co.seoulit.insa.sys.config;

import org.apache.catalina.connector.Connector;
import org.apache.coyote.ajp.AbstractAjpProtocol;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@Data
public class ContainerConfig {
	
	@Value("${tomcat.ajp.port}")
	int ajpPort;
	
	@Value("${tomcat.ajp.remoteauthentication}")
	String remoteAuthentication;
	
	@Value("${tomcat.ajp.enabled}")
	boolean tomcatAjpEnabled;
	
	@Bean
	public TomcatServletWebServerFactory servletContainer() {

		TomcatServletWebServerFactory Tomcat = new TomcatServletWebServerFactory();
		if (tomcatAjpEnabled)
		{
			Connector ajpConnector = new Connector("AJP/1.3");
			ajpConnector.setPort(ajpPort);
			ajpConnector.setSecure(false);
			ajpConnector.setAllowTrace(false);
			ajpConnector.setScheme("https");

			((AbstractAjpProtocol<?>) ajpConnector.getProtocolHandler()).setSecretRequired(false);
			Tomcat.addAdditionalTomcatConnectors(ajpConnector);
		}
		return Tomcat;
	}
}