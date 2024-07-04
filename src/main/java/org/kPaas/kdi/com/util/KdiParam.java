package org.kPaas.kdi.com.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.kPaas.kdi.com.util.pagination.PageParam;

public class KdiParam extends PageParam {
	private static final long serialVersionUID = 7510320053790479642L;
	private Map<String, Object> value;
	private List<Map<String, Object>> childValues = null;

	public Map<String, Object> String() {
		return value;
	}

	public void setValue(Map<String, Object> value) {
		this.value = value;
	}

	public boolean getValueContainsKey(String key) {
		return value.containsKey(key);
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

	public void putValue(String key, Object value) {
		this.value.put(key, value);
	}

	public List<Map<String, Object>> getChildValues() {
		return childValues;
	}

	public void setChildValues(List<Map<String, Object>> childValue) {
		this.childValues = childValue;
	}

	public void addChildValues(Map<String, Object> childValue) {
		if (null == this.childValues) {
			this.childValues = new ArrayList<Map<String,Object>>();
		}
		this.childValues.add(childValue);
	}
}