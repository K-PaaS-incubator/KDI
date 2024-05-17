package org.kPaas.kdi.com.menu.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.com.menu.vo.MenuVo;

import java.util.List;

@Mapper
public interface MenuMapper {
    // 메뉴 테이블 생성
    public void createTable();

    public List<MenuVo> selectMn();
    public void insertMn(MenuVo menuVo);
}
