package ru.agentlab.maia.annotation2.example;

import static ru.agentlab.maia.annotation2.AxiomType.CLASS_ASSERTION;
import static ru.agentlab.maia.annotation2.AxiomType.DATA_PROPERTY_ASSERTION;

import java.lang.annotation.Annotation;

import ru.agentlab.maia.annotation2.AddedBelief;
import ru.agentlab.maia.annotation2.HaveBelief;
import ru.agentlab.maia.annotation2.HaveGoal;
import ru.agentlab.maia.annotation2.InitialBelief;
import ru.agentlab.maia.annotation2.InitialGoal;
import ru.agentlab.maia.annotation2.RemovedBelief;

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

	public static void main(String[] args) throws NoSuchMethodException, SecurityException {
		Example e = new Example();
		for (Annotation ann : e.getClass().getMethod("test").getAnnotations()) {
			System.out.println(ann);
		}
	}
}
