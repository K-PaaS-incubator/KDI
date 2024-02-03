package org.kPaas.kdi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages= {"org.kPaas.kdi","org.kPaas.kdi.**"})
public class KdiApplication {

	public static void main(String[] args) {
		SpringApplication.run(KdiApplication.class, args);
	}

}
