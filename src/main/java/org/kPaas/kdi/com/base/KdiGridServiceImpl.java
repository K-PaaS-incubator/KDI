package org.kPaas.kdi.com.base;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.http.ResponseEntity;

public abstract class KdiGridServiceImpl extends AbstractService implements KdiGridService {
	protected abstract KdiGridMapper getMapper();

	protected abstract String getTableName();

	protected abstract String getBizName();

	protected Map<String, String> emptyValueCheck = new HashMap<String, String>();
	private Map<String, Integer> stringByteLengthCheckMap = new HashMap<String, Integer>();

	private String getEmptyValueCheckName(String target) {
		return emptyValueCheck.get(target);
	}

	public void putEmptyValueCheck(String target, String targetNm) {
		emptyValueCheck.put(target, targetNm);
	}

	public void putStringByteLengthCheck(String target, String targetNm, int byteLength) {
		putEmptyValueCheck(target, targetNm);
		stringByteLengthCheckMap.put(target, byteLength);
	}

	/**
	 * 최초 기동시에 테이블의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 생성하는 기능
	 */
	@PostConstruct
	private void init() {
		if (!isTableExists(getTableName())) {
			getMapper().createTable();
		}
	}

	@Override
	public ResponseEntity<String> get(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		try {
			result.put("state", getBizName() + " 데이터 조회 성공");
			result.put("stateCode", 0);
			result.put("data", getMapper().get(kdiParam));
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", getBizName() + " 데이터 조회 실패");
			result.put("stateCode", 1);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> getList(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);

		try {
			pageInfo.setTotal(getMapper().getListCnt(kdiParam));
			result.put("data", getMapper().getList(kdiParam));
			result.put("stateCode", 0);
			result.put("state", getBizName() + " 리스트 조회 성공");
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 1);
			result.put("state", getBizName() + " 리스트 조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} finally {
			result.put("page", new JSONObject(pageInfo));
		}
		return ResponseEntity.ok(result.toString());
	}

	public ResponseEntity<String> insert(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		for (String target : emptyValueCheck.keySet()) {
			if (isEmptyString(kdiParam, target)) {
				result.put("stateCode", 2);
				result.put("state", "'" + getEmptyValueCheckName(target) + "'가(이) 누락되었습니다.");
				return ResponseEntity.badRequest().body(result.toString());
			}
		}
		for (String target : stringByteLengthCheckMap.keySet()) {
			if (stringByteLengthCheckMap.get(target) < kdiParam.getValue(target, String.class).getBytes().length) {
				result.put("stateCode", 3);
				result.put("state", "'" + emptyValueCheck.get(target) + "'는(은) " + stringByteLengthCheckMap.get(target)
						+ "Byte를 초과할 수 없습니다.");
				return ResponseEntity.badRequest().body(result.toString());
			}
		}
		try {
			kdiParam.putValue("regId", getLoginUserId());
			getMapper().insert(kdiParam);
			result.put("stateCode", 0);
			result.put("state", "인터페이스명 입력 완료");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "인터페이스명 입력 실패");
			result.put("stateCode", 1);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> duplicateCheck(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		try {
			result.put("stateCode", 0);
			result.put("state", "중복검사 요청 성공");
			result.put("data", 0 == getMapper().duplicateCheck(kdiParam));
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "중복검사 요청 실패");
			result.put("stateCode", 1);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> modify(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		for (String target : emptyValueCheck.keySet()) {
			if (isEmptyString(kdiParam, target)) {
				result.put("stateCode", 2);
				result.put("state", "'" + getEmptyValueCheckName(target) + "'가(이) 누락되었습니다.");
				return ResponseEntity.badRequest().body(result.toString());
			}
		}
		for (String target : stringByteLengthCheckMap.keySet()) {
			if (stringByteLengthCheckMap.get(target) < kdiParam.getValue(target, String.class).getBytes().length) {
				result.put("stateCode", 3);
				result.put("state", "'" + emptyValueCheck.get(target) + "'는(은) " + stringByteLengthCheckMap.get(target)
						+ "Byte를 초과할 수 없습니다.");
				return ResponseEntity.badRequest().body(result.toString());
			}
		}
		try {
			kdiParam.putValue("modifyId", getLoginUserId());
			getMapper().modify(kdiParam);
			result.put("stateCode", 0);
			result.put("state", "인터페이스명 수정 완료");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", "인터페이스명 수정 실패");
			result.put("stateCode", 1);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> delete(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		try {
			getMapper().delete(kdiParam);
			log.info("인터페이스 정보 삭제 - 인터페이스ID='" + kdiParam.getValue("ifId") + "'");
			result.put("stateCode", 0);
			result.put("state", "인터페이스명 삭제 완료!!");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			e.printStackTrace();
			result.put("stateCode", 1);
			result.put("state", "인터페이스명 삭제 실패!!");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

}