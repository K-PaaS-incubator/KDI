package org.kPaas.kdi.com.abs;

import java.util.HashMap;
import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;

public abstract class AbstractController extends AbsCom {
	public final static String DEFAULT_LAYOUT = "defaultLayout";
	public final static String SUB_BANNER_LAYOUT = "subBannerLayout";

	public final String layoutName;
	public final String jspDirPath;

	/**
	 * 기본 레이아웃을 사용하며 별도 jsp폴더 없음
	 */
	public AbstractController() {
		this.layoutName = "defaultLayout";
		this.jspDirPath = null;
	}

	/**
	 * 기본 레이아웃을 사용하며 jsp폴더 지정
	 */
	public AbstractController(final String jspDirPath) {
		this.layoutName = "defaultLayout";
		this.jspDirPath = jspDirPath;
	}

	/**
	 * 입력한 레이아웃을 사용하며 jsp폴더 지정하며 jspDirPath를 null 또는 공백을 입력한 경우 별도 jsp폴더가 없는것으로 인식함
	 */
	public AbstractController(final String layoutName, final String jspDirPath) {
		this.layoutName = layoutName;
		this.jspDirPath = jspDirPath;
	}

	/**
	 * @return 레이아웃 사용
	 */
	public final String layout(final String pageName) {
		if (null == this.jspDirPath || "".equals(this.jspDirPath)) {
			return this.layoutName + "/" + pageName;
		}
		return this.layoutName + "/" + this.jspDirPath + "/" + pageName;
	}

	/**
	 * @return 특정 페이지만 다른 레이아웃을 사용
	 */
	public final String layout(final String layoutName, final String pageName) {
		if (null == this.jspDirPath || "".equals(this.jspDirPath)) {
			return layoutName + "/" + pageName;
		}
		return layoutName + "/" + this.jspDirPath + "/" + pageName;
	}

	/**
	 * @return 특정 페이지만 다른 폴더에 다른 레이아웃을 사용
	 */
	public final String layout(final String layoutName, final String jspDirPath, final String pageName) {
		if (null == this.jspDirPath || "".equals(this.jspDirPath)) {
			return layoutName + "/" + pageName;
		}
		return layoutName + "/" + jspDirPath + "/" + pageName;
	}

	/**
	 * @return 레이아웃 사용안함
	 */
	public final String nolayout(final String pageName) {
		if (null == this.jspDirPath || "".equals(this.jspDirPath)) {
			return "nolayout/" + pageName;
		}
		return "nolayout/" + this.jspDirPath + "/" + pageName;
	}

	/**
	 * @return 특정 페이지만 다른 폴더를 사용하며 레이아웃을 사용하지 않는 경우
	 */
	public final String nolayout(final String jspDirPath, final String pageName) {
		if (null == jspDirPath || "".equals(jspDirPath)) {
			return "nolayout/" + pageName;
		}
		return "nolayout/" + jspDirPath + "/" + pageName;
	}

	public final KdiParam mapToKdiParam(Map<String, Object> params) {
		KdiParam kdiParam = new KdiParam();
		if (params.containsKey("pageNum")) {
			if (null != params.get("pageNum")) {
				kdiParam.setPageNum(Long.parseLong(String.valueOf(params.get("pageNum"))));
			}
			params.remove("pageNum");
		}
		if (params.containsKey("pagePerRow")) {
			if (null != params.get("pagePerRow")) {
				kdiParam.setPagePerRow(Integer.parseInt(String.valueOf(params.get("pagePerRow"))));
			}
			params.remove("pagePerRow");
		}
		kdiParam.setValue(params);
		Map<String, Map<String, Object>> childParamMap = null;
		String childKey;
		String childValueName;
		for (String key : params.keySet()) {
			if (!key.startsWith("#CHILD_DATA_LIST#")) {
				continue;
			}
			if (null == childParamMap) {
				childParamMap = new HashMap<String, Map<String, Object>>();
			}
			childKey = key.substring(key.indexOf("[") + 1, key.indexOf("]"));
			if (!childParamMap.containsKey(childKey)) {
				childParamMap.put(childKey, new HashMap<String, Object>());
			}
			childValueName = key.substring(key.lastIndexOf("[") + 1, key.length() - 1);
			childParamMap.get(childKey).put(childValueName, params.get(key));
		}
		if (null != childParamMap) {
			for (String key : childParamMap.keySet()) {
				kdiParam.addChildValues(childParamMap.get(key));
			}
		}
		return kdiParam;
	}
}