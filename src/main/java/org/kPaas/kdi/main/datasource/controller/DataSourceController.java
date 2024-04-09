package org.kPaas.kdi.main.datasource.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.util.criteria.Criteria;
import org.kPaas.kdi.com.util.criteria.PageVo;
import org.kPaas.kdi.main.datasource.service.DatasourceService;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/ds")
@Controller
public class DataSourceController extends AbstractController {
	public DataSourceController() {
		super("dataSourceMg");
	}

	@Autowired
	DatasourceService service;

	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
	@GetMapping("/dsList")
	public String dsList(Model model,
						 @RequestParam(value = "pageNum", required = false, defaultValue = "1")Integer pageNum,
						 @RequestParam(value = "ds_nm", required = false)String ds_nm,
						 RedirectAttributes redirectAttributes
	) {
		if (pageNum == null) {
			redirectAttributes.addAttribute("pageNum", 1);
			redirectAttributes.addAttribute("amount", 10);
			return "redirect:/ds/dsList";
		}

		DatasourceVo datasourceVo = new DatasourceVo();
		datasourceVo.setPageNum(pageNum);
		datasourceVo.setAmount(10);
		datasourceVo.setDs_nm(ds_nm);

		Criteria criteria = new Criteria();
		criteria.setPageNum(pageNum);

		PageVo pageVo = new PageVo(criteria, service.selectDsListCount(datasourceVo));

		model.addAttribute("selectDsListPage", service.selectDsListPage(datasourceVo));
		model.addAttribute("pagination", pageVo);

		return layout("dsList");
	}

	@GetMapping("/dsCreate")
	public String dsCreate() {
		return layout("dsCreate");
	}

	@PostMapping("/dsCheck")
	public ResponseEntity<String> dsCheck(DatasourceVo datasource_vo) {
		int dsCnt = 0;
		dsCnt = service.getSameDsCheck(datasource_vo.getDs_nm());
		if (dsCnt > 0) {
			return ResponseEntity.badRequest().body("중복제목입니다.");
		} else {
			return ResponseEntity.ok("정상");
		}
	}

	@PostMapping("/dsInsert")
	public ResponseEntity<String> dsWrite(DatasourceVo datasource_vo) {
		return service.insertDS(datasource_vo);
	}

	@GetMapping("/dsEdit")
	public String dsEdit(Model model, @RequestParam("ds_nm") String ds_nm) {
		model.addAttribute("selectDsInfo", service.selectDsInfo(ds_nm));
		return layout("dsEdit");
	}

	@ResponseBody
	@PostMapping("/dsEditProc")
	public ResponseEntity<String> dsEditProc(DatasourceVo datasource_vo) {
		return service.editDS(datasource_vo);
	}

	@ResponseBody
	@PostMapping("/dsDelProc")
	public ResponseEntity<String> dsDelProc(String ds_nm) {
		return service.delDS(ds_nm);
	}

	@ResponseBody
	@PostMapping("/testConnection")
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		return service.testConnection(datasource_vo);
	}

}
