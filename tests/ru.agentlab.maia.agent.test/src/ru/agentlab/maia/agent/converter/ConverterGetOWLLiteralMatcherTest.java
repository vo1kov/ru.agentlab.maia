/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.agent.converter;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralMiscMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralOWLRationalMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralOWLRealMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralRDFPlainLiteralMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralRDFSLiteralMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralRDFXMLLiteralMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDAnyURIMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDBase64BinaryMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDBooleanMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDByteMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDDateTimeMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDDateTimeStampMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDDecimalMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDDoubleMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDFloatMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDHexBinaryMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDIntMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDIntegerMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDLanguageMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDLongMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNCNameMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNMTOKENMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNameMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNegativeIntegerMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNonNegativeIntegerMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNonPositiveIntegerMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDNormalizedStringMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDPositiveIntegerMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDShortMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDStringMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDTokenMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDUnsignedByteMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDUnsignedIntMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDUnsignedLongMatcherTest;
import ru.agentlab.maia.agent.converter.literal.ConverterGetOWLLiteralXSDUnsignedShortMatcherTest;

/**
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Suite.class)
@SuiteClasses({
// @formatter:off
	ConverterGetOWLLiteralMiscMatcherTest.class,
	ConverterGetOWLLiteralOWLRationalMatcherTest.class,
	ConverterGetOWLLiteralOWLRealMatcherTest.class,
	ConverterGetOWLLiteralRDFPlainLiteralMatcherTest.class,
	ConverterGetOWLLiteralRDFSLiteralMatcherTest.class,
	ConverterGetOWLLiteralRDFXMLLiteralMatcherTest.class,
	ConverterGetOWLLiteralXSDAnyURIMatcherTest.class,
	ConverterGetOWLLiteralXSDBase64BinaryMatcherTest.class,
	ConverterGetOWLLiteralXSDBooleanMatcherTest.class,
	ConverterGetOWLLiteralXSDByteMatcherTest.class,
	ConverterGetOWLLiteralXSDDateTimeMatcherTest.class,
	ConverterGetOWLLiteralXSDDateTimeStampMatcherTest.class,
	ConverterGetOWLLiteralXSDDecimalMatcherTest.class,
	ConverterGetOWLLiteralXSDDoubleMatcherTest.class,
	ConverterGetOWLLiteralXSDFloatMatcherTest.class,
	ConverterGetOWLLiteralXSDHexBinaryMatcherTest.class,
	ConverterGetOWLLiteralXSDIntegerMatcherTest.class,
	ConverterGetOWLLiteralXSDIntMatcherTest.class,
	ConverterGetOWLLiteralXSDLanguageMatcherTest.class,
	ConverterGetOWLLiteralXSDLongMatcherTest.class,
	ConverterGetOWLLiteralXSDNameMatcherTest.class,
	ConverterGetOWLLiteralXSDNCNameMatcherTest.class,
	ConverterGetOWLLiteralXSDNegativeIntegerMatcherTest.class,
	ConverterGetOWLLiteralXSDNMTOKENMatcherTest.class,
	ConverterGetOWLLiteralXSDNonNegativeIntegerMatcherTest.class,
	ConverterGetOWLLiteralXSDNonPositiveIntegerMatcherTest.class,
	ConverterGetOWLLiteralXSDNormalizedStringMatcherTest.class,
	ConverterGetOWLLiteralXSDPositiveIntegerMatcherTest.class,
	ConverterGetOWLLiteralXSDShortMatcherTest.class,
	ConverterGetOWLLiteralXSDStringMatcherTest.class,
	ConverterGetOWLLiteralXSDTokenMatcherTest.class,
	ConverterGetOWLLiteralXSDUnsignedByteMatcherTest.class,
	ConverterGetOWLLiteralXSDUnsignedIntMatcherTest.class,
	ConverterGetOWLLiteralXSDUnsignedLongMatcherTest.class,
	ConverterGetOWLLiteralXSDUnsignedShortMatcherTest.class
// @formatter:on
})
public class ConverterGetOWLLiteralMatcherTest {
}
