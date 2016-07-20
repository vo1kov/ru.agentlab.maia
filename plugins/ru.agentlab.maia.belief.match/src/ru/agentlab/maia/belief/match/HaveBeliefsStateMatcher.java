package ru.agentlab.maia.belief.match;

import java.util.Map;

import javax.inject.Inject;

import de.derivo.sparqldlapi.Query;
import de.derivo.sparqldlapi.QueryEngine;
import de.derivo.sparqldlapi.QueryResult;
import ru.agentlab.maia.IStateMatcher;

public class HaveBeliefsStateMatcher implements IStateMatcher {

	Query query;

	@Inject
	QueryEngine engine;

	public HaveBeliefsStateMatcher(Query query) {
		this.query = query;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		try {
			QueryResult result = engine.execute(query);
			if (query.isSelect()) {
				values.put(QueryResult.class.getName(), result);
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

}
