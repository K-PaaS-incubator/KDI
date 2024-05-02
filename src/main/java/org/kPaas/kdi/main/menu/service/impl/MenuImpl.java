package org.kPaas.kdi.main.menu.service.impl;

import javax.annotation.Resource;

import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.menu.mapper.MenuMapper;
import org.springframework.stereotype.Service;

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
