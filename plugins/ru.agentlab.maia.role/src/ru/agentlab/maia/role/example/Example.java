package ru.agentlab.maia.role.example;

import static ru.agentlab.maia.role.AxiomType.CLASS_ASSERTION;
import static ru.agentlab.maia.role.AxiomType.DATA_PROPERTY_ASSERTION;

import java.lang.annotation.Annotation;

import ru.agentlab.maia.role.AddedBelief;
import ru.agentlab.maia.role.AddedMessage;
import ru.agentlab.maia.role.HaveBelief;
import ru.agentlab.maia.role.HaveGoal;
import ru.agentlab.maia.role.InitialBelief;
import ru.agentlab.maia.role.InitialGoal;
import ru.agentlab.maia.role.RemovedBelief;

@InitialBelief(value = { "?ind", "?property", "3^^xsd:integer" }, type = DATA_PROPERTY_ASSERTION)
@InitialBelief(value = { "rdf:Test", "owl:Thing" }, type = CLASS_ASSERTION)
@InitialGoal(value = { "rdf:Test", "owl:Thing" }, type = CLASS_ASSERTION)
@InitialGoal(value = { "rdf:Test", "owl:Thing" }, type = CLASS_ASSERTION)
public class Example {

	@AddedBelief(value = { "rdf:Test", "owl:Thing" }, type = CLASS_ASSERTION)
	@HaveBelief(value = { "?ind", "?property", "2^^xsd:integer" }, type = DATA_PROPERTY_ASSERTION)
	@HaveBelief(value = { "rdf:Some", "rdf:ind" }, type = CLASS_ASSERTION)
	@HaveGoal(value = { "rdf:Some", "rdf:ind" }, type = CLASS_ASSERTION)
	public void test() {
	}

	@RemovedBelief(value = { "rdf:Test", "owl:Thing" }, type = CLASS_ASSERTION)
	@HaveBelief(value = { "?ind", "?property", "2^^xsd:integer" }, type = DATA_PROPERTY_ASSERTION)
	@HaveBelief(value = { "rdf:Some", "rdf:ind" }, type = CLASS_ASSERTION)
	@HaveGoal(value = { "rdf:Some", "rdf:ind" }, type = CLASS_ASSERTION)
	public void test2() {
	}

	@AddedMessage(performative = "FIPA-REQUEST")
	public static void main(String[] args) throws NoSuchMethodException, SecurityException {
		Example e = new Example();
		for (Annotation ann : e.getClass().getMethod("test").getAnnotations()) {
			System.out.println(ann);
		}
	}
}
