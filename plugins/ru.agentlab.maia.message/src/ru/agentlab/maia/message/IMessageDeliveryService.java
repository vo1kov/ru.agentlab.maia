package ru.agentlab.maia.message;

public interface IMessageDeliveryService {

	void send(IMessage message);

	void addReceiveListener(IMessageDeliveryEventListener listener);

}
