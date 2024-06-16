package org.kPaas.kdi.main.res.tpi.mapper;

<<<<<<< HEAD
import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.com.base.KdiGridMapper;

@Mapper
public interface TransPathMapper extends KdiGridMapper {
=======
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.util.KdiParam;

@Mapper
public interface TransPathMapper {

	// 데이터소스 테이블 생성
	public void createTable();

	Long getListCnt(KdiParam mapToKdiParam);

	List<Map<String, Object>> getList(KdiParam mapToKdiParam);

	void insert(@Param("trns_path_id") String trnsPathId, @Param("trns_path_nm") String trnsPathNm, @Param("reg_id") String regId);

	int duplicateCheck(@Param("trns_path_id") String trnsPathId);

	String get(@Param("trns_path_id") String trnsPathId);

	void modify(@Param("trns_path_id") String trnsPathId, @Param("org_trns_path_id") String orgTrnsPathId, @Param("trns_path_nm") String trnsPathNm,
			@Param("modify_id") String modifyId);

	void delete(@Param("trns_path_id") String trnsPathId);

>>>>>>> branch '전수정' of http://git.biz.ppsystem.co.kr/cloud/kdi.git
}
