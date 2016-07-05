package ru.agentlab.maia.admin.bundles;

import static ru.agentlab.maia.IMessage.AGREE;
import static ru.agentlab.maia.IMessage.CANCEL;
import static ru.agentlab.maia.IMessage.FAILURE;
import static ru.agentlab.maia.IMessage.INFORM;
import static ru.agentlab.maia.IMessage.REFUSE;
import static ru.agentlab.maia.IMessage.SUBSCRIBE;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.inject.Named;

import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.messaging.AclMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;
import ru.agentlab.maia.role.AddedBelief;
import ru.agentlab.maia.role.AddedMessage;
import ru.agentlab.maia.role.AxiomType;
import ru.agentlab.maia.role.HaveBelief;
import ru.agentlab.maia.role.Prefix;

public class BundleSubscriptionResponder {

	private Map<UUID, String> subscriberConverdationIds = new HashMap<>();

	private Map<String, List<UUID>> subscriberProperties = new HashMap<>();

	@Inject
	UUID uuid;

	@Inject
	IMessageDeliveryService mts;

	@AddedMessage(performative = SUBSCRIBE, protocol = "FIPA_SUBSCRIBE")
	public void onSubscribe(IMessage message) {
		UUID sender = message.getSender();
		String conversationId = message.getConversationId();
		subscriberConverdationIds.put(sender, conversationId);
		String property = message.getContent();
		if (property == null) {
			reply(message, REFUSE);
		}
		List<UUID> receivers = subscriberProperties.get(property);
		if (receivers == null) {
			receivers = new ArrayList<>();
			subscriberProperties.put(property, receivers);
		}
		receivers.add(sender);
		reply(message, AGREE);
	}

	@AddedMessage(performative = CANCEL, protocol = "FIPA_SUBSCRIBE")
	public void onCancel(IMessage message) {
		UUID sender = message.getSender();
		String conversationId = message.getConversationId();
		if (subscriberConverdationIds.get(sender) == conversationId) {
			subscriberConverdationIds.remove(sender);
			reply(message, INFORM);
		} else {
			reply(message, FAILURE);
		}
	}

	@AddedBelief(value = { "?bundle", "?property", "?value" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
	@HaveBelief(value = { "?bundle", "osgi:Bundle" }, type = AxiomType.CLASS_ASSERTION)
	@Prefix(name = "osgi", namespace = "http://www.agentlab.ru/ontologies/osgi")
	public void onPropertyChanged(@Named("bundle") String bundle, @Named("property") String property,
			@Named("value") String value) {
		IMessage message = new AclMessage();
		message.setPerformative(INFORM);
		List<UUID> receivers = subscriberProperties.get(property);
		message.setReceivers(receivers);
		message.setSender(uuid);
		message.setContent(bundle + " " + property + " " + value);
		mts.send(message);
	}

	private void reply(IMessage message, String performative) {
		IMessage reply = message.createReply();
		reply.setPerformative(performative);
		mts.send(reply);
	}

}
