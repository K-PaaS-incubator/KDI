package org.kPaas.kdi.com.util.criteria;

import lombok.Data;

@Data
public class PageVo {
    private int startPage;
    private int endPage;
    private boolean next;
    private boolean prev;

    private int total;
    private int pageNum;
    private int amount;

    public PageVo(Criteria criteria, int total){
        this.pageNum = criteria.getPageNum();
        this.amount = criteria.getAmount();
        this.total = total;
        this.endPage = (int)Math.ceil(this.pageNum / 10.0) * 10;
        this.startPage = this.endPage - 10 + 1;
        int realEnd = (int)Math.ceil(this.total / (double)this.amount);

        if(this.endPage > realEnd){
            this.endPage = realEnd;
        }
        this.prev = this.startPage >= 1;
        this.next = this.endPage < realEnd;
    }
}
