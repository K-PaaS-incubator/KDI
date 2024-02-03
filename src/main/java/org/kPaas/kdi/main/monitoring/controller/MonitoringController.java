package org.kPaas.kdi.main.monitoring.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("monitoring")
@Controller
public class MonitoringController extends AbstractController {
	public MonitoringController() {
		super("monitoring");
	}

	@GetMapping()
	public String monitorList() {
		return layout("monitorList");
	}

}
