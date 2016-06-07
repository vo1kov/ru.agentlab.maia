package ru.agentlab.maia.agent.doubles;

import javax.inject.Named;

import org.semanticweb.owlapi.model.OWLDataProperty;

import ru.agentlab.maia.annotation.event.AddedDataPropertyAssertion;
import ru.agentlab.maia.annotation.state.HaveClassAssertion;
import ru.agentlab.maia.annotation.state.HaveSubClassOf;

public class AnnTest {

	@AddedDataPropertyAssertion("rdf:ind rdf:hasProperty 2^^xsd:integer")
	@HaveSubClassOf("owl:Thing rdf:Some")
	@HaveClassAssertion("rdf:Some rdf:ind")
	public void exe() {
		System.out.println("WORKS");

	}

	@AddedDataPropertyAssertion("rdf:ind ?property 2^^xsd:integer")
	@HaveSubClassOf("owl:Thing rdf:Some")
	@HaveClassAssertion("rdf:Some rdf:ind")
	public void exe2(@Named("property") OWLDataProperty property) {
		System.out.println("WORKS2" + property.toString());

	}

}
