package ru.agentlab.maia.container.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({
	// @formatter:off
	InjectorMakeTest.class,
	InjectorInjectTest.class,
	// @formatter:on
})
public class InjectorTestSuite {

}
