package org.kPaas.kdi.main.link.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkTableVo {
	
	LinkServiceVo linkServiceVo; //연계서비스
	LinkDetailVo linkDetailVo; //연계서비스항목

	//KDI_LINK_TABLE 연계테이블상세
	String col_nm;
	int svc_lnk_id;
	String col_type;
	String col_mp_nm;
	char use_yn;	// 연계여부 Y,N
	String reg_id;
	String reg_dt;	
	String mod_id;
	String mod_dt;
	
}
