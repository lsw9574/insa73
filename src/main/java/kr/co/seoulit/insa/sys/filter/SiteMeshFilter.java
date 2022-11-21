package kr.co.seoulit.insa.sys.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.content.tagrules.html.DivExtractingTagRuleBundle;

public class SiteMeshFilter extends ConfigurableSiteMeshFilter {

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("/*", "/WEB-INF/views/decorator/decorator.jsp")
				.addExcludedPath("/comm/codeWindow/view*").addExcludedPath("/comm/postWindow/view*")
				.addExcludedPath("/comm/agWindow/view*").addExcludedPath("/comm/modifyResumeWindow/view*")
				.addExcludedPath("/comm/insertIntoNewApplication/view*").addExcludedPath("/top/view*");

		builder.addTagRuleBundles(new DivExtractingTagRuleBundle());
	}
}