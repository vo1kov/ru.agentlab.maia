package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLLiteral;

import ru.agentlab.maia.IMatcher;

public abstract class OWLLiteralMatcher implements IMatcher<OWLLiteral>{

	@Override
	public Class<OWLLiteral> getType() {
		return OWLLiteral.class;
	}
	
}
