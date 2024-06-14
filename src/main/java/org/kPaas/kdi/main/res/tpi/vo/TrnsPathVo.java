package org.kPaas.kdi.main.res.tpi.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TrnsPathVo {

	private int trns_path_id; //전송경로ID
	private String trns_path_nm; //전송경로명
	private int trns_path_type; //전송경로타입 1:FILE, 2:JMS. 3:MQTT
	private String trns_path; //전송경로
	private String reg_id;
	private String reg_dt;	
	private String mod_id;
	private String mod_dt;
	
}
