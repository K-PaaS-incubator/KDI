package org.kPaas.kdi.main.mq.service.impl;

import org.kPaas.kdi.main.mq.service.MqListenerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

@Service
public class MqListenerServiceImpl implements MqListenerService {
    private static final Logger log = LoggerFactory.getLogger(MqListenerServiceImpl.class);

    @Override
    @RabbitListener(queues = "pps.queue")
    public void reciveMessage(final Message message) {
        log.info("수신받은 메시지"+message.toString());
        System.out.println("수신받은 메시지"+message.toString());
        
    }
}
