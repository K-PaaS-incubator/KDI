package org.kPaas.kdi.com.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;

public abstract class KdiGridServiceImpl extends AbstractService implements KdiGridService {
	protected abstract KdiGridMapper getMapper();

	protected abstract String getTableName();

	protected abstract String getBizName();

	protected Map<String, Map<String, String>> emptyValueCheck = new HashMap<String, Map<String, String>>();
	private Map<String, Map<String, Integer>> stringByteLengthCheck = new HashMap<String, Map<String, Integer>>();

	private String getEmptyValueCheckName(String workNm, String target) {
		if (!emptyValueCheck.containsKey(workNm)) {
			return null;
		}
		return emptyValueCheck.get(workNm).get(target);
	}

	public void putEmptyValueCheck(String target, String targetNm) {
		putEmptyValueCheck("default", target, targetNm);
	}

	public void putEmptyValueCheck(String workNm, String target, String targetNm) {
		if (!emptyValueCheck.containsKey(workNm)) {
			emptyValueCheck.put(workNm, new HashMap<String, String>());
		}
		emptyValueCheck.get(workNm).put(target, targetNm);
	}

	public void putStringByteLengthCheck(String target, String targetNm, int byteLength) {
		putStringByteLengthCheck("default", target, targetNm, byteLength);
	}

	public void putStringByteLengthCheck(String workNm, String target, String targetNm, int byteLength) {
		putEmptyValueCheck(workNm, target, targetNm);
		if (!stringByteLengthCheck.containsKey(workNm)) {
			stringByteLengthCheck.put(workNm, new HashMap<String, Integer>());
		}
		stringByteLengthCheck.get(workNm).put(target, byteLength);
	}

	/**
	 * 최초 기동시에 테이블의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 생성하는 기능
	 */
	@PostConstruct
	protected void init() {
		if (!isTableExists(getTableName())) {
			getMapper().createTable();
		}
	}

	/**
	 * 'getList'에서 조회한 데이터를 가공할때 호출하는데 호출시점이<br>
	 * 'selectDataProc'를 반복적으로 호출하기전 단계임
	 */
	protected List<Map<String, Object>> selectDataPreProc(KdiParam kdiParam, List<Map<String, Object>> datas)
			throws Exception {
		return datas;
	}

	/**
	 * 조회한 데이터를 가공할때 호출<br>
	 * 'getList'에서는 row 단위로 호출
	 */
	protected Map<String, Object> selectDataProc(KdiParam kdiParam, Map<String, Object> data) throws Exception {
		return data;
	}

	@Override
	public ResponseEntity<String> get(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		try {
			result.put("state", getBizName() + " 데이터 조회 성공");
			result.put("stateCode", 0);
			result.put("data", getData(kdiParam));
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", getBizName() + " 데이터 조회 실패");
			result.put("stateCode", 2);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} catch (Exception e) {
			result.put("stateCode", 1);
			result.put("state", getBizName() + " 리스트 조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public Map<String, Object> getData(KdiParam kdiParam) throws Exception {
		Map<String, Object> data = getMapper().get(kdiParam);
		selectDataProc(kdiParam, data);
		return data;
	}

	@Override
	public ResponseEntity<String> getList(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);
		try {
			pageInfo.setTotal(getMapper().getListCnt(kdiParam));
			result.put("data", getListData(kdiParam));
			result.put("stateCode", 0);
			result.put("state", getBizName() + " 리스트 조회 성공");
		} catch (MyBatisSystemException e) {
			result.put("stateCode", 2);
			result.put("state", getBizName() + " 리스트 조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} catch (Exception e) {
			result.put("stateCode", 1);
			result.put("state", getBizName() + " 리스트 조회 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		} finally {
			result.put("page", new JSONObject(pageInfo));
		}
		return ResponseEntity.ok(result.toString());
	}

	@Override
	public List<Map<String, Object>> getListData(KdiParam kdiParam) throws Exception {
		List<Map<String, Object>> datas = getMapper().getList(kdiParam);
		selectDataPreProc(kdiParam, datas);
		for (Map<String, Object> data : datas) {
			selectDataProc(kdiParam, data);
		}
		return datas;
	}

	@Override
	public ResponseEntity<String> insert(KdiParam kdiParam) {
		return insert("default", getBizName(), getMapper(), kdiParam);
	}

	public ResponseEntity<String> insert(String workNm, String bizName, KdiGridMapper mapper, KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		if (emptyValueCheck.containsKey(workNm)) {
			Map<String, String> emptyValueCheckMap = emptyValueCheck.get(workNm);
			for (String target : emptyValueCheckMap.keySet()) {
				if (isEmptyString(kdiParam, target)) {
					result.put("stateCode", 2);
					result.put("state", "'" + getEmptyValueCheckName("default", target) + "'가(이) 누락되었습니다.");
					return ResponseEntity.badRequest().body(result.toString());
				}
			}
		}
		if (stringByteLengthCheck.containsKey(workNm)) {
			Map<String, Integer> stringByteLengthCheckMap = stringByteLengthCheck.get(workNm);
			for (String target : stringByteLengthCheckMap.keySet()) {
				if (stringByteLengthCheckMap.get(target) < kdiParam.getValue(target, String.class).getBytes().length) {
					result.put("stateCode", 3);
					result.put("state", "'" + getEmptyValueCheckName(workNm, target) + "'는(은) "
							+ stringByteLengthCheckMap.get(target) + "Byte를 초과할 수 없습니다.");
					return ResponseEntity.badRequest().body(result.toString());
				}
			}
		}
		try {
			kdiParam.putValue("regId", getLoginUserId());
			mapper.insert(kdiParam);
			result.put("stateCode", 0);
			result.put("state", bizName + " 입력 완료");
			return ResponseEntity.ok(result.toString());
		} catch (DuplicateKeyException e) {
			result.put("state", bizName + " 입력 실패");
			result.put("stateCode", 1);
			result.put("msg", "중복된 값이 존재합니다.");
			return ResponseEntity.badRequest().body(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", bizName + " 입력 실패");
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
			result.put("data", 0 != getMapper().duplicateCheck(kdiParam));
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
		return modify("default", getBizName(), getMapper(), kdiParam);
	}

	public ResponseEntity<String> modify(String workNm, String bizName, KdiGridMapper mapper, KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		if (emptyValueCheck.containsKey(workNm)) {
			Map<String, String> emptyValueCheckMap = emptyValueCheck.get(workNm);
			for (String target : emptyValueCheckMap.keySet()) {
				if (isEmptyString(kdiParam, target)) {
					result.put("stateCode", 2);
					result.put("state", "'" + getEmptyValueCheckName("default", target) + "'가(이) 누락되었습니다.");
					return ResponseEntity.badRequest().body(result.toString());
				}
			}
		}
		if (stringByteLengthCheck.containsKey(workNm)) {
			Map<String, Integer> stringByteLengthCheckMap = stringByteLengthCheck.get(workNm);
			for (String target : stringByteLengthCheckMap.keySet()) {
				if (stringByteLengthCheckMap.get(target) < kdiParam.getValue(target, String.class).getBytes().length) {
					result.put("stateCode", 3);
					result.put("state", "'" + getEmptyValueCheckName(workNm, target) + "'는(은) "
							+ stringByteLengthCheckMap.get(target) + "Byte를 초과할 수 없습니다.");
					return ResponseEntity.badRequest().body(result.toString());
				}
			}
		}
		try {
			kdiParam.putValue("modifyId", getLoginUserId());
			mapper.modify(kdiParam);
			result.put("stateCode", 0);
			result.put("state", bizName + " 수정 완료");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			result.put("state", bizName + " 수정 실패");
			result.put("stateCode", 1);
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	@Override
	public ResponseEntity<String> delete(KdiParam kdiParam) {
		return delete("default", getBizName(), getMapper(), kdiParam);
	}

	public ResponseEntity<String> delete(String workNm, String bizName, KdiGridMapper mapper, KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		try {
			getMapper().delete(kdiParam);
			log.info(bizName + " 삭제 완료 - " + new JSONObject(kdiParam).toString());
			result.put("stateCode", 0);
			result.put("state", bizName + " 삭제 완료");
			return ResponseEntity.ok(result.toString());
		} catch (MyBatisSystemException e) {
			e.printStackTrace();
			result.put("stateCode", 1);
			result.put("state", bizName + " 삭제 실패");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}
}