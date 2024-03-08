package org.kPaas.kdi.main.link.service.impl;


import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.link.mapper.LinkMapper;
import org.kPaas.kdi.main.link.service.LinkService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
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
	
	//연계서비스 조회
	public List<LinkServiceVo> selectLinkList() {
		return mapper.selectLinkList();
	}

	
	//연계서비스 등록 시작
	
	public List<String> selectDsList() {
		return mapper.selectDsList();
	}
	

	@Override
	public Integer getSameLinkCheck(String svc_nm) {
		return mapper.getSameLinkCheck(svc_nm);
	}

	@Override
	public ResponseEntity<String> insertLink(LinkServiceVo linkService_vo) {
		JSONObject result = new JSONObject();
		if (null == linkService_vo) {
			result.put("state", "연계서비스 등록 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		linkService_vo.setReg_id(SecurityContextHolder.getContext().getAuthentication().getName());
		if (null == linkService_vo.getReg_id() || "".equals(linkService_vo.getReg_id())) {
			result.put("state", "연계서비스 등록 실패");
			result.put("msg", "등록자 ID 확인 실패");
			return ResponseEntity.badRequest().body(result.toString());
		}
		try {
			mapper.insertLink(linkService_vo);
			result.put("state", "연계서비스 등록 성공");
			return ResponseEntity.ok(result.toString());
		} catch (Exception e) {
			result.put("state", "연계서비스 등록 실패");
			result.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
	}


}