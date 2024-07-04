package org.kPaas.kdi.main.res.link.pub.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.base.KdiGridMapper;

public interface LinkPubInfoMapper extends KdiGridMapper {

	void insertChild(@Param("param") Map<String, Object> childParam);

}
