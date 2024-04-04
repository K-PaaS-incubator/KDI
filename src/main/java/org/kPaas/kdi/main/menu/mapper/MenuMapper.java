package org.kPaas.kdi.main.menu.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.menu.vo.MenuVo;

import java.util.List;

@Mapper
public interface MenuMapper {
    // 메뉴 테이블 생성
    public void createTable();

    public List<MenuVo> selectMn();
    public void insertMn(MenuVo menuVo);
}
