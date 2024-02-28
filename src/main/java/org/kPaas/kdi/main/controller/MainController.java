package org.kPaas.kdi.main.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@PreAuthorize("isAuthenticated()")
@Controller
public class MainController extends AbstractController {

	@GetMapping()
	public String get() {
		return layout("index");
	}
}
