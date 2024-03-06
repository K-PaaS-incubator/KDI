package org.kPaas.kdi.main.link.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkDetailVo {
	
	LinkServiceVo linkServiceVo; //연계서비스
	LinkTableVo linkTableVo; //연계테이블상세

	//KDI_LINK_DETAIL 연계서비스 항목
	int svc_lnk_id;
	String svc_id;
	String if_nm;
	String sch_nm;
	String tbl_nm;
	String lnk_time;
	char flag_type; //1:status, 2:query, 3:where	
	String reg_id;
	String reg_dt;	
	String mod_id;
	String mod_dt;
	
}
