package org.kPaas.kdi.main.datasource.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.kPaas.kdi.main.datasource.mapper.DatasourceMapper;
import org.kPaas.kdi.main.datasource.service.DatasourceService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class DatasourceServiceImpl implements DatasourceService {

	@Resource
	private DatasourceMapper mapper;

	@Resource
	private DBCheckService dbCheckService;

	/**
	 * 최초 기동시에 데이터소스테이블(KDI_DATASOURCE)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 데이터소스테이블을 생성하는 기능
	 */
	@PostConstruct
	private void init() {
		if (!dbCheckService.isExists("KDI_DATASOURCE")) {
			mapper.createTable();
		}
	}

	public ResponseEntity<String> insertDS(DatasourceVo datasource_vo) {
		JSONObject result = new JSONObject();
		if (null == datasource_vo) {
			result.put("state", "데이터소스정보 등록 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		datasource_vo.setReg_id(SecurityContextHolder.getContext().getAuthentication().getName());
		if (null == datasource_vo.getReg_id() || "".equals(datasource_vo.getReg_id())) {
			result.put("state", "데이터소스정보 등록 실패");
			result.put("msg", "등록자 ID 확인 실패");
			return ResponseEntity.badRequest().body(result.toString());
		}
		try {
			mapper.insertDS(datasource_vo);
			result.put("state", "데이터소스정보 등록 완료");
			return ResponseEntity.ok(result.toString());
		} catch (SQLException e) {
			result.put("state", "데이터소스정보 등록 실패");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}

	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		JSONObject result = new JSONObject();
		if (null == datasource_vo) {
			result.put("state", "테스트 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		String ds_url = datasource_vo.getDs_url();
		if (null != ds_url) {
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
