package ru.agentlab.maia;

import ru.agentlab.maia.messaging.IMessage;

public interface IMessageService {

	void send(IMessage message);

}
