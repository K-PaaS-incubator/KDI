package org.kPaas.kdi.main.link.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkVo {

	//KDI_LINK_SERVICE 연계서비스
	int svc_id;
	String ds_nm;
	String svc_nm;
	char svc_type;	
	String reg_id;
	String reg_dt;	
	String mod_id;
	String mod_dt;
	
	//KDI_LINK_DETAIL 연계서비스 항목
	
	
	
}
