package org.kPaas.kdi.main.link.service.impl;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.link.mapper.LinkInterfaceMapper;
import org.kPaas.kdi.main.link.service.LinkInterfaceService;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.context.annotation.DependsOn;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service("LinkInterfaceService")
@DependsOn("DatasourceService")
public class LinkInterfaceServiceImpl extends AbstractService implements LinkInterfaceService {

	@Resource
	private LinkInterfaceMapper mapper;

	@PostConstruct
	public void init() {
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
		}
	}

	/** 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력 */
	@Override
	public ResponseEntity<String> getList(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);

		try {
			if (null == kdiParam.getValue("svc_nm", String.class)) {
				result.put("stateCode", 2);
				result.put("state", "조회실패 - 파라미터 누락");
				result.put("errMsg", "svc_nm is null");
				return ResponseEntity.badRequest().body(result.toString());
			}
			// 사용자가 선택한 디비접속정보로 접속
			pageInfo.setTotal(mapper.getInterfaceListCnt(kdiParam));
			result.put("data", mapper.getInterfaceList(kdiParam));
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

	@Override
	public ResponseEntity<String> insertPubInterface(Map<String, Object> params) {
		JSONObject result = new JSONObject();
		try {
			params.put("reg_id", getLoginUserId());
			mapper.insertPubInterface(params);
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "저장 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
		result.put("stateCode", 0);
		result.put("state", "저장 성공");
		return ResponseEntity.ok(result.toString());
	}

	@Override
	public ResponseEntity<String> updatePubInterface(Map<String, Object> params) {
		JSONObject result = new JSONObject();
		try {
			params.put("mod_id", getLoginUserId());
			mapper.updatePubInterface(params);
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "저장 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
		result.put("stateCode", 0);
		result.put("state", "저장 성공");
		return ResponseEntity.ok(result.toString());
	}

	@Override
	public ResponseEntity<String> selectPubInterface(Map<String, Object> params) {
		JSONObject result = new JSONObject();
		try {
			result.put("data", mapper.selectPubInterface(params));
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
		result.put("stateCode", 0);
		result.put("state", "조회 성공");
		return ResponseEntity.ok(result.toString());
	}

	@Override
	public ResponseEntity<String> insertSubInterface(Map<String, Object> params) {
		return null;

	}

	@Override
	public ResponseEntity<String> updateSubInterface(Map<String, Object> params) {
		return null;
	}

	@Override
	public ResponseEntity<String> selectSubInterface(Map<String, Object> params) {
		return null;
	}

	@Override
	public ResponseEntity<String> delInterface(Map<String, Object> params) {
		JSONObject result = new JSONObject();
		try {
			mapper.deleteInterface(params);
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", "연계인터페이스 삭제 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
		result.put("stateCode", 0);
		result.put("state", "연계인터페이스 삭제 성공");
		return ResponseEntity.ok(result.toString());
	}
}
