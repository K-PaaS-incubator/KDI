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
	private int total = 0;

	/**
	 * 최대 페이지번호 출력건수<br>
	 * |< 1 2 3 4 5 >|
	 */
	private Integer maxPageNumView = 5;

	public int getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		if (null == total) {
			total = 0;
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
