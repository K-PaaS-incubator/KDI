package org.kPaas.kdi.main.datasource.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.util.criteria.Criteria;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;

@Mapper
public interface DatasourceMapper {

	// 데이터소스 정보 저장
	public void insertDS(DatasourceVo datasource_vo);

	// 데이터소스 테이블 생성
	public void createTable();

	public List<DatasourceVo> selectDsList();
	public List<DatasourceVo> selectDsListPage(DatasourceVo datasource_vo);
	public int selectDsListCount(DatasourceVo datasource_vo);

	public DatasourceVo selectDsInfo(String ds_nm);

	public void editDS(DatasourceVo datasource_vo);

	public Integer getSameDsCheck(String ds_nm);

	public void deleteDS(String ds_nm);

	public String validationQuery(@Param("ds_type") String ds_type);

}
