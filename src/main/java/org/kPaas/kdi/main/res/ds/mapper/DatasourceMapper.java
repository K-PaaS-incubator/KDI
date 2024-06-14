package org.kPaas.kdi.main.res.ds.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;

@Mapper
public interface DatasourceMapper {
	// 기동단계에서 사용
	public List<DatasourceVo> getDsListAll();

	public Long getDsListCnt(KdiParam kdiParam);

	public List<Map<String, String>> getDsList(KdiParam kdiParam);

	// 데이터소스 정보 저장
	public void insertDS(DatasourceVo datasource_vo);

	// 데이터소스 테이블 생성
	public void createTable();

	public DatasourceVo selectDsInfo(String ds_nm);

	public void editDS(DatasourceVo datasource_vo);

	public Integer getSameDsCheck(String ds_nm);

	public void deleteDS(String ds_nm);

	public String validationQuery(@Param("dsType") String ds_type);

}
