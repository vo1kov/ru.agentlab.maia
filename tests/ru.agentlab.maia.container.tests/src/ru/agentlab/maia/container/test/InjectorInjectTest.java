package ru.agentlab.maia.container.test;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.instanceOf;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.hamcrest.Matchers.nullValue;
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
public class InjectorInjectTest {

	private static final Class<NullPointerException> NPE = NullPointerException.class;
	private static final Class<InjectorException> EXCEPTION = InjectorException.class;

	private static final String STRING_VALUE1 = "Test";
	private static final String STRING_VALUE2 = "zxcqw-wer3#$%^&*e";
	private static final String STRING_NAMED = "STRING_NAMED";

	private static final int INT_VALUE1 = 12334;
	private static final int INT_VALUE2 = 12;

	private static final NoFields NO_FIELDS = new NoFields();
	private static final StringField STRING_FIELD = new StringField();
	private static final StringNamedField STRING_NAMED_FIELD = new StringNamedField();
	private static final StringNamedInjectField STRING_NAMED_INJECT_FIELD = new StringNamedInjectField();
	private static final StringInjectField STRING_INJECT_FIELD = new StringInjectField();
	private static final StringIntegerFields STRING_INTEGER_FIELDS = new StringIntegerFields();
	private static final StringIntegerInjectFields STRING_INTEGER_INJECT_FIELDS = new StringIntegerInjectFields();
	private static final StringStringNamedInjectFields STRING_STRING_NAMED_INJECT_FIELDS = new StringStringNamedInjectFields();

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
		/* -------------------------------------------------------------------------------------------------------------------------------------------------
		 *|      | Inputs                                             | State         | Outputs                                                             |
		 *|  ##  |------------------------------------------------------------------------------------------------------------------------------------------|
		 *|      | Class                              | Additional    | Container     | Result   | Service state                                            |
		 *-------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*  0 */ { null,                              null,           null,           NPE,       notNullValue() },
		// Service without fields at all	
		/*  1 */ { NO_FIELDS,                         null,           null,           null,      notNullValue() },
		
