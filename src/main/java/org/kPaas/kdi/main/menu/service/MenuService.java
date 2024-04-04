package org.kPaas.kdi.main.menu.service;

import org.kPaas.kdi.main.menu.vo.MenuVo;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface MenuService {
    public List<MenuVo> selectMn();

    public ResponseEntity<String> insertMn(MenuVo menuVo);
}