package org.kPaas.kdi.main.res.ds.vo;

import java.io.Serializable;

public class DatasourceVo implements Serializable {
	private static final long serialVersionUID = 796899295962268579L;
	private Integer num; // rownum
	private String dsNm; // 데이터소스명
	private String dsType; // DB타입
	private String dsDriver; // 드라이브
	private String dsAddr; // DB IP주소
	private String dsPort; // DB 포트
	private String dsSid; // DB database명
	private String dsUrl; // DB FULL URL주소
	private String dsUsrNm; // DB유저명
	private String dsUsrPw; // DB패스워드
	private String regId; // 등록사용자용ID
	private String regDt; // 등록일자
	private String modId; // 수정사용자ID
	private String modDt; // 수정일자
	private Integer pageNum; // 페이지 넘버
	private Integer amount; // 리스트 총 개수

	private Integer dsMinIdle; // 유휴 connection 수 (minimumIdle)
	private Integer dsMaxPool; // maximumPoolSize connection 최대 풀사이즈 (maximumPoolSize)

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getDsNm() {
		return dsNm;
	}

	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}

	public String getDsType() {
		return dsType;
	}

	public void setDsType(String dsType) {
		this.dsType = dsType;
	}

	public String getDsDriver() {
		return dsDriver;
	}

	public void setDsDriver(String dsDriver) {
		this.dsDriver = dsDriver;
	}

	public String getDsAddr() {
		return dsAddr;
	}

	public void setDsAddr(String dsAddr) {
		this.dsAddr = dsAddr;
	}

	public String getDsPort() {
		return dsPort;
	}

	public void setDsPort(String dsPort) {
		this.dsPort = dsPort;
	}

	public String getDsSid() {
		return dsSid;
	}

	public void setDsSid(String dsSid) {
		this.dsSid = dsSid;
	}

	public String getDsUrl() {
		return dsUrl;
	}

	public void setDsUrl(String dsUrl) {
		this.dsUrl = dsUrl;
	}

	public String getDsUsrNm() {
		return dsUsrNm;
	}

	public void setDsUsrNm(String dsUsrNm) {
		this.dsUsrNm = dsUsrNm;
	}

	public String getDsUsrPw() {
		return dsUsrPw;
	}

	public void setDsUsrPw(String dsUsrPw) {
		this.dsUsrPw = dsUsrPw;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getModDt() {
		return modDt;
	}

	public void setModDt(String modDt) {
		this.modDt = modDt;
	}

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getDsMinIdle() {
		return dsMinIdle;
	}

	public void setDsMinIdle(Integer dsMinIdle) {
		this.dsMinIdle = dsMinIdle;
	}

	public Integer getDsMaxPool() {
		return dsMaxPool;
	}

	public void setDsMaxPool(Integer dsMaxPool) {
		this.dsMaxPool = dsMaxPool;
	}

}
