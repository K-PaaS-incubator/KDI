package org.kPaas.kdi.main.res.ds.service.impl;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.com.config.KdiRoutingDataSource;
import org.kPaas.kdi.main.res.ds.mapper.DatasourceMapper;
import org.kPaas.kdi.main.res.ds.service.DatasourceService;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service("DatasourceService")
public class DatasourceServiceImpl extends KdiGridServiceImpl implements DatasourceService {

	@Resource
	private DatasourceMapper mapper;

	@Autowired
	private KdiRoutingDataSource kdiRoutingDataSource;
	
	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_DATASOURCE";
	}

	@Override
	protected String getBizName() {
		return "데이터소스";
	}

	/**
	 * 최초 기동시에 데이터소스테이블(KDI_DATASOURCE)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 데이터소스테이블을 생성하는 기능
	 */
	@Override
	@PostConstruct
	protected void init() {
		super.init();
		if (!isTableExists("KDI_DATASOURCE")) {
			mapper.createTable();
		}

		/**
		 * 기입력된 데이터소스목록을 KdiRoutingDataSource에 불러오는 기능
		 */
		for (DatasourceVo vo : getDsListAll()) {
			loadDataSource(vo);
		}

	}

	private List<DatasourceVo> getDsListAll() {
		return mapper.getDsListAll();
	}
	
	/**
	 * KdiRoutingDataSource에 DataSource를 불러오는 기능
	 */
	private void loadDataSource(DatasourceVo vo) {
		kdiRoutingDataSource.put(vo);
		log.info("Load DataSource - '" + vo.getDsNm() + "'");
	}
	
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		JSONObject result = new JSONObject();
		if (null == datasource_vo) {
			result.put("stateCode", 1);
			result.put("state", "테스트 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		String ds_url = datasource_vo.getDsUrl();
		if (null == ds_url) {
			result.put("stateCode", 2);
			result.put("state", "테스트 실패");
			result.put("msg", "DB URL정보가 확인되지 않습니다.");
			return ResponseEntity.badRequest().body(result.toString());
		}
		// 현재 쓰레드의 데이터소스명 저장
		String orgContext = getContext();
		// 임시로 사용할 DataSourceName 정의
		String testDataSourceName = System.currentTimeMillis() + "-" + Thread.currentThread().getId();
		try {
			datasource_vo.setDsNm(testDataSourceName);
			kdiRoutingDataSource.put(datasource_vo);
			// 현재 쓰레드의 데이터소스를 변경하는 행위
			setContext(testDataSourceName);
			// 디비접속이 되면 쿼리가 수행됨
			String validationResult = mapper.validationQuery(datasource_vo.getDsType());
			if (null == validationResult) {
				result.put("stateCode", 4);
				result.put("state", "테스트 실패");
				result.put("msg", "ValidationQuery 수행실패");
				log.trace("ValidationQuery 수행실패. ds_nm=" + getContext());
				return ResponseEntity.badRequest().body(result.toString());
			}
			result.put("stateCode", 0);
			result.put("state", "테스트 성공");
			log.debug("테스트 성공. ds_nm=" + getContext() + ",ValidationQueryResult=" + validationResult);
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 3);
			result.put("state", "테스트 실패");
			result.put("msg", e.getRootCause().getMessage());
			log.error("접속 테스트 실패", e);
			return ResponseEntity.badRequest().body(result.toString());
		} finally {
			// 테스트를위한 임시 DataSource 삭제
			kdiRoutingDataSource.remove(testDataSourceName);
			// 현재 쓰레드의 데이터소스를 원복하는 행위
			setContext(orgContext);
		}
	}

	/**
	 * 모든 데이터소스 목록 반환
	 */
	@Override
	public ResponseEntity<String> getAllDsNm() {
		JSONObject result = new JSONObject();
		try {
			result.put("state", getBizName() + " 데이터 조회 성공");
			result.put("stateCode", 0);
			JSONArray dataArray = new JSONArray();
			dataArray.putAll(this.mapper.getAllDsNm());
			result.put("data", dataArray);
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 3);
			result.put("state", "테스트 실패");
			result.put("msg", e.getRootCause().getMessage());
			log.error("접속 테스트 실패", e);
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

}
