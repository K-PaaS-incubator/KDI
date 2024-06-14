package org.kPaas.kdi.main.link.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkTableVo {

	//KDI_LINK_TABLE 연계테이블상세
	private String col_nm;
	private String svc_lnk_id;
	private String svc_id;
	private String ds_nm;
	
	private String col_type;
	private String col_mp_nm;
	private char use_yn;	// 연계여부 Y,N
	private String reg_id;
	private String reg_dt;	
	private String mod_id;
	private String mod_dt;
	
}
