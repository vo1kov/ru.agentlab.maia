package ru.agentlab.maia.behaviour.primitive.lambda.test;

import java.util.Arrays;

import ru.agentlab.maia.behaviour.Behaviour;
import ru.agentlab.maia.behaviour.primitive.lambda.BehaviourPrimitiveLambda;

public class Test {

	public static void main(String[] args) {
		BehaviourPrimitiveLambda behaviour = new BehaviourPrimitiveLambda();
		behaviour.addInput(new Behaviour.Parameter<String>("string", String.class));
		behaviour.setLambda(a -> new Object[] { Arrays.asList(a).stream().count() });
	}

}