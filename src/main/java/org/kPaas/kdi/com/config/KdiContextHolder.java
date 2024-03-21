package org.kPaas.kdi.com.config;

/*
 * 각 쓰레드별로 어떤 DataSource를 사용할지에 대한 정보를 관리하는 기능<br>
 * KdiRoutingDataSource에서 이 코드를 통하여 디비접속정보를 결정하게됨
 */
public class KdiContextHolder {
	private static ThreadLocal<String> CONTEXT = new ThreadLocal<String>();

	/**
	 * KDI가 동작하는 기본 DB 데이터소스명<br>
	 * '데이터소스'화면에서 사용자가 해당 값은 저장하지 못 하도록 유효성 검사를 수행해야함
	 */
	public static final String DEFAULT = "KDI-LOCAL";

	/**
	 * 이 메소드를 호출하면 일치하는 데이터소스에 접속함
	 * 
	 * @param dataSourceName 사용할 데이터소스명
	 */
	public static void set(String dataSourceName) {
		if (null == dataSourceName || dataSourceName.isEmpty()) {
			throw new IllegalArgumentException("'데이터소스명' 누락");
		}
		CONTEXT.set(dataSourceName);
	}

	/**
	 * @return 현재 쓰레드의 데이터소스명
	 */
	public static String get() {
		if (null == CONTEXT.get()) {
			CONTEXT.set(DEFAULT);
		}
		return CONTEXT.get();
	}

	public static void remove() {
		CONTEXT.remove();
	}
}