package org.kPaas.kdi.com.util.pagination;

public class PageInfo extends PageParam {
	private static final long serialVersionUID = -8839527454664672007L;

	public PageInfo(PageParam pageParam) {
		setPageNum(pageParam.getPageNum());
		setPagePerRow(pageParam.getPagePerRow());
	}

	/**
	 * 게시물 전체 건수
	 */
	private Long total = 0L;

	/**
	 * 최대 페이지번호 출력건수<br>
	 * |< 1 2 3 4 5 >|
	 */
	private Integer maxPageNumView = 5;

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		if (null == total) {
			total = 0L;
		}
		this.total = total;
	}

	public Integer getMaxPageNumView() {
		return maxPageNumView;
	}

	public void setMaxPageNumView(Integer maxPageNumView) {
		this.maxPageNumView = maxPageNumView;
	}

}
