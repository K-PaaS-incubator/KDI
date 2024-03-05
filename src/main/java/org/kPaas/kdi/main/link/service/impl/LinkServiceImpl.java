package org.kPaas.kdi.main.link.service.impl;


import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.kPaas.kdi.main.link.mapper.LinkMapper;
import org.kPaas.kdi.main.link.service.LinkService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class LinkServiceImpl implements LinkService {

	@Resource
	private LinkMapper mapper;

	@Resource
	private DBCheckService dbCheckService;

	/**
	 * 최초 기동시에 연계서비스 테이블(KDI_LINK_SERVICE)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 연계서비스 테이블을 생성하는 기능
	 */
	@PostConstruct
	private void init() {
		if (!dbCheckService.isExists("KDI_LINK_SERVICE")) {
			mapper.createTable();
		}
	}
	
	public List<String> selectDsList() {
		return mapper.selectDsList();
	}


}
