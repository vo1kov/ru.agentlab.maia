package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IMatcher;

public class HaveBeliefClassificationMatcher implements IMatcher<IBeliefBase> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> objectMatcher;

	public HaveBeliefClassificationMatcher(IMatcher<OWLNamedObject> subjectMatcher,
			IMatcher<OWLNamedObject> objectMatcher) {
		this.subjectMatcher = subjectMatcher;
		this.objectMatcher = objectMatcher;
	}

	@Override
	public IUnifier match(IBeliefBase object) {
		// TODO Auto-generated method stub
		return null;
	}

}
