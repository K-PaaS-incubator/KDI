package org.kPaas.kdi;

import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KDIController {

    private static final String EXCAHGE_NAME = "pps.exchange";
    
    
    @Autowired
    RabbitTemplate rabbitTemplate;

    @PostMapping("pps/queue")
    public Object ppsPublish(String message) {
        rabbitTemplate.convertAndSend(EXCAHGE_NAME, "pps.routing.#", message);
        return message ; 
    }
}
