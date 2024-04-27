package org.kPaas.kdi.com.util.pagination;

import java.io.Serializable;

/**
 * 페이지 정보
 */
public class PageParam implements Serializable {
	private static final long serialVersionUID = 1357186843087083841L;

	/**
	 * 페이지번호
	 */
	private Long pageNum;

	/**
	 * 페이지당 출력건수
	 */
	private Integer pagePerRow;

	public PageParam() {
		this(1L, 10);
	}

	public PageParam(Long pageNum, Integer pagePerRow) {
		this.pageNum = pageNum;
		this.pagePerRow = pagePerRow;
	}

	public Long getPageNum() {
		return pageNum;
	}
	
	public void setPageNum(Long pageNum) {
		if (null == pageNum || 0 >= pageNum) {
			pageNum = 1L;
		}
		this.pageNum = pageNum;
	}

	public Integer getPagePerRow() {
		return pagePerRow;
	}

	public void setPagePerRow(Integer pagePerRow) {
		if (null == pagePerRow || 0 >= pagePerRow) {
			pagePerRow = 10;
		}
		this.pagePerRow = pagePerRow;
	}
	
	

}
