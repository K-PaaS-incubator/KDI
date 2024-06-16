package org.kPaas.kdi.main.res.tpi.service;

<<<<<<< HEAD
import org.kPaas.kdi.com.base.KdiGridService;

public interface TransPathService extends KdiGridService {
=======
import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface TransPathService {

	ResponseEntity<String> get(String trnsPathId);

	ResponseEntity<String> getList(KdiParam mapToKdiParam);

	ResponseEntity<String> duplicateCheck(String trnsPathId);

	ResponseEntity<String> insert(String trnsPathId, String trnsPathNm);

	ResponseEntity<String> modify(String trnsPathId, String orgTrnsPathId, String trnsPathNm);

	ResponseEntity<String> delete(String trnsPathId);

>>>>>>> branch '전수정' of http://git.biz.ppsystem.co.kr/cloud/kdi.git
}
