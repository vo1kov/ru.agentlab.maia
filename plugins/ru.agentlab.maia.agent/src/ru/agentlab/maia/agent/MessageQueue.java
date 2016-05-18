package ru.agentlab.maia.agent;

import java.util.concurrent.ConcurrentLinkedQueue;

import ru.agentlab.maia.IMessage;

public class MessageQueue extends ConcurrentLinkedQueue<IMessage> implements IMessageQueue {

	private static final long serialVersionUID = 1L;

}
