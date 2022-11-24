package kr.co.seoulit.insa.sys.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.sql.JDBCType;

@Configuration
public class DatabaseConfig {

	@Bean
	public SqlSessionFactory sqlSessionFactory(DataSource datasource) throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(datasource);
		sqlSessionFactory.setTypeAliasesPackage("kr.co.seoulit.insa");
		sqlSessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:/mapper/**/**/*.xml"));
		SqlSessionFactory sessionFactory = sqlSessionFactory.getObject();
		sessionFactory.getConfiguration().setJdbcTypeForNull(JdbcType.NULL);
		return sessionFactory;
	}

	@Bean
	public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);

		sqlSessionTemplate.getConfiguration().setMapUnderscoreToCamelCase(true);

		return sqlSessionTemplate;
	}
	
}

