package org.kPaas.kdi.main.link.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkServiceVo {

	//KDI_LINK_SERVICE 연계서비스
	private Integer num;
	private String svc_id;
	private String ds_nm;
	private String svc_nm;
	private char svc_type;	
	private String reg_id;
	private String reg_dt;	
	private String mod_id;
	private String mod_dt;
	private int pageNum;
	private int amount;
	
}
