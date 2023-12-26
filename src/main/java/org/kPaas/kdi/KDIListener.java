package org.kPaas.kdi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class KDIListener {

    private static final Logger log = LoggerFactory.getLogger(KDIListener.class);

    @RabbitListener(queues = "pps.queue")
    public void reciveMessage(final Message message) {
        log.info("수신받은 메시지"+message.toString());
        System.out.println("수신받은 메시지"+message.toString());
        
    }
}
