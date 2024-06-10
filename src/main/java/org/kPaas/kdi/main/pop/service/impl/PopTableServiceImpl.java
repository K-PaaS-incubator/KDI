package org.kPaas.kdi.main.pop.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.config.KdiRoutingDataSource;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.pop.mapper.PopTableMapper;
import org.kPaas.kdi.main.pop.service.PopTableService;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class PopTableServiceImpl extends AbstractService implements PopTableService {
	@Resource
	private PopTableMapper mapper;

	@Autowired
	private KdiRoutingDataSource kdiRoutingDataSource;

	@Override
	public ResponseEntity<String> getSchemas(String ds_nm) {
		JSONObject result = new JSONObject();

		if (null == ds_nm || 0 == ds_nm.trim().length()) {
			result.put("errMsg", "데이터소스명 누락");
			result.put("stateCode", 1);
			result.put("state", "스키마 조회 실패");
			return ResponseEntity.badRequest().body(result.toString());
		}
		if (!kdiRoutingDataSource.contains(ds_nm)) {
			result.put("errMsg", "데이터소스를 찾을 수 없습니다.");
			result.put("stateCode", 2);
			result.put("state", "데이터소스 불러오기 실패");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(result.toString());
		}
		final String orgContext = getContext();
		try {
			setContext(ds_nm);
			result.put("data", mapper.getSchemas());
			result.put("stateCode", 0);
			result.put("state", "조회 성공");
		} catch (MyBatisSystemException e) {
			log.error("스키마 조회 실패", e.getMessage());
			result.put("errMsg", e.getMessage());
			result.put("stateCode", 3);
			result.put("state", "스키마 조회 실패");
		} finally {
			setContext(orgContext);
		}
		return ResponseEntity.ok(result.toString());
	}
	/** 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력 */
	@Override
	public ResponseEntity<String> getTables(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);

		// 이전 DB접속정보 (H2)
		final String orgContext = getContext();
		try {
			String dsNm = kdiParam.getValue("ds_nm", String.class);
			if (null == dsNm) {
				result.put("stateCode", 2);
				result.put("state", "조회 실패");
				result.put("errMsg", "ds_nm is null");
				return ResponseEntity.badRequest().body(result.toString());
			}
			// 사용자가 선택한 디비접속정보로 접속
			setContext(dsNm);
			pageInfo.setTotal(mapper.getTablesCnt(kdiParam));
			result.put("data", mapper.getTables(kdiParam));
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} finally {
			// 다시 이전 DB접속정보로 접속 (H2)
			setContext(orgContext);
			result.put("page", new JSONObject(pageInfo));
		}
		result.put("stateCode", 0);
		result.put("state", "조회 성공");
		return ResponseEntity.ok(result.toString());
	}
	@Override
	public ResponseEntity<String> editIF_SvcDs(Map<String, Object> params) {
		JSONObject result = new JSONObject();
		try {
			mapper.editIF_SvcDs(params);
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "수정 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} 
		result.put("stateCode", 0);
		result.put("state", "수정 성공");
		return ResponseEntity.ok(result.toString());
	}
}