package org.kPaas.kdi.com.config;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.sql.DataSource;

import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

import com.zaxxer.hikari.HikariDataSource;

/**
 * 동적으로 사용할 DB정보를 제공/등록/수정/삭제하는 기능
 */
@Configuration
public class KdiRoutingDataSource extends AbstractRoutingDataSource {
	private final Map<Object, Object> kdiDataSourceMap = new ConcurrentHashMap<Object, Object>();

	public KdiRoutingDataSource( // application.properties 정의된 spring.datasource 설정
			DataSourceProperties dataSourceProperties) {
		kdiDataSourceMap.put(KdiContextHolder.DEFAULT,
				dataSourceProperties.initializeDataSourceBuilder().type(HikariDataSource.class).build());
		super.setTargetDataSources(kdiDataSourceMap);
	}

	@Override
	protected Object determineCurrentLookupKey() {
		return KdiContextHolder.get();
	}

	/**
	 * 동적으로 사용할 DB정보를 등록/수정 기능
	 * 
	 * @param dataSourceName
	 * @param dataSource
	 */
	public synchronized void put(DatasourceVo vo) {
		DataSourceProperties prop = new DataSourceProperties();
		prop.setUrl(vo.getDsUrl());
		// 현재 KDI코드에서 Ds_driver값이 확인안됨
		// prop.setDriverClassName(vo.getDs_driver());
		prop.setUsername(vo.getDsUsrNm());
		prop.setPassword(vo.getDsUsrPw());

		// 데이터소스 호출시 사용될 Key값
		String dataSourceName = vo.getDsNm();
		// 데이터소스 반영작업
		try {
			if (!kdiDataSourceMap.containsKey(dataSourceName)) {
				return;
			}
			if (null == kdiDataSourceMap.get(dataSourceName)) {
				return;
			}
			// 기존 데이터소스풀(HikariDataSource) 있으면 Close
			((HikariDataSource) kdiDataSourceMap.get(dataSourceName)).close();
		} finally {
			// 데이터소스 생성
			DataSource newDataSource = prop.initializeDataSourceBuilder().type(HikariDataSource.class).build();

			// 데이터소스 입력
			kdiDataSourceMap.put(dataSourceName, newDataSource);

			// 최신화된 kdiDataSourceMap 정보 반영
			super.afterPropertiesSet();
		}
	}

	/**
	 * 동적으로 사용할 DB정보를 삭제 기능
	 * 
	 * @param dataSourceName
	 * @param dataSource
	 */
	public synchronized void remove(final String dataSourceName) {
		if (!kdiDataSourceMap.containsKey(dataSourceName)) {
			return;
		}
		try {
			if (null == kdiDataSourceMap.get(dataSourceName)) {
				return;
			}
			((HikariDataSource) kdiDataSourceMap.get(dataSourceName)).close();
		} finally {
			kdiDataSourceMap.remove(dataSourceName);
			// 최신화된 kdiDataSourceMap 정보 반영
			super.afterPropertiesSet();
		}

	}

	public boolean contains(final String dataSourceName) {
		//System.out.println(kdiDataSourceMap.containsKey(dataSourceName));
		
		return kdiDataSourceMap.containsKey(dataSourceName);
	}
}
