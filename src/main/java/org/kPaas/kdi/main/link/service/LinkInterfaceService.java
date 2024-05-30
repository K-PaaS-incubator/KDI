package org.kPaas.kdi.main.link.service;

import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface LinkInterfaceService {

	/**
	 * 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력
	 */
	public ResponseEntity<String> getList(KdiParam kdiParam);

	public ResponseEntity<String> insertPubInterface(Map<String, Object> params);

	public ResponseEntity<String> updatePubInterface(Map<String, Object> params);
	
	public ResponseEntity<String> insertSubInterface(Map<String, Object> params);

	public ResponseEntity<String> updateSubInterface(Map<String, Object> params);

	public ResponseEntity<String> selectPubInterface(Map<String, Object> params);
	
	public ResponseEntity<String> selectSubInterface(Map<String, Object> params);

	public ResponseEntity<String> delInterface(Map<String, Object> params);
}
