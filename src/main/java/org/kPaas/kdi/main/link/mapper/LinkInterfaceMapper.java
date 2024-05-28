package org.kPaas.kdi.main.link.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.com.util.KdiParam;

@Mapper
public interface LinkInterfaceMapper {

	// 연계서비스항목 테이블 생성
	public void createTable();

	/** 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 건수 출력 */
	public Long getInterfaceListCnt(KdiParam kdiParam);

	/** 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력 */
	public List<Map<String, String>> getInterfaceList(KdiParam kdiParam);

	public void insertPubInterface(Map<String, Object> params);

	public void updatePubInterface(Map<String, Object> params);

	public Map<String, String> selectPubInterface(Map<String, Object> params);
}
