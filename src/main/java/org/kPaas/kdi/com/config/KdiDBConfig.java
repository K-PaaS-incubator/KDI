package org.kPaas.kdi.com.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.AdviceMode;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@MapperScan("org.kPaas.kdi.**.mapper")
@EnableTransactionManagement(proxyTargetClass = true, mode = AdviceMode.PROXY) // <tx:annotation-driven>
public class KdiDBConfig {

	@Bean
	DataSource dataSource(KdiRoutingDataSource kdiRoutingDataSource) {
		return kdiRoutingDataSource;
	}

	@Bean
	SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		sqlSessionFactory.getConfiguration().setMapUnderscoreToCamelCase(true);
		return new SqlSessionTemplate(sqlSessionFactory);
	}

	@Bean
	TransactionManager transactionManager(DataSource dataSource) {
		return new DataSourceTransactionManager(dataSource);
	}

}
