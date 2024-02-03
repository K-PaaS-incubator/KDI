package org.kPaas.kdi.main.mq.service;

import org.springframework.amqp.core.Message;

public interface MqListenerService {
	void reciveMessage(final Message message);
}