		// Service with 1 field
		// If no @Inject annotation should be silent and service don't changes
		/*  2 */ { STRING_FIELD,                      null,           null,           null,      allOf(notNullValue(), hasProperty("value", nullValue())) },
		/*  3 */ { STRING_FIELD,                      TSTRING1,       null,           null,      allOf(notNullValue(), hasProperty("value", nullValue())) },
		/*  4 */ { STRING_FIELD,                      null,           TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", nullValue())) },
		// If no @Inject annotation but have @Named should be silent and service don't changes
		/*  5 */ { STRING_NAMED_FIELD,                null,           null,           null,      allOf(notNullValue(), hasProperty("value", nullValue())) },
		/*  6 */ { STRING_NAMED_FIELD,                TSTRING1,       null,           null,      allOf(notNullValue(), hasProperty("value", nullValue())) },
		/*  7 */ { STRING_NAMED_FIELD,                null,           TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", nullValue())) },
		// If not enough dependencies then throw and service don't changes
		/*  8 */ { STRING_INJECT_FIELD,               null,           null,           EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue())) },
		// If dependency in additional or in context then get it
		/*  9 */ { STRING_INJECT_FIELD,               TSTRING1,       null,           null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		/* 10 */ { STRING_INJECT_FIELD,               null,           TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		// If dependency in additional then get from it, not from context
		/* 11 */ { STRING_INJECT_FIELD,               TSTRING1,       TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		/* 12 */ { STRING_INJECT_FIELD,               TSTRING2,       TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		// If @Inject @Named, but service registered by type-key, not named-key then throw and service don't changes 
		/* 13 */ { STRING_NAMED_INJECT_FIELD,         TSTRING1,       null,           EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue())) },
		/* 14 */ { STRING_NAMED_INJECT_FIELD,         null,           TSTRING1,       EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue())) },
		/* 15 */ { STRING_NAMED_INJECT_FIELD,         TSTRING1,       TSTRING1,       EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue())) },
		// If @Inject @Named, and service registered by named-key 
		/* 16 */ { STRING_NAMED_INJECT_FIELD,         NSTRING2,       null,           null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		/* 17 */ { STRING_NAMED_INJECT_FIELD,         null,           NSTRING2,       null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2))) },
		/* 18 */ { STRING_NAMED_INJECT_FIELD,         NSTRING1,       NSTRING2,       null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1))) },
		
		// Service with more fields
		// If no @Inject annotation should be silent and service don't changes
		/* 19 */ { STRING_INTEGER_FIELDS,             null,           null,           null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 20 */ { STRING_INTEGER_FIELDS,             TSTRING1,       null,           null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 21 */ { STRING_INTEGER_FIELDS,             null,           TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 22 */ { STRING_INTEGER_FIELDS,             TINT1,          null,           null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 23 */ { STRING_INTEGER_FIELDS,             null,           TINT1,          null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 24 */ { STRING_INTEGER_FIELDS,             TSTRING1_TINT1, null,           null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 25 */ { STRING_INTEGER_FIELDS,             null,           TSTRING1_TINT1, null,      allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		// If not enough dependencies then throw and service don't changes
		/* 26 */ { STRING_INTEGER_INJECT_FIELDS,      null,           null,           EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 27 */ { STRING_INTEGER_INJECT_FIELDS,      TSTRING1,       null,           EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 28 */ { STRING_INTEGER_INJECT_FIELDS,      null,           TSTRING1,       EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 29 */ { STRING_INTEGER_INJECT_FIELDS,      TINT1,          null,           EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		/* 30 */ { STRING_INTEGER_INJECT_FIELDS,      null,           TINT1,          EXCEPTION, allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("intValue", is(0))) },
		// If dependency in additional or in context then get it
		/* 31 */ { STRING_INTEGER_INJECT_FIELDS,      TSTRING1,       TINT1,          null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 32 */ { STRING_INTEGER_INJECT_FIELDS,      TINT1,          TSTRING1,       null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 33 */ { STRING_INTEGER_INJECT_FIELDS,      TSTRING1_TINT1, null,           null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 34 */ { STRING_INTEGER_INJECT_FIELDS,      null,           TSTRING1_TINT1, null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		// If dependency in additional then get from it, not from context
		/* 35 */ { STRING_INTEGER_INJECT_FIELDS,      TSTRING1_TINT1, TSTRING1_TINT1, null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 36 */ { STRING_INTEGER_INJECT_FIELDS,      TSTRING2_TINT2, TSTRING1_TINT1, null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("intValue", is(INT_VALUE2))) },
		/* 37 */ { STRING_INTEGER_INJECT_FIELDS,      TSTRING2,       TSTRING1_TINT1, null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("intValue", is(INT_VALUE1))) },
		/* 38 */ { STRING_INTEGER_INJECT_FIELDS,      TINT2,          TSTRING1_TINT1, null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("intValue", is(INT_VALUE2))) },
		// If services have same type but one is @Named
		/* 39 */ { STRING_STRING_NAMED_INJECT_FIELDS, TSTRING1_NSTRING2, null,        null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE2))) },
		/* 40 */ { STRING_STRING_NAMED_INJECT_FIELDS, null,        TSTRING1_NSTRING2, null,      allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE2))) },
		// @formatter:on
		});
	}

	@Rule
	public LoggerRule rule = new LoggerRule(this);

	@Parameter(0)
	public Object service;

	@Parameter(1)
	public Map<String, Object> parameters;

	@Parameter(2)
	public Map<Object, Object> containerServices;

	@Parameter(3)
	public Class<? extends Exception> result;

	@Parameter(4)
	public Matcher<? super Object> serviceMatcher;

	@Test
	public void evaluateTestCase() {
		// Given
		IContainer container = mockContainer();
		IInjector injector = new Injector(container);
		try {
			// When
			injector.inject(service, parameters);
			// Then
			if (result != null) {
				fail("Expected [" + result + "], but was: [" + service + "]");
			}
			assertThat(service, serviceMatcher);
		} catch (Exception e) {
			// Then
			if (result == null) {
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

	public static class NoFields {
	}

	public static class StringField {

		String value;

		public String getValue() {
			return value;
		}
	}

	public static class StringInjectField {

		@Inject
		String value;

		public String getValue() {
			return value;
		}

	}

	public static class StringIntegerFields {

		String value;

		int intValue;

		public String getValue() {
			return value;
		}

		public int getIntValue() {
			return intValue;
		}
	}

	public static class StringIntegerInjectFields {

		@Inject
		String value;

		@Inject
		int intValue;

		public String getValue() {
			return value;
		}

		public int getIntValue() {
			return intValue;
		}

	}

	public static class StringNamedField {

		@Named(STRING_NAMED)
		String value;

		public String getValue() {
			return value;
		}
	}

	public static class StringNamedInjectField {

		@Inject
		@Named(STRING_NAMED)
		String value;

		public String getValue() {
			return value;
		}

	}

	public static class StringStringNamedInjectFields {

		@Inject
		String value;

		@Inject
		@Named(STRING_NAMED)
		String value2;

		public String getValue() {
			return value;
		}

		public String getValue2() {
			return value2;
		}
	}
}
