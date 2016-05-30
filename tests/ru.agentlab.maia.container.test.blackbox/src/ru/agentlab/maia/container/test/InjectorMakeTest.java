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
import ru.agentlab.maia.container.Injector;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.test.util.LoggerRule;

/**
 * 
 * @see #testCases()
 * @see #evaluateTestCase()
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class InjectorMakeTest {

	private static final String STRING_VALUE = "Test";

	private static final String STRING_VALUE2 = "zxcqw-wer3#$%^&*e";

	private static final String STRING_NAMED = "STRING_NAMED";

	private static final int INT_VALUE = 12334;

	// @formatter:off
	private static final Map<Object, Object> STRING = ImmutableMap.of(
			String.class, STRING_VALUE,
			String.class.getName(), STRING_VALUE
		);
	private static final Map<Object, Object> INT = ImmutableMap.of(
			Integer.class, INT_VALUE, 
			Integer.class.getName(), INT_VALUE
		);
	private static final Map<Object, Object> STRING_INT = ImmutableMap.of(
			String.class, STRING_VALUE,
			String.class.getName(), STRING_VALUE, 
			Integer.class, INT_VALUE, 
			Integer.class.getName(), INT_VALUE
		);
	private static final Map<Object, Object> STRING2 = ImmutableMap.of(
			STRING_NAMED, STRING_VALUE2
		);
	private static final Map<Object, Object> STRING_STRING2 = ImmutableMap.of(
			String.class, STRING_VALUE,
			String.class.getName(), STRING_VALUE, 
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
		/*  0 */ { NoConstructor.class,                               null,           null,           notNullValue() },
		// Empty constructors
		/*  1 */ { SingleEmptyPublicConstructor.class,                null,           null,           notNullValue() },
		/*  2 */ { SingleEmptyProtectedConstructor.class,             null,           null,           notNullValue() },
		/*  3 */ { SingleEmptyPrivateConstructor.class,               null,           null,           notNullValue() },
		/*  4 */ { SingleEmptyPublicAnnotatedConstructor.class,       null,           null,           notNullValue() },
		/*  5 */ { SingleEmptyProtectedAnnotatedConstructor.class,    null,           null,           notNullValue() },
		/*  6 */ { SingleEmptyPrivateAnnotatedConstructor.class,      null,           null,           notNullValue() },
		// Constructor with 1 parameter
		/*  7 */ { SingleStringConstructor.class,                     null,           null,           InjectorException.class },
		/*  8 */ { SingleStringConstructor.class,                     STRING,         null,           InjectorException.class },
		/*  9 */ { SingleStringConstructor.class,                     null,           STRING,         InjectorException.class },
		/* 10 */ { SingleStringAnnotatedConstructor.class,            null,           null,           InjectorException.class },
		/* 11 */ { SingleStringAnnotatedConstructor.class,            STRING,         null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE))) },
		/* 12 */ { SingleStringAnnotatedConstructor.class,            null,           STRING,         allOf(notNullValue(), hasProperty("value", is(STRING_VALUE))) },
		// Constructor with 2 different parameters
		/* 13 */ { SingleStringIntegerConstructor.class,              null,           null,           InjectorException.class },
		/* 14 */ { SingleStringIntegerConstructor.class,              STRING,         null,           InjectorException.class },
		/* 15 */ { SingleStringIntegerConstructor.class,              null,           STRING,         InjectorException.class },
		/* 16 */ { SingleStringIntegerConstructor.class,              INT,            null,           InjectorException.class },
		/* 17 */ { SingleStringIntegerConstructor.class,              null,           INT,            InjectorException.class },
		/* 18 */ { SingleStringIntegerConstructor.class,              STRING_INT,     null,           InjectorException.class },
		/* 19 */ { SingleStringIntegerConstructor.class,              null,           STRING_INT,     InjectorException.class },
		/* 20 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           null,           InjectorException.class },
		/* 21 */ { SingleStringIntegerAnnotatedConstructor.class,     STRING,         null,           InjectorException.class },
		/* 22 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           STRING,         InjectorException.class },
		/* 23 */ { SingleStringIntegerAnnotatedConstructor.class,     INT,            null,           InjectorException.class },
		/* 24 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           INT,            InjectorException.class },
		/* 25 */ { SingleStringIntegerAnnotatedConstructor.class,     STRING_INT,     null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE)), hasProperty("intValue", is(INT_VALUE))) },
		/* 26 */ { SingleStringIntegerAnnotatedConstructor.class,     null,           STRING_INT,     allOf(notNullValue(), hasProperty("value", is(STRING_VALUE)), hasProperty("intValue", is(INT_VALUE))) },
		// Some of parameters are @Named
		/* 27 */ { SingleStringNamedConstructor.class,                null,           null,           InjectorException.class },
		/* 28 */ { SingleStringNamedConstructor.class,                STRING2,        null,           InjectorException.class },
		/* 29 */ { SingleStringNamedConstructor.class,                null,           STRING2,        InjectorException.class },
		/* 30 */ { SingleStringNamedAnnotatedConstructor.class,       null,           null,           InjectorException.class },
		/* 31 */ { SingleStringNamedAnnotatedConstructor.class,       STRING2,        null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		/* 32 */ { SingleStringNamedAnnotatedConstructor.class,       null,           STRING2,        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		/* 33 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           null,           InjectorException.class },
		/* 34 */ { SingleStringStringNamedAnnotatedConstructor.class, STRING,         null,           InjectorException.class },
		/* 35 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           STRING,         InjectorException.class },
		/* 36 */ { SingleStringStringNamedAnnotatedConstructor.class, STRING2,        null,           InjectorException.class },
		/* 37 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           STRING2,        InjectorException.class },
		/* 38 */ { SingleStringStringNamedAnnotatedConstructor.class, STRING_STRING2, null,           allOf(notNullValue(), hasProperty("value", is(STRING_VALUE)), hasProperty("value2", is(STRING_VALUE2))) },
		/* 39 */ { SingleStringStringNamedAnnotatedConstructor.class, null,           STRING_STRING2, allOf(notNullValue(), hasProperty("value", is(STRING_VALUE)), hasProperty("value2", is(STRING_VALUE2))) },
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
	public <T> IContainer mockContainer() {
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
