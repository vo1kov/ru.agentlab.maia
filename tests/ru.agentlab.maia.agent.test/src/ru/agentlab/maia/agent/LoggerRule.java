package ru.agentlab.maia.agent;

import org.junit.rules.TestRule;
import org.junit.runner.Description;
import org.junit.runners.model.Statement;

public class LoggerRule implements TestRule {

	private int i = 0;

	@Override
	public Statement apply(Statement base, Description description) {
		return new Statement() {
			@Override
			public void evaluate() throws Throwable {
				String label = description.getTestClass().getSimpleName() + " [Test Case " + i++ + "]";
				System.out.println();
				System.out.println("--------------------------- " + label + " ---------------------------");
				base.evaluate();
			}
		};
	}

}
