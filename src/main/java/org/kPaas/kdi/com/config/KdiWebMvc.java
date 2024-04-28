package org.kPaas.kdi.com.config;

import java.nio.charset.Charset;
import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.ResourceHttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc // annotation-driven
@Configuration
public class KdiWebMvc implements WebMvcConfigurer {
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		WebMvcConfigurer.super.addResourceHandlers(registry);

		registry.addResourceHandler("/commonJs/**").addResourceLocations("classpath:static/commonJs/");
		registry.addResourceHandler("/css/**").addResourceLocations("classpath:static/css/");
		registry.addResourceHandler("/font/**").addResourceLocations("/resources/font/");
		registry.addResourceHandler("/img/**").addResourceLocations("classpath:static/img/");
		registry.addResourceHandler("/js/**").addResourceLocations("classpath:static/js/");
		registry.addResourceHandler("/html/**").addResourceLocations("classpath:static/html/");
		registry.addResourceHandler("/*.*").addResourceLocations("classpath:static/");

	}

	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.ignoreAcceptHeader(false)// HttpRequest Header의 Accept 무시여부
				.defaultContentType(MediaType.ALL) // 기본값
				.mediaType("do", MediaType.TEXT_HTML) // 확장자가 do인 경우
				.mediaType("xml", MediaType.APPLICATION_ATOM_XML) // 확장자가 xml인 경우
				.mediaType("json", MediaType.APPLICATION_JSON) // 확장자가 json인 경우
				.mediaType("html", MediaType.TEXT_HTML); // 확장자가 html인 경우

		WebMvcConfigurer.super.configureContentNegotiation(configurer);
	}

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		converters.add(new ByteArrayHttpMessageConverter()); // 바이트 배열 읽기/쓰기. 모든 미디어 타입(*/*)에서 읽고
																// application/octect-stream으로 쓴다.
		converters.add(new StringHttpMessageConverter(Charset.forName("UTF-8")) {
			{
				setWriteAcceptCharset(true);
			}
		}); // 모든 미디어 타입(*/*)을 String으로 읽는다. text/plain에 대한 String을 쓴다.
		converters.add(new ResourceHttpMessageConverter()); // Resource를 읽고 쓰기.
		converters.add(new FormHttpMessageConverter()); // application/x-www-form-urlencoded. Form data is read from and
														// written into a MultiValueMap.
		converters.add(new MappingJackson2HttpMessageConverter());
	}

}
