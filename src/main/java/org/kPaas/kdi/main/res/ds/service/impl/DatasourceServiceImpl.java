package org.kPaas.kdi.main.res.ds.service.impl;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.config.KdiRoutingDataSource;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.res.ds.mapper.DatasourceMapper;
import org.kPaas.kdi.main.res.ds.service.DatasourceService;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class DatasourceServiceImpl extends AbstractService implements DatasourceService {

	@Resource
	private DatasourceMapper mapper;

	@Autowired
	private KdiRoutingDataSource kdiRoutingDataSource;

	/**
	 * 최초 기동시에 데이터소스테이블(KDI_DATASOURCE)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 데이터소스테이블을 생성하는 기능
	 */
	@PostConstruct
	private void init() {
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

	@Override
	public ResponseEntity<String> getList(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);

		try {
			pageInfo.setTotal(mapper.getDsListCnt(kdiParam));
			result.put("data", mapper.getDsList(kdiParam));
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} finally {
			result.put("page", new JSONObject(pageInfo));
		}
		result.put("stateCode", 0);
		result.put("state", "조회 성공");
		return ResponseEntity.ok(result.toString());
	}

	public ResponseEntity<String> insert(DatasourceVo datasource_vo) {
		JSONObject result = new JSONObject();
		if (null == datasource_vo) {
			result.put("stateCode", 1);
			result.put("state", "데이터소스정보 등록 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		datasource_vo.setRegId(getLoginUserId());
		if (null == datasource_vo.getRegId() || "".equals(datasource_vo.getRegId())) {
			result.put("stateCode", 2);
			result.put("state", "데이터소스정보 등록 실패");
			result.put("msg", "등록자 ID 확인 실패");
			return ResponseEntity.badRequest().body(result.toString());
		}
		try {
			mapper.insertDS(datasource_vo);
			// 신규데이터소스를 불러오는 행위
			loadDataSource(datasource_vo);

			result.put("stateCode", 0);
			result.put("state", "데이터소스정보 등록 완료");
			return ResponseEntity.ok(result.toString());
		} catch (Exception e) {
			result.put("stateCode", 3);
			result.put("state", "데이터소스정보 등록 실패");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> duplicateCheck(String ds_nm) {
		JSONObject result = new JSONObject();
		result.put("stateCode", 0);
		result.put("state", "중복검사 요청 성공");
		result.put("data", mapper.getSameDsCheck(ds_nm));
		return ResponseEntity.ok(result.toString());
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
		// 현제 쓰레드의 데이터소스명 저장
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

	@Override
	public DatasourceVo get(String ds_nm) {
		return mapper.selectDsInfo(ds_nm);
	}

	@Override
	public ResponseEntity<String> modify(DatasourceVo datasource_vo) {
		JSONObject result = new JSONObject();
		if (null == datasource_vo) {
			result.put("stateCode", 1);
			result.put("state", "데이터소스정보 수정 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		datasource_vo.setModId(getLoginUserId());
		if (null == datasource_vo.getModId() || "".equals(datasource_vo.getModId())) {
			result.put("stateCode", 2);
			result.put("state", "데이터소스정보 수정 실패");
			result.put("msg", "수정자 ID 확인 실패");
			return ResponseEntity.badRequest().body(result.toString());
		}
		try {
			mapper.editDS(datasource_vo);
			result.put("stateCode", 0);
			result.put("state", "데이터소스정보 수정 완료");
			loadDataSource(datasource_vo);
			return ResponseEntity.ok(result.toString());
		} catch (Exception e) {
			result.put("state", "데이터소스정보 수정 실패");
			result.put("stateCode", 3);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> delete(String ds_nm) {
		JSONObject result = new JSONObject();
		try {
			mapper.deleteDS(ds_nm);
			log.info("Remove DataSource - '" + ds_nm + "'");
			kdiRoutingDataSource.remove(ds_nm);
			result.put("stateCode", 0);
			result.put("state", "데이터소스정보 삭제 완료!!");
			return ResponseEntity.ok(result.toString());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("stateCode", 3);
			result.put("state", "데이터소스정보 삭제 실패!!");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	/**
	 * KdiRoutingDataSource에 DataSource를 불러오는 기능
	 */
	private void loadDataSource(DatasourceVo vo) {
		kdiRoutingDataSource.put(vo);
		log.info("Load DataSource - '" + vo.getDsNm() + "'");
	}

}
