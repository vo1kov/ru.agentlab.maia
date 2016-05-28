package ru.agentlab.maia.agent;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({
	// @formatter:off
	Agent_addRole_Test.class,
	Agent_internalAddRole_Test.class,
	// @formatter:on
})
public class Agent_TestSuite {

}
