package org.kPaas.kdi.main.link.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LinkServiceVo {
	
	LinkDetailVo linkDetailVo; //연계서비스항목
	LinkTableVo linkTableVo; //연계테이블상세

	//KDI_LINK_SERVICE 연계서비스
	Integer num;
	int svc_id;
	String ds_nm;
	String svc_nm;
	char svc_type;	
	String reg_id;
	String reg_dt;	
	String mod_id;
	String mod_dt;
	int page_num;
	int amount;
	
}
