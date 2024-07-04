package org.kPaas.kdi.main.res.link.sub.service.impl;

import org.json.JSONObject;
import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.res.link.sub.mapper.LinkSubTblInfoMapper;
import org.kPaas.kdi.main.res.link.sub.service.LinkSubTblInfoService;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service("LinkSubTblInfoService")
@DependsOn("SubLinkDetailInfoService")
public class LinkSubTblInfoServiceImpl extends KdiGridServiceImpl implements LinkSubTblInfoService {

	@Autowired
	private LinkSubTblInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_SUB_TBL_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 수신업무 테이블 정보";
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
			//pageInfo.setTotal(mapper.getTablesCnt(kdiParam));
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
