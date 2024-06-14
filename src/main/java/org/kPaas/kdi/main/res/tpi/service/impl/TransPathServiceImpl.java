package org.kPaas.kdi.main.res.tpi.service.impl;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.res.in.mapper.InterfaceNameMapper;
import org.kPaas.kdi.main.res.tpi.service.TransPathService;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class TransPathServiceImpl extends AbstractService implements TransPathService {

	@Resource
	private InterfaceNameMapper mapper;

	/**
	 * 최초 기동시에 데이터소스테이블(KDI_DATASOURCE)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 데이터소스테이블을 생성하는 기능
	 */
	@PostConstruct
	private void init() {
		if (!isTableExists("KDI_INTERFACE_NM")) {
			mapper.createTable();
		}
	}

	@Override
	public ResponseEntity<String> get(String ifId) {
		JSONObject result = new JSONObject();
		try {
			result.put("state", "인터페이스명 조회 성공");
			result.put("stateCode", 0);
			result.put("data", mapper.get(ifId));
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "중복검사 요청 실패");
			result.put("stateCode", 3);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> getList(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);

		try {
			pageInfo.setTotal(mapper.getListCnt(kdiParam));
			result.put("data", mapper.getList(kdiParam));
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

	public ResponseEntity<String> insert(String ifId, String ifNm) {
		JSONObject result = new JSONObject();
		if (null == ifId || 0 == ifId.length()) {
			result.put("stateCode", 1);
			result.put("state", "'인터페이스ID'가 누락되었습니다.");
			return ResponseEntity.badRequest().body(result.toString());
		}
		if (null == ifNm || 0 == ifNm.length()) {
			result.put("stateCode", 1);
			result.put("state", "'인터페이스명'이 누락되었습니다.");
			return ResponseEntity.badRequest().body(result.toString());
		}
		if (100 < ifId.getBytes().length) {
			result.put("stateCode", 1);
			result.put("state", "'인터페이스ID'는 100Byte를 초과할 수 없습니다.");
			return ResponseEntity.badRequest().body(result.toString());
		}
		if (100 < ifNm.getBytes().length) {
			result.put("stateCode", 1);
			result.put("state", "'인터페이스명'는 100Byte를 초과할 수 없습니다.");
			return ResponseEntity.badRequest().body(result.toString());
		}
		try {
			mapper.insert(ifId, ifNm, getLoginUserId());
			result.put("stateCode", 0);
			result.put("state", "인터페이스명 입력 완료");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "인터페이스명 입력 실패");
			result.put("stateCode", 3);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> duplicateCheck(String ifId) {
		JSONObject result = new JSONObject();
		try {
			result.put("stateCode", 0);
			result.put("state", "중복검사 요청 성공");
			result.put("data", 0 == mapper.duplicateCheck(ifId));
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "중복검사 요청 실패");
			result.put("stateCode", 3);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> modify(String ifId, String orgIfId, String ifNm) {
		JSONObject result = new JSONObject();
		try {
			mapper.modify(ifId, orgIfId, ifNm, getLoginUserId());
			result.put("stateCode", 0);
			result.put("state", "인터페이스명 수정 완료");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "인터페이스명 수정 실패");
			result.put("stateCode", 3);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> delete(String ifId) {
		JSONObject result = new JSONObject();
		try {
			mapper.delete(ifId);
			log.info("Remove InterfaceName - IF_ID='" + ifId + "'");
			result.put("stateCode", 0);
			result.put("state", "인터페이스명 삭제 완료!!");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			e.printStackTrace();
			result.put("stateCode", 3);
			result.put("state", "인터페이스명 삭제 실패!!");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

}
