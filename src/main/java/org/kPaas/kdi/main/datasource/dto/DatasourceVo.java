package org.kPaas.kdi.main.datasource.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DatasourceVo {
	
	public int no; //rownum
	public String ds_nm; //데이터소스명
	public String ds_type; //DB타입
	public String ds_driver; //드라이브
	public String ds_addr; //DB IP주소
	public String ds_port; //DB 포트
	public String ds_sid; //DB database명
	public String ds_url; //DB FULL URL주소
	public String ds_usr_nm; //DB유저명
	public String ds_usr_pw; //DB패스워드
	public String reg_id; //등록사용자용ID
	public String reg_dt; //등록일자
	public String mod_id; //수정사용자ID
	public String mod_dt; //수정일자
	
}
