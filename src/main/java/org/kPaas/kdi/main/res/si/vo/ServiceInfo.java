package org.kPaas.kdi.main.res.si.vo;

import java.io.Serializable;

public class ServiceInfo implements Serializable {
	private static final long serialVersionUID = -7254267631164133972L;

	private String svcId; // 서비스ID
	private String svcNm; // 서비스명
	private int svcType; // 서비스타입
	private String svcTypeNm; // 서비스타입명
	private String dsId; // 데이터소스ID
	private String dsNm; // 데이터소스명
	private String tpiId; // 전송경로ID
	private String tpiNm; // 전송경로명
	private String defaultSch; // 기본 스케쥴

	public String getSvcId() {
		return svcId;
	}

	public void setSvcId(String svcId) {
		this.svcId = svcId;
	}

	public String getSvcNm() {
		return svcNm;
	}

	public void setSvcNm(String svcNm) {
		this.svcNm = svcNm;
	}

	public int getSvcType() {
		return svcType;
	}

	public void setSvcType(int svcType) {
		this.svcType = svcType;
		this.svcNm = switch (this.svcType) {
		case 0: {
			yield "송신";
		}
		case 1: {
			yield "수신";
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + this.svcType);
		};
	}

	public String getSvcTypeNm() {
		return svcTypeNm;
	}

	public String getDsId() {
		return dsId;
	}

	public void setDsId(String dsId) {
		this.dsId = dsId;
	}

	public String getDsNm() {
		return dsNm;
	}

	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}

	public String getTpiId() {
		return tpiId;
	}

	public void setTpiId(String tpiId) {
		this.tpiId = tpiId;
	}

	public String getTpiNm() {
		return tpiNm;
	}

	public void setTpiNm(String tpiNm) {
		this.tpiNm = tpiNm;
	}

	public String getDefaultSch() {
		return defaultSch;
	}

	public void setDefaultSch(String defaultSch) {
		this.defaultSch = defaultSch;
	}

}
