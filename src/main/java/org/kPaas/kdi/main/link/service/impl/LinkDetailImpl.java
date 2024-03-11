package org.kPaas.kdi.main.link.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.kPaas.kdi.main.link.mapper.LinkDetailMapper;
import org.kPaas.kdi.main.link.service.LinkDetailService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class LinkDetailImpl implements LinkDetailService {

	@Resource
	private LinkDetailMapper mapper;

	@Override
	public LinkServiceVo getLinkService(String svc_nm) {
		return mapper.getLinkService(svc_nm);
	}
	
	public ResponseEntity<String> connectLinkDs(String svc_nm) {
		JSONObject result = new JSONObject();
		DatasourceVo datasource_vo = mapper.connectLinkDs(svc_nm);
		String ds_url = datasource_vo.getDs_url();
		if (null == ds_url) {
			result.put("state", "테스트 실패");
			result.put("msg", "DB URL정보가 누락되었습니다.");
			return ResponseEntity.badRequest().body(result.toString());
		}
		String ds_usr_nm = datasource_vo.getDs_usr_nm();
		String ds_usr_pw = datasource_vo.getDs_usr_pw();
		try (Connection conn = DriverManager.getConnection(ds_url, ds_usr_nm, ds_usr_pw)) {
			result.put("state", "테스트 성공");
			return ResponseEntity.ok(result.toString());
		} catch (SQLException e) {
			result.put("state", "테스트 실패");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}
	
	
}
