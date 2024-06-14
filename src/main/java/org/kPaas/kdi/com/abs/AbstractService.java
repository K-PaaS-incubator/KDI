package org.kPaas.kdi.com.abs;

import org.kPaas.kdi.com.config.KdiContextHolder;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;

public abstract class AbstractService extends AbsCom {
	@Autowired
	private DBCheckService dbCheckService;
	
	public String getContext() {
		return KdiContextHolder.get();
	}
	public void setContext(String dataSourceName) {
		KdiContextHolder.set(dataSourceName);
	}
	public String getLoginUserId() {
		return SecurityContextHolder.getContext().getAuthentication().getName();
	}
	public boolean isTableExists(String tableName) {
		return dbCheckService.isExists(tableName);
	}
}