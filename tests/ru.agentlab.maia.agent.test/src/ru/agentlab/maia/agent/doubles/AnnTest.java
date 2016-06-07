package ru.agentlab.maia.agent.doubles;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;

import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLIndividual;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.annotation.event.AddedDataPropertyAssertion;
import ru.agentlab.maia.annotation.state.HaveClassAssertion;
import ru.agentlab.maia.annotation.state.HaveSubClassOf;

public class AnnTest {
	
	@Inject
	IAgent agent;
	
	@PostConstruct
	public void init(){
		System.out.println(agent.getUuid());
	}

	@AddedDataPropertyAssertion("rdf:ind rdf:hasProperty 2^^xsd:integer")
	@HaveSubClassOf("owl:Thing rdf:Some")
	@HaveClassAssertion("rdf:Some rdf:ind")
	public void exe() {
		System.out.println("WORKS");

	}

	@AddedDataPropertyAssertion("?ind ?property 2^^xsd:integer")
	@HaveSubClassOf("owl:Thing rdf:Some")
	@HaveClassAssertion("rdf:Some rdf:ind")
	public void exe2(
			@Named("property") OWLDataProperty property, 
			@Named("ind") OWLIndividual ind
		) {
		System.out.println("WORKS2" + property.toString());
		System.out.println("WORKS2" + ind.toString());

	}

}
