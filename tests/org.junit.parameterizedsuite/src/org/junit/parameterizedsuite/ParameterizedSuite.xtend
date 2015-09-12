package org.junit.parameterizedsuite

import java.text.MessageFormat
import java.util.ArrayList
import java.util.Arrays
import java.util.Collections
import java.util.List
import org.junit.runner.Runner
import org.junit.runners.Parameterized.Parameters
import org.junit.runners.Parameterized.UseParametersRunnerFactory
import org.junit.runners.Suite
import org.junit.runners.model.FrameworkMethod
import org.junit.runners.model.InitializationError
import org.junit.runners.model.TestClass
import org.junit.runners.parameterized.BlockJUnit4ClassRunnerWithParametersFactory
import org.junit.runners.parameterized.ParametersRunnerFactory
import org.junit.runners.parameterized.TestWithParameters

class ParameterizedSuite extends Suite {
	static final ParametersRunnerFactory DEFAULT_FACTORY = new BlockJUnit4ClassRunnerWithParametersFactory()
	static final List<Runner> NO_RUNNERS = Collections.<Runner>emptyList()
	final List<Runner> runners
	Class<?> suite

	/** 
	 * Only called reflectively. Do not use programmatically.
	 */
	new(Class<?> klass) throws Throwable {
		super(klass, NO_RUNNERS)
		suite = klass
		var ParametersRunnerFactory runnerFactory = getParametersRunnerFactory(klass)
		var Parameters parameters = getParametersMethod().getAnnotation(Parameters)
		runners = Collections.unmodifiableList(
			createRunnersForParameters(allParameters(), parameters.name(), runnerFactory))
	}

	def private ParametersRunnerFactory getParametersRunnerFactory(
		Class<?> klass) throws InstantiationException, IllegalAccessException {
		var UseParametersRunnerFactory annotation = klass.getAnnotation(UseParametersRunnerFactory)
		if (annotation === null) {
			return DEFAULT_FACTORY
		} else {
			var Class<? extends ParametersRunnerFactory> factoryClass = annotation.value()
			return factoryClass.newInstance()
		}
	}

	override protected List<Runner> getChildren() {
		return runners
	}

	def private TestWithParameters createTestWithNotNormalizedParameters(TestClass test, String pattern, int index,
		Object parametersOrSingleParameter) {
		var Object[] parameters = if
			((parametersOrSingleParameter instanceof Object[])) parametersOrSingleParameter as Object[] else #[
				parametersOrSingleParameter]
		return createTestWithParameters(test, pattern, index, parameters)
	}

	@SuppressWarnings("unchecked") def private Iterable<Object> allParameters() throws Throwable {
		var Object parameters = getParametersMethod().invokeExplosively(null)
		if (parameters instanceof Iterable) {
			return parameters as Iterable<Object>
		} else if (parameters instanceof Object[]) {
			return Arrays.asList(parameters as Object[])
		} else {
			throw parametersMethodReturnedWrongType()
		}
	}

	def private FrameworkMethod getParametersMethod() throws Exception {
		var List<FrameworkMethod> methods = getTestClass().getAnnotatedMethods(Parameters)
		for (FrameworkMethod each : methods) {
			if (each.isStatic() && each.isPublic()) {
				return each
			}

		}
		throw new Exception('''No public static parameters method on class �getTestClass().getName()�''')
	}

	def private List<Runner> createRunnersForParameters(Iterable<Object> allParameters, String namePattern,
		ParametersRunnerFactory runnerFactory) throws InitializationError, Exception {
		try {
			var List<TestWithParameters> tests = createTestsForParameters(allParameters, namePattern)
			var List<Runner> runners = new ArrayList<Runner>()
			for (TestWithParameters test : tests) {
				runners.add(runnerFactory.createRunnerForTestWithParameters(test))
			}
			return runners
		} catch (ClassCastException e) {
			throw parametersMethodReturnedWrongType()
		}

	}

	def private static Class<?>[] getAnnotatedClasses(Class<?> klass) throws InitializationError {
		var SuiteClasses annotation = klass.getAnnotation(SuiteClasses)
		if (annotation === null) {
			throw new InitializationError(
				String.format("class '%s' must have a SuiteClasses annotation", klass.getName()))
		}
		return annotation.value()
	}

	def private List<TestWithParameters> createTestsForParameters(Iterable<Object> allParameters,
		String namePattern) throws Exception {
		var int i = 0
		var List<TestWithParameters> children = new ArrayList<TestWithParameters>()
		var Class<?>[] childs = getAnnotatedClasses(suite)
		for (Class<?> c : childs) {
			var TestClass test = createTestClass(c)
			for (Object parametersOfSingleTest : allParameters()) {
				children.add(createTestWithNotNormalizedParameters(test, namePattern, i++, parametersOfSingleTest))
			}

		}
		return children
	}

	def private Exception parametersMethodReturnedWrongType() throws Exception {
		var String className = getTestClass().getName()
		var String methodName = getParametersMethod().getName()
		var String message = MessageFormat.format("{0}.{1}() must return an Iterable of arrays.", className, methodName)
		return new Exception(message)
	}

	def private static TestWithParameters createTestWithParameters(TestClass testClass, String pattern, int index,
		Object[] parameters) {
		var String finalPattern = pattern.replaceAll("\\{index\\}", Integer.toString(index))
		var String name = MessageFormat.format(finalPattern, parameters)
		return new TestWithParameters('''[�name�]''', testClass, Arrays.asList(parameters))
	}

}
