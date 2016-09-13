package ru.agentlab.maia.message;

import ru.agentlab.maia.agent.IMessage;

public interface IMessageDeliveryService {

	void send(IMessage message);

	default void reply(IMessage message, String performative) {
		send(message.getReply(performative));
	}

	default void reply(IMessage message, String performative, String content) {
		IMessage reply = message.getReply(performative);
		reply.setContent(content);
		send(reply);
	}

}
