package org.kPaas.kdi.main.link.service;

import java.util.List;
import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;

public interface LinkInterfaceService {

	/**
	 * 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력
	 */
	public ResponseEntity<String> getList(KdiParam kdiParam);

	public LinkServiceVo getLinkService(String svc_nm);

	public List<String> connectLinkDs(String svc_nm);

	public ResponseEntity<String> insertDetail(Map<String, Object> params);
}
