package ru.agentlab.maia.container.test;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.instanceOf;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.hamcrest.Matcher;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

import com.google.common.collect.ImmutableMap;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.InjectorException;
import ru.agentlab.maia.container.Injector;
import ru.agentlab.maia.tests.util.LoggerRule;

/**
 * 
 * @see #testCases()
 * @see #evaluateTestCase()
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class InjectorMakeTest {

	private static final Class<NullPointerException> NPE = NullPointerException.class;
	private static final Class<InjectorException> EXCEPTION = InjectorException.class;

	private static final String STRING_NAMED = "STRING_NAMED";

	private static final String STRING_VALUE1 = "Test";
	private static final String STRING_VALUE2 = "zxcqw-wer3#$%^&*e";

	private static final int INT_VALUE1 = 12334;
	private static final int INT_VALUE2 = 12;

	// @formatter:off
	/** STRING_VALUE1 via String.class  */
	private static final Map<Object, Object> TSTRING1 = ImmutableMap.of(
			String.class, STRING_VALUE1,
			String.class.getName(), STRING_VALUE1
		);
	/** STRING_VALUE2 via String.class  */
	private static final Map<Object, Object> TSTRING2 = ImmutableMap.of(
			String.class, STRING_VALUE2,
			String.class.getName(), STRING_VALUE2
		);
	/** INT_VALUE1 via Integer.class  */
	private static final Map<Object, Object> TINT1 = ImmutableMap.of(
			Integer.class, INT_VALUE1, 
			Integer.class.getName(), INT_VALUE1
		);
	/** INT_VALUE2 via Integer.class  */
	private static final Map<Object, Object> TINT2 = ImmutableMap.of(
			Integer.class, INT_VALUE2, 
			Integer.class.getName(), INT_VALUE2
		);
	/** 
	 * STRING_VALUE1 via String.class  
	 * INT_VALUE1 via Integer.class  
	 */
	private static final Map<Object, Object> TSTRING1_TINT1 = ImmutableMap.of(
			String.class, STRING_VALUE1,
			String.class.getName(), STRING_VALUE1, 
			Integer.class, INT_VALUE1, 
			Integer.class.getName(), INT_VALUE1
		);
	/** 
	 * STRING_VALUE2 via String.class  
	 * INT_VALUE2 via Integer.class  
	 */
	private static final Map<Object, Object> TSTRING2_TINT2 = ImmutableMap.of(
			String.class, STRING_VALUE2,
			String.class.getName(), STRING_VALUE2, 
			Integer.class, INT_VALUE2, 
			Integer.class.getName(), INT_VALUE2
		);
	/** STRING_VALUE1 via "STRING_NAMED"  */
	private static final Map<Object, Object> NSTRING1 = ImmutableMap.of(
			STRING_NAMED, STRING_VALUE1
		);
	/** STRING_VALUE2 via "STRING_NAMED"  */
	private static final Map<Object, Object> NSTRING2 = ImmutableMap.of(
			STRING_NAMED, STRING_VALUE2
		);
	/** 
	 * STRING_VALUE1 via String.class  
	 * STRING_VALUE2 via "STRING_NAMED"  
	 */
	private static final Map<Object, Object> TSTRING1_NSTRING2 = ImmutableMap.of(
			String.class, STRING_VALUE1,
			String.class.getName(), STRING_VALUE1, 
			STRING_NAMED, STRING_VALUE2
		);
	// @formatter:on

	@Parameters
	public static Collection<Object[]> testCases() {
		return Arrays.asList(new Object[][] {
		// @formatter:off
		/* --------------------------------------------------------------------------------------------------------------------------------
		 *|      | Inputs                                                             | State         | Outputs                            |
		 *|  ##  |-------------------------------------------------------------------------------------------------------------------------|
		 *|      | Class                                              | Additional    | Container     | Result                             |
		 *--------------------------------------------------------------------------------------------------------------------------------*/
		/*  0 */ { null,                                              null,           null,           NPE },
		/*  1 */ { NoConstructor.class,                               null,           null,           notNullValue() },
		// Empty constructors
		/*  2 */ { SingleEmptyPublicConstructor.class,                null,           null,           notNullValue() },
		/*  3 */ { SingleEmptyProtectedConstructor.class,             null,           null,           notNullValue() },
		/*  4 */ { SingleEmptyPrivateConstructor.class,               null,           null,           notNullValue() },
		/*  5 */ { SingleEmptyPublicAnnotatedConstructor.class,       null,           null,           notNullValue() },
		/*  6 */ { SingleEmptyProtectedAnnotatedConstructor.class,    null,           null,           notNullValue() },
		/*  7 */ { SingleEmptyPrivateAnnotatedConstructor.class,      null,           null,           notNullValue() },
		// Constructor with 1 parameter
		/*  8 */ { SingleStringConstructor.class,                     null,           null,           EXCEPTION },
		/*  9 */ { SingleStringConstructor.class,                     TSTRING1,       null,           EXCEPTION },
		/* 10 */ { SingleStringConstructor.class,                     null,           TSTRING1,       EXCEPTION },
		/* 11 */ { SingleStringAnnotatedConstructor.class,            null,           null,           EXCEPTION },
		/* 12 */ { SingleStringAnnotatedConstructor.class,            TSTRING1,       null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		/* 13 */ { SingleStringAnnotatedConstructor.class,            null,           TSTRING1,       allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		/* 14 */ { SingleStringAnnotatedConstructor.class,            TSTRING2,       TSTRING1,       allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		// Constructor with 2 different parameters
		/* 15 */ { SingleStringIntegerConstructor.class,              null,           null,           EXCEPTION },
		/* 16 */ { SingleStringIntegerConstructor.class,              TSTRING1,       null,           EXCEPTION },
		/* 17 */ { SingleStringIntegerConstructor.class,              null,           TSTRING1,       EXCEPTION },
		/* 18 */ { SingleStringIntegerConstructor.class,              TINT1,          null,           EXCEPTION },
		/* 19 */ { SingleStringIntegerConstructor.class,              null,           TINT1,          EXCEPTION },
		/* 20 */ { SingleStringIntegerConstructor.class,              TSTRING1_TINT1, null,           EXCEPTION },
		/* 21 */ { SingleStringIntegerConstructor.class,              null,           TSTRING1_TINT1, EXCEPTION },
		/* 22 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           null,           EXCEPTION },
		/* 23 */ { SingleStringIntegerAnnotatedConstructor.class,     TSTRING1,       null,           EXCEPTION },
		/* 24 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           TSTRING1,       EXCEPTION },
		/* 25 */ { SingleStringIntegerAnnotatedConstructor.class,     TINT1,          null,           EXCEPTION },
		/* 26 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           TINT1,          EXCEPTION },
		/* 27 */ { SingleStringIntegerAnnotatedConstructor.class,     TSTRING1_TINT1, null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 28 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           TSTRING1_TINT1, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 29 */ { SingleStringIntegerAnnotatedConstructor.class,     TSTRING2_TINT2, TSTRING1_TINT1, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("intValue", is(INT_VALUE2))) },
		/* 30 */ { SingleStringIntegerAnnotatedConstructor.class,     TINT2,          TSTRING1_TINT1, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE2))) },
		/* 31 */ { SingleStringIntegerAnnotatedConstructor.class,     TSTRING2,       TSTRING1_TINT1, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("intValue", is(INT_VALUE1))) },
		// Some of parameters are @Named
		/* 32 */ { SingleStringNamedConstructor.class,                null,           null,           EXCEPTION },
		/* 33 */ { SingleStringNamedConstructor.class,                TSTRING2,       null,           EXCEPTION },
		/* 34 */ { SingleStringNamedConstructor.class,                null,           TSTRING2,       EXCEPTION },
		/* 35 */ { SingleStringNamedAnnotatedConstructor.class,       null,           null,           EXCEPTION },
		/* 36 */ { SingleStringNamedAnnotatedConstructor.class,       TSTRING2,       null,           EXCEPTION },
		/* 37 */ { SingleStringNamedAnnotatedConstructor.class,       null,           TSTRING2,       EXCEPTION },
		/* 38 */ { SingleStringNamedAnnotatedConstructor.class,       NSTRING2,       null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		/* 39 */ { SingleStringNamedAnnotatedConstructor.class,       null,           NSTRING2,       allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		/* 40 */ { SingleStringNamedAnnotatedConstructor.class,       NSTRING1,       NSTRING2,       allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		/* 41 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           null,           EXCEPTION },
		/* 42 */ { SingleStringStringNamedAnnotatedConstructor.class, TSTRING1,       null,           EXCEPTION },
		/* 43 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           TSTRING1,       EXCEPTION },
		/* 44 */ { SingleStringStringNamedAnnotatedConstructor.class, TSTRING2,       null,           EXCEPTION },
		/* 45 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           TSTRING2,       EXCEPTION },
		/* 46 */ { SingleStringStringNamedAnnotatedConstructor.class, TSTRING1_NSTRING2, null,        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE2))) },
		/* 47 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           TSTRING1_NSTRING2, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE2))) },
		/* 48 */ { SingleStringStringNamedAnnotatedConstructor.class, NSTRING1,       TSTRING1_NSTRING2, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE1))) },
		/* 49 */ { SingleStringStringNamedAnnotatedConstructor.class, NSTRING1,       TSTRING1_NSTRING2, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE1))) },
		/* 50 */ { SingleStringStringNamedAnnotatedConstructor.class, TSTRING2,       TSTRING1_NSTRING2, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", is(STRING_VALUE2))) },
		/* 51 */ { SingleStringStringNamedAnnotatedConstructor.class, TSTRING2,       TSTRING1_NSTRING2, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", is(STRING_VALUE2))) },
		// @formatter:on
		});
	}

	@Rule
	public LoggerRule rule = new LoggerRule(this);

	@Parameter(0)
	public Class<?> clazz;

	@Parameter(1)
	public Map<String, Object> parameters;

	@Parameter(2)
	public Map<Object, Object> containerServices;

	@Parameter(3)
	public Object result;

	@Test
	@SuppressWarnings("unchecked")
	public void evaluateTestCase() {
		// Given
		IContainer container = mockContainer();
		IInjector injector = new Injector(container);
		try {
			// When
			Object service = injector.make(clazz, parameters);
			// Then
			if (result instanceof Class) {
				fail("Expected [" + result + "], but was: [" + service + "]");
			}
			assertThat(service, (Matcher<? super Object>) result);
		} catch (Exception e) {
			// Then
			if (!(result instanceof Class)) {
				fail("Expected [" + result + "], but was: [" + e + "]");
			}
			assertThat(e, instanceOf((Class<?>) result));
		}
	}

	@SuppressWarnings("unchecked")
	private <T> IContainer mockContainer() {
		IContainer container = mock(IContainer.class);
		if (containerServices != null) {
			containerServices.forEach((k, v) -> {
				if (k instanceof Class<?>) {
					Class<T> clazz = (Class<T>) k;
					when(container.get(clazz)).thenReturn(clazz.cast(v));
					when(container.get(clazz.getName())).thenReturn(v);
				} else {
					when(container.get((String) k)).thenReturn(v);
				}
			});
		}
		return container;
	}

	public static class NoConstructor {
	}

	public static class SingleEmptyPublicConstructor {
		public SingleEmptyPublicConstructor() {
			super();
		}
	}

	public static class SingleEmptyProtectedConstructor {
		protected SingleEmptyProtectedConstructor() {
			super();
		}
	}

	public static class SingleEmptyPrivateConstructor {
		private SingleEmptyPrivateConstructor() {
			super();
		}
	}

	public static class SingleEmptyPublicAnnotatedConstructor {
		@Inject
		public SingleEmptyPublicAnnotatedConstructor() {
			super();
		}
	}

	public static class SingleEmptyProtectedAnnotatedConstructor {
		@Inject
		protected SingleEmptyProtectedAnnotatedConstructor() {
			super();
		}
	}

	public static class SingleEmptyPrivateAnnotatedConstructor {
		@Inject
		private SingleEmptyPrivateAnnotatedConstructor() {
			super();
		}
	}

	public static class SingleStringConstructor {
		String value;

		public SingleStringConstructor(String value) {
			super();
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	public static class SingleStringAnnotatedConstructor {
		String value;

		@Inject
		public SingleStringAnnotatedConstructor(String value) {
			super();
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	public static class SingleStringIntegerConstructor {
		String value;
		int intValue;

		public SingleStringIntegerConstructor(String value, int intValue) {
			super();
			this.intValue = intValue;
		}

		public String getValue() {
			return value;
		}

		public int getIntValue() {
			return intValue;
		}
	}

	public static class SingleStringIntegerAnnotatedConstructor {
		String value;
		int intValue;

		@Inject
		public SingleStringIntegerAnnotatedConstructor(String value, int intValue) {
			super();
			this.value = value;
			this.intValue = intValue;
		}

		public String getValue() {
			return value;
		}

		public int getIntValue() {
			return intValue;
		}
	}

	public static class SingleStringNamedConstructor {
		String value;

		public SingleStringNamedConstructor(@Named(STRING_NAMED) String value) {
			super();
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	public static class SingleStringNamedAnnotatedConstructor {
		String value;

		@Inject
		public SingleStringNamedAnnotatedConstructor(@Named(STRING_NAMED) String value) {
			super();
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	public static class SingleStringStringNamedAnnotatedConstructor {
		String value;
		String value2;

		@Inject
		public SingleStringStringNamedAnnotatedConstructor(@Named(STRING_NAMED) String value2, String value) {
			super();
			this.value = value;
			this.value2 = value2;
		}

		public String getValue() {
			return value;
		}

		public String getValue2() {
			return value2;
		}
	}
}
