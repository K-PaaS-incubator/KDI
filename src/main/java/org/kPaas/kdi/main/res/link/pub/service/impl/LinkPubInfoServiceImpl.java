package org.kPaas.kdi.main.res.link.pub.service.impl;

import java.util.Map;

import org.json.JSONObject;
import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.res.link.pub.mapper.LinkPubInfoMapper;
import org.kPaas.kdi.main.res.link.pub.service.LinkPubInfoService;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@DependsOn("LinkSvcInfoService")
@Service("PubLinkDetailInfoService")
public class LinkPubInfoServiceImpl extends KdiGridServiceImpl implements LinkPubInfoService {

	@Autowired
	private LinkPubInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_PUB_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 송신업무 정보";
	}

	@Override
	public ResponseEntity<String> insert(KdiParam kdiParam) {
		ResponseEntity<String> result = super.insert(kdiParam);
		if (null == result || HttpStatus.OK != result.getStatusCode() || null == kdiParam.getChildValues()) {
			return result;
		}
		if (0 == kdiParam.getChildValues().size()) {
			return result;
		}
		try {
			for (Map<String, Object> childParam : kdiParam.getChildValues()) {
				childParam.put("svcLnkId", kdiParam.getValue("svcLnkId"));
				childParam.put("regId", getLoginUserId());
				System.out.println(childParam.get("colName"));
				mapper.insertChild(childParam);
			}
		} catch (DuplicateKeyException e) {
			JSONObject jsonResult = new JSONObject();
			jsonResult.put("state", getBizName() + " 컬럼정보 입력 실패");
			jsonResult.put("stateCode", 1);
			jsonResult.put("msg", "중복된 값이 존재합니다.");
			return ResponseEntity.badRequest().body(result.toString());
		} catch (MyBatisSystemException e) {
			JSONObject jsonResult = new JSONObject();
			jsonResult.put("state", getBizName() + " 컬럼정보 입력 실패");
			jsonResult.put("stateCode", 1);
			jsonResult.put("msg", e.getMessage());
			return ResponseEntity.badRequest().body(result.toString());
		}
		return result;
	}
}