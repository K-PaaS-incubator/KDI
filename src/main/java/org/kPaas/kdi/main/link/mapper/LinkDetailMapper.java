package org.kPaas.kdi.main.link.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;

@Mapper
public interface LinkDetailMapper {

	// 연계서비스항목 테이블 생성
	public void createTable();

	public LinkServiceVo getLinkService(String svc_nm);

	public DatasourceVo connectLinkDs(String svc_nm);

	public List<String> getSchema();

	/** 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 건수 출력 */
	public Long getLinkTableListCnt(KdiParam kdiParam);

	/** 연계서비스 항목 설정 - 스키마 선택시 테이블 리스트 출력 */
	public List<Map<String, String>> getLinkTableList(KdiParam kdiParam);

	public void insertDetail(Map<String, Object> params);
	
	public Integer getSvnlnkidCnt(Map<String, Object> params);
}
