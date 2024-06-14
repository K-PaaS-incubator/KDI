package org.kPaas.kdi.com.abs;

import org.kPaas.kdi.com.config.KdiContextHolder;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.com.util.KdiParam;
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

	public static boolean isEmptyString(KdiParam kdiParam, String valueKey) {
		return !kdiParam.getValueContainsKey(valueKey) || null == kdiParam.getValue(valueKey)
				|| 0 == kdiParam.getValue(valueKey, String.class).length();
	}
}