package org.kPaas.kdi.main.res.link.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkDetailVo {

	//KDI_LINK_DETAIL 연계서비스 항목
	private Integer num;
	private String svc_lnk_id;
	private String svc_id;
	private String ds_nm;
	private String svc_lnk_nm;
	private String tbl_nm;
	private String sch_nm;
	private char flag_type; //1:status, 2:query, 3:where
	private String flag_query; //2:query, 3:where 인 경우
	private String lnk_time;
	private String reg_id;
	private String reg_dt;	
	private String mod_id;
	private String mod_dt;
	
	private String svc_nm;
}
