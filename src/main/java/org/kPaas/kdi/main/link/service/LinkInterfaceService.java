package org.kPaas.kdi.main.link.service;

import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface LinkInterfaceService {

	/**
	 * 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력
	 */
	public ResponseEntity<String> getList(KdiParam kdiParam);

	public ResponseEntity<String> insert(Map<String, Object> params);
}
