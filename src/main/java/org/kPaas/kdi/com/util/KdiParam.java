package org.kPaas.kdi.com.util;

import java.util.Map;

import org.kPaas.kdi.com.util.pagination.PageParam;

public class KdiParam extends PageParam {
	private static final long serialVersionUID = 7510320053790479642L;
	private Map<String, Object> value;

	public Map<String, Object> getValue() {
		return value;
	}

	public void setValue(Map<String, Object> value) {
		this.value = value;
	}

	public Object getValue(String key) {
		return value.get(key);
	}

	public <T> T getValue(String key, Class<T> clazz) {
		return clazz.cast(value.get(key));
	}

	@SuppressWarnings("unchecked")
	public <T> T getValue(String key, T defaultValue) {
		return (T) value.getOrDefault(key, defaultValue);
	}
}