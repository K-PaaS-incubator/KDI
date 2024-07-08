package org.kPaas.kdi.main.res.link.pub.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.res.link.pub.mapper.LinkPubTblInfoMapper;
import org.kPaas.kdi.main.res.link.pub.service.LinkPubTblInfoService;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service("LinkPubTblInfoService")
@DependsOn("PubLinkDetailInfoService")
public class LinkPubTblInfoServiceImpl extends KdiGridServiceImpl implements LinkPubTblInfoService {

	@Autowired
	private LinkPubTblInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_PUB_TBL_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 송신업무 테이블 정보";
	}

	@Override
	protected List<Map<String, Object>> selectDataPreProc(KdiParam kdiParam, List<Map<String, Object>> datas)
			throws Exception {
		Map<String, Map<String, Object>> currentColumnMap = new LinkedHashMap<String, Map<String, Object>>();
		// 이전 DB접속정보 (H2)
		final String orgContext = getContext();
		try {
			String dsNm = kdiParam.getValue("dsNm", String.class);
			if (null == dsNm) {
				throw new NullPointerException("데이터소스 정보를 찾을 수 없습니다.");
			}
			// 사용자가 선택한 디비접속정보로 접속
			setContext(dsNm);
			for (Map<String, Object> currentColumn : mapper.getColumns(kdiParam)) {
				currentColumnMap.put((String) currentColumn.get("COLUMN_NAME"), currentColumn);
			}
		} finally {
			// 다시 이전 DB접속정보로 접속 (H2)
			setContext(orgContext);
		}
		{ // 삭제된 컬럼 식별 기능
			String columnName;
			Map<String, Object> currentColumn = null;
			for (Map<String, Object> data : datas) {
				columnName = (String) data.get("COLUMN_NAME");
				if (currentColumnMap.containsKey(columnName)) {
					currentColumn = currentColumnMap.get(columnName);
					data.put("COMMENTS", currentColumn.get("COMMENTS"));
					currentColumnMap.remove(columnName);
					continue;
				}
				currentColumn = null;
				// 임의 컬럼 여부를 저장하는 컬럼이 추가되어야함
				// 임의 컬럼이 아닌 경우 삭제된 컬럼을 출력
				data.put("COMMENTS", "<span style=\"color:red;\">[삭제된 컬럼 식별]</span>");
			}
		}
		{ // 추가된 컬럼 식별 기능
			// currentColumn을 기준으로 다시한번 반복하여 신규추가된 컬럼임을 확인하는 로직 추가
			Map<String, Object> currentColumn = null;
			for (String columnName : currentColumnMap.keySet()) {
				currentColumn = currentColumnMap.get(columnName);
				currentColumn.put("COMMENTS",
						"<span style=\"color:blue;\">[신규 추가된 컬럼 식별]</span>" + null == currentColumn.get("COMMENTS") ? ""
								: currentColumn.get("COMMENTS"));
				datas.add(currentColumn);
			}
		}
		return datas;
	}

	/** 연계서비스 항목 설정 - 스키마,테이블 선택시 컬럼 리스트 출력 */
	@Override
	public ResponseEntity<String> getColumns(KdiParam kdiParam) {
		JSONObject result = new JSONObject();
		PageInfo pageInfo = new PageInfo(kdiParam);

		// 이전 DB접속정보 (H2)
		final String orgContext = getContext();
		try {
			String dsNm = kdiParam.getValue("dsNm", String.class);
			if (null == dsNm) {
				result.put("stateCode", 2);
				result.put("state", "조회 실패");
				result.put("errMsg", "데이터소스 정보를 찾을 수 없습니다.");
				return ResponseEntity.badRequest().body(result.toString());
			}
			// 사용자가 선택한 디비접속정보로 접속
			setContext(dsNm);
			// pageInfo.setTotal(mapper.getTablesCnt(kdiParam));
			result.put("data", mapper.getColumns(kdiParam));
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
}
