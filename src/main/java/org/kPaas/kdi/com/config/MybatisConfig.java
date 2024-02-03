package org.kPaas.kdi.com.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(value = "org.kPaas.kdi.**.mapper", sqlSessionFactoryRef = "sqlSessionFactory")
public class MybatisConfig {

	private final ApplicationContext context;

	public MybatisConfig(ApplicationContext context) {
		this.context = context;
	}

	@Bean
	SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);
		sqlSessionFactoryBean.setConfigLocation(context.getResource("classpath:mybatis-config.xml"));
		sqlSessionFactoryBean.setMapperLocations(context.getResources("classpath:org/kPaas/kdi/**/mapper/*.xml"));

		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}

}
