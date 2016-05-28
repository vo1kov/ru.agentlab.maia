package ru.agentlab.maia.agent.converter;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({
	// @formatter:off
	ConverterSplitClassAssertionTest.class,
	ConverterSplitDataPropertyAssertionTest.class,
	ConverterSplitObjectPropertyAssertionTest.class,
	ConverterSplitDatatypeLiteralTest.class,
	ConverterGetOWLLiteralMatcherTest.class
	// @formatter:on
})
public class ConverterTestSuite {

}
