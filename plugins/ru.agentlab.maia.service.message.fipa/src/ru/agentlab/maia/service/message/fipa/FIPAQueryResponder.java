package ru.agentlab.maia.service.message.fipa;

import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.AGREE;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.CANCEL;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.INFORM_IF;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.INFORM_REF;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.NOT_UNDERSTOOD;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.QUERY_IF;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.QUERY_REF;
import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.service.message.fipa.FIPAProtocolNames.FIPA_QUERY;

import javax.inject.Inject;

import de.derivo.sparqldlapi.Query;
import de.derivo.sparqldlapi.QueryEngine;
import de.derivo.sparqldlapi.QueryResult;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.service.message.IMessageDeliveryService;
import ru.agentlab.maia.service.message.annotation.OnMessageReceived;

public class FIPAQueryResponder {

	private static final String SPARQL_DL = "SPARQL-DL";

	private static final String UNKNOWN_LANGUAGE_MESSAGE = "Unknown language. Only " + SPARQL_DL + " is supported";

	@Inject
	private IMessageDeliveryService messaging;

	@Inject
	private IBeliefBase beliefBase;
	
	@Inject
	private QueryEngine queryEngine;

	@OnMessageReceived(performative = QUERY_IF, protocol = FIPA_QUERY)
	public void onQueryIf(IMessage message) {
		if (message.getLanguage() != SPARQL_DL) {
			messaging.reply(message, NOT_UNDERSTOOD, UNKNOWN_LANGUAGE_MESSAGE);
		}
		messaging.reply(message, AGREE);
		try {
			String content = message.getContent();
			Query query = Query.create(content);
			QueryResult result = queryEngine.execute(query);
			if (!query.isAsk()) {
				messaging.reply(message, REFUSE);
			}
			messaging.reply(message, INFORM_IF, Boolean.toString(result.ask()));
		} catch (Exception e) {
			messaging.reply(message, REFUSE, e.getMessage());
		}
	}

	@OnMessageReceived(performative = QUERY_REF, protocol = FIPA_QUERY)
	public void onQueryRef(IMessage message) {
		if (message.getLanguage() != SPARQL_DL) {
			messaging.reply(message, NOT_UNDERSTOOD, UNKNOWN_LANGUAGE_MESSAGE);
		}
		messaging.reply(message, AGREE);
		try {
			String content = message.getContent();
			Query query = Query.create(content);
			QueryResult result = queryEngine.execute(query);
			if (query.isAsk()) {
				messaging.reply(message, REFUSE);
			}
			messaging.reply(message, INFORM_REF, result.toJSON());
		} catch (Exception e) {
			messaging.reply(message, REFUSE, e.getMessage());
		}
	}

	@OnMessageReceived(performative = CANCEL, protocol = FIPA_QUERY)
	public void onCancel(IMessage message) {
	}

}
