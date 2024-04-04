package org.kPaas.kdi.main.menu.service.impl;

import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.menu.mapper.MenuMapper;
import org.kPaas.kdi.main.menu.service.MenuService;
import org.kPaas.kdi.main.menu.vo.MenuVo;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

@Service
public class MenuImpl {

    @Resource
    private MenuMapper mapper;
    @Resource
    private DBCheckService dbCheckService;

//    @PostConstruct
//    private void init(){
//        if(!dbCheckService.isExists("KDI_MENU")){
//            mapper.createTable();
//        }
//    }
}
