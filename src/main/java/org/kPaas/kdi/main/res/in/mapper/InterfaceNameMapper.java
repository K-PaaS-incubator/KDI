package org.kPaas.kdi.main.res.in.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.util.KdiParam;

@Mapper
public interface InterfaceNameMapper {

	// 데이터소스 테이블 생성
	public void createTable();

	Long getListCnt(KdiParam mapToKdiParam);

	List<Map<String, Object>> getList(KdiParam mapToKdiParam);

	void insert(@Param("if_id") String ifId, @Param("if_nm") String ifNm, @Param("reg_id") String regId);

	int duplicateCheck(@Param("if_id") String ifId);

	String get(@Param("if_id") String ifId);

	void modify(@Param("if_id") String ifId, @Param("org_if_id") String orgIfId, @Param("if_nm") String ifNm,
			@Param("modify_id") String modifyId);

	void delete(@Param("if_id") String ifId);

}
