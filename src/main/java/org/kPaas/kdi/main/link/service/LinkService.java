package org.kPaas.kdi.main.link.service;

import java.util.List;

import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.springframework.http.ResponseEntity;

public interface LinkService {

	public List<String> selectDsList();
}
