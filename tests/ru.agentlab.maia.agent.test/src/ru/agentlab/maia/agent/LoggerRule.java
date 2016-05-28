package ru.agentlab.maia.agent;

import java.util.Arrays;
import java.util.stream.Stream;

import org.junit.rules.TestRule;
import org.junit.runner.Description;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.model.Statement;

public class LoggerRule implements TestRule {

	Object test;

	public LoggerRule(Object test) {
		this.test = test;
	}

	@Override
	public Statement apply(Statement base, Description description) {
		return new Statement() {
			@Override
			public void evaluate() throws Throwable {
				System.out.println();
				System.out.println(
						"--------------------------- " + description.getDisplayName() + " ---------------------------");
				System.out.println();
				Stream.of(test.getClass().getFields()).filter(f -> f.isAnnotationPresent(Parameter.class))
						.forEach(f -> {
							try {
								System.out.println("Input parameter: [" + f.getName() + "] = ["
										+ LoggerRule.this.toString(f.get(test)) + "]");
							} catch (Exception e) {

							}
						});
				try {
					base.evaluate();
					System.out.println("Finished successfully");
				} catch (Exception e) {
					System.out.println("Finished with fail");
					e.printStackTrace();
				}
			}
		};
	}

	private String toString(Object object) {
		if (object.getClass().isArray()) {
			return Arrays.toString((Object[]) object);
		} else {
			return object.toString();
		}
	}

}
