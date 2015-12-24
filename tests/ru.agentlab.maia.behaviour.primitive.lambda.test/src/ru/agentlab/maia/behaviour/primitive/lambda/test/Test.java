package ru.agentlab.maia.behaviour.primitive.lambda.test;

import java.util.Arrays;

import ru.agentlab.maia.behaviour.primitive.lambda.BehaviourPrimitiveLambda;

public class Test {

	public static void main(String[] args) {
		BehaviourPrimitiveLambda behaviour = new BehaviourPrimitiveLambda();
		behaviour.setImplementation(a -> new Object[] { Arrays.asList(a).stream().count() });
	}

}