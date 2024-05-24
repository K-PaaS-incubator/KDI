package org.kPaas.kdi.main.link.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.com.util.pagination.PageInfo;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.kPaas.kdi.main.link.mapper.LinkInterfaceMapper;
import org.kPaas.kdi.main.link.service.LinkInterfaceService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class LinkInterfaceServiceImpl extends AbstractService implements LinkInterfaceService {

	@Resource
	private LinkInterfaceMapper mapper;

	@Resource
	private DBCheckService dbCheckService;

	/**
	 * 최초 기동시에 연계서비스항목 테이블(KDI_LINK_DETAIL)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 연계서비스항목 테이블을 생성하는 기능
	 */
	@PostConstruct
	private void init() {
		if (!dbCheckService.isExists("KDI_LINK_DETAIL")) {
			mapper.createTable();
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
	public LinkServiceVo getLinkService(String svc_nm) {
		return mapper.getLinkService(svc_nm);
	}

	public List<String> connectLinkDs(String svc_nm) {
		DatasourceVo datasource_vo = mapper.connectLinkDs(svc_nm);
		final String orgContext = getContext();
		try {
			setContext(datasource_vo.getDs_nm());
			return mapper.getSchema();
		} catch (MyBatisSystemException e) {
			log.error("연결실패", e.getMessage());
			return null;
		} finally {
			setContext(orgContext);
		}
	}

	@Override // 연계서비스항목 데이터 최초 등록
	public ResponseEntity<String> insertDetail(Map<String, Object> params) {

		JSONObject result = new JSONObject();
		// System.out.println("#############"+params.get("svc_id"));

		try {
			int cnt = mapper.getSvnlnkidCnt(params);
			if (cnt >= 1) {
				result.put("stateCode", 2);
				result.put("state", "중복된 인터페이스ID");
				result.put("errMsg", "svc_lnk_id is duplicate");
				return ResponseEntity.badRequest().body(result.toString());
			}

			mapper.insertDetail(params);

		} catch (MyBatisSystemException e) {

			result.put("stateCode", 1);
			result.put("state", "연계항목 등록 실패");
			result.put("errMsg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}

		result.put("stateCode", 0);
		result.put("state", "연계항목 등록 성공");
		return ResponseEntity.ok(result.toString());

	}
}
