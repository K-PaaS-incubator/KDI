package org.kPaas.kdi.com.abs;

import org.kPaas.kdi.com.config.KdiContextHolder;
import org.springframework.security.core.context.SecurityContextHolder;

public abstract class AbstractService extends AbsCom {
	public String getContext() {
		return KdiContextHolder.get();
	}
	public void setContext(String dataSourceName) {
		KdiContextHolder.set(dataSourceName);
	}
	public String getLoginUserId() {
		return SecurityContextHolder.getContext().getAuthentication().getName();
	}
}