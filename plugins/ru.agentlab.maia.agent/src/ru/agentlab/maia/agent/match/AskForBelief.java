package ru.agentlab.maia.agent.match;

import java.util.Map;

import javax.inject.Inject;

import de.derivo.sparqldlapi.Query;
import de.derivo.sparqldlapi.QueryEngine;
import de.derivo.sparqldlapi.QueryResult;
import de.derivo.sparqldlapi.exceptions.QueryEngineException;

public class AskForBelief {

	Query query;

	@Inject
	QueryEngine engine;

	public AskForBelief(Query query) {
		this.query = query;
	}

	public boolean ask(Map<String, Object> values) {
		try {
			QueryResult result = engine.execute(query);
			return result.ask();
		} catch (QueryEngineException e) {
			e.printStackTrace();
			return false;
		}
	}

}
