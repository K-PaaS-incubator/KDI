package org.kPaas.kdi.com.menu.service;

import org.kPaas.kdi.com.menu.vo.MenuVo;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface MenuService {
    public List<MenuVo> selectMn();

    public ResponseEntity<String> insertMn(MenuVo menuVo);
}