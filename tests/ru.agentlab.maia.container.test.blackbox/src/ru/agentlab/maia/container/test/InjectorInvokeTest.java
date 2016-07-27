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

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;
import java.util.stream.Stream;

import javax.inject.Named;

import org.hamcrest.Matcher;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

import com.google.common.collect.ImmutableMap;

import ru.agentlab.maia.container.IContainer;
import ru.agentlab.maia.container.IInjector;
import ru.agentlab.maia.container.InjectorException;
import ru.agentlab.maia.container.impl.Injector;
import ru.agentlab.maia.test.util.LoggerRule;

/**
 * 
 * @see #testCases()
 * @see #evaluateTestCase()
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@RunWith(Parameterized.class)
public class InjectorInvokeTest {

	private static final Class<NullPointerException> NPE = NullPointerException.class;
	private static final Class<InjectorException> EXCEPTION = InjectorException.class;

	private static final String STRING_VALUE1 = "Test";
	private static final String STRING_VALUE2 = "zxcqw-wer3#$%^&*e";
	private static final String STRING_NAMED = "STRING_NAMED";

	private static final int INT_VALUE1 = 12334;
	private static final int INT_VALUE2 = 12;

	private static final String EMPTY_PARAMETERS = "EMPTY_PARAMETERS";

	private static Method getMethod(String name) {
		return Stream.of(MethodsService.class.getDeclaredMethods()).filter(m -> m.getName().equals(name)).findFirst()
				.get();
	}

	// @formatter:off
	private static final Method PUBLIC_VOID_METHOD = getMethod("publicVoid");
	private static final Method PROTECTED_VOID_METHOD = getMethod("protectedVoid");
	private static final Method PRIVATE_VOID_METHOD = getMethod("privateVoid");
	
	private static final Method PUBLIC_VOID_STRING_METHOD = getMethod("publicVoidString");
	private static final Method PROTECTED_VOID_STRING_METHOD = getMethod("protectedVoidString");
	private static final Method PRIVATE_VOID_STRING_METHOD = getMethod("privateVoidString");
	
	private static final Method PUBLIC_RETURN_STRING_METHOD = getMethod("publicReturnString");
	private static final Method PROTECTED_RETURN_STRING_METHOD = getMethod("protectedReturnString");
	private static final Method PRIVATE_RETURN_STRING_METHOD = getMethod("privateReturnString");
	
	private static final Method STRING_NAMED_METHOD = getMethod("stringNamed");
	private static final Method STRING_INTEGER_METHOD = getMethod("stringInteger");
	private static final Method STRING_STRING_NAMED_METHOD = getMethod("stringStringNamed");
	// @formatter:on

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
		/* --------------------------------------------------------------------------------------------------------------------------------------------------
		 *|      | Inputs                                             | State         | Outputs                                                              |
		 *|  ##  |-------------------------------------------------------------------------------------------------------------------------------------------|
		 *|      | Method                             | Additional    | Container     | Result    | Service state                                            |
		 *--------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*  0 */ { null,                              null,           null,           NPE,                                allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		// Method without parameters at all	
		/*  1 */ { PUBLIC_VOID_METHOD,                null,           null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(EMPTY_PARAMETERS)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  2 */ { PROTECTED_VOID_METHOD,             null,           null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(EMPTY_PARAMETERS)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  3 */ { PRIVATE_VOID_METHOD,               null,           null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(EMPTY_PARAMETERS)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                                                                  
		// Method with 1 String parameter with different visibility	                                                      
		/*  4 */ { PUBLIC_VOID_STRING_METHOD,         TSTRING1,       null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  5 */ { PROTECTED_VOID_STRING_METHOD,      TSTRING1,       null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  6 */ { PRIVATE_VOID_STRING_METHOD,        TSTRING1,       null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                                                                  
		/*  7 */ { PUBLIC_VOID_STRING_METHOD,         null,           TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  8 */ { PROTECTED_VOID_STRING_METHOD,      null,           TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  9 */ { PRIVATE_VOID_STRING_METHOD,        null,           TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                                                                  
		/* 10 */ { PUBLIC_VOID_STRING_METHOD,         TSTRING2,       TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 11 */ { PROTECTED_VOID_STRING_METHOD,      TSTRING2,       TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 12 */ { PRIVATE_VOID_STRING_METHOD,        TSTRING2,       TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },

		/* 13 */ { PUBLIC_VOID_STRING_METHOD,         null,           null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 14 */ { PUBLIC_VOID_STRING_METHOD,         NSTRING1,       null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 15 */ { PUBLIC_VOID_STRING_METHOD,         null,           NSTRING1,       EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		
		// Method with 1 String parameter with different visibility and returning Object	
		/* 16 */ { PUBLIC_RETURN_STRING_METHOD,       TSTRING1,       null,           notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 17 */ { PROTECTED_RETURN_STRING_METHOD,    TSTRING1,       null,           notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 18 */ { PRIVATE_RETURN_STRING_METHOD,      TSTRING1,       null,           notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                              
		/* 19 */ { PUBLIC_RETURN_STRING_METHOD,       null,           TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 20 */ { PROTECTED_RETURN_STRING_METHOD,    null,           TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 21 */ { PRIVATE_RETURN_STRING_METHOD,      null,           TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                              
		/* 22 */ { PUBLIC_RETURN_STRING_METHOD,       TSTRING2,       TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 23 */ { PROTECTED_RETURN_STRING_METHOD,    TSTRING2,       TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 24 */ { PRIVATE_RETURN_STRING_METHOD,      TSTRING2,       TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		
		/* 25 */ { PUBLIC_RETURN_STRING_METHOD,       null,           null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 26 */ { PUBLIC_RETURN_STRING_METHOD,       NSTRING1,       null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 27 */ { PUBLIC_RETURN_STRING_METHOD,       null,           NSTRING1,       EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		
		// Method with 1 String parameter with @Named
		/* 28 */ { STRING_NAMED_METHOD,               NSTRING1,       null,           notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 29 */ { STRING_NAMED_METHOD,               null,           NSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 30 */ { STRING_NAMED_METHOD,               NSTRING2,       NSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		
		/* 31 */ { STRING_NAMED_METHOD,               null,           null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 32 */ { STRING_NAMED_METHOD,               TSTRING1,       null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 33 */ { STRING_NAMED_METHOD,               null,           TSTRING1,       EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },

		// Method with 2 parameters returning Object
		/* 34 */ { STRING_INTEGER_METHOD,             null,           null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 35 */ { STRING_INTEGER_METHOD,             TSTRING1,       null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 36 */ { STRING_INTEGER_METHOD,             null,           TSTRING1,       EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 37 */ { STRING_INTEGER_METHOD,             TINT1,          null,           EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 38 */ { STRING_INTEGER_METHOD,             null,           TINT1,          EXCEPTION,                          allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/* 39 */ { STRING_INTEGER_METHOD,             TINT1,          TSTRING1,       notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(INT_VALUE1))) },
		/* 40 */ { STRING_INTEGER_METHOD,             TSTRING1,       TINT1,          notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(INT_VALUE1))) },
		/* 41 */ { STRING_INTEGER_METHOD,             TSTRING1_TINT1, null,           notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(INT_VALUE1))) },
		/* 42 */ { STRING_INTEGER_METHOD,             null,           TSTRING2_TINT2, notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(INT_VALUE2))) },
		/* 43 */ { STRING_INTEGER_METHOD,             TSTRING2,       TSTRING1_TINT1, notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(INT_VALUE1))) },
		/* 44 */ { STRING_INTEGER_METHOD,             TINT2,          TSTRING1_TINT1, notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(INT_VALUE2))) },
		
		// If services have same types but one is @Named
		/* 45 */ { STRING_STRING_NAMED_METHOD,        TSTRING1_NSTRING2, null,        notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE2)), hasProperty("intValue", is(0))) },
		/* 46 */ { STRING_STRING_NAMED_METHOD,        null,        TSTRING1_NSTRING2, notNullValue(MethodsService.class), allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", is(STRING_VALUE2)), hasProperty("intValue", is(0))) },
		// @formatter:on
		});
	}

	@Rule
	public LoggerRule rule = new LoggerRule(this);

	@Parameter(0)
	public Method method;

	@Parameter(1)
	public Map<String, Object> parameters;

	@Parameter(2)
	public Map<Object, Object> containerServices;

	@Parameter(3)
	public Object resultMatcher;

	@Parameter(4)
	public Matcher<? super Object> serviceMatcher;

	@Test
	@SuppressWarnings("unchecked")
	public void evaluateTestCase() {
		// Given
		Object service = new MethodsService();
		IContainer container = mockContainer();
		IInjector injector = new Injector(container);
		try {
			// When
			Object result = injector.invoke(service, method, parameters);
			// Then
			if (resultMatcher instanceof Class) {
				fail("Expected return: [" + resultMatcher + "] and service: [" + serviceMatcher + "], but was: ["
						+ result + "] and: [" + service + "]");
			}
			assertThat(service, serviceMatcher);
			assertThat(result, (Matcher<? super Object>) resultMatcher);
		} catch (Exception e) {
			// Then
			if (!(resultMatcher instanceof Class)) {
				fail("Expected [" + resultMatcher + "], but was: [" + e + "]");
			}
			assertThat(e, instanceOf((Class<?>) resultMatcher));
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

	public static class MethodsService {

		String value;

		String value2;

		int intValue;

		public void publicVoid() {
			this.value = EMPTY_PARAMETERS;
		}

		protected void protectedVoid() {
			this.value = EMPTY_PARAMETERS;
		}

		@SuppressWarnings("unused")
		private void privateVoid() {
			this.value = EMPTY_PARAMETERS;
		}

		public void publicVoidString(String value) {
			this.value = value;
		}

		protected void protectedVoidString(String value) {
			this.value = value;
		}

		@SuppressWarnings("unused")
		private void privateVoidString(String value) {
			this.value = value;
		}

		public Object publicReturnString(String value) {
			this.value = value;
			return this;
		}

		protected Object protectedReturnString(String value) {
			this.value = value;
			return this;
		}

		@SuppressWarnings("unused")
		private Object privateReturnString(String value) {
			this.value = value;
			return this;
		}

		public Object stringNamed(@Named(STRING_NAMED) String value) {
			this.value = value;
			return this;
		}

		public Object stringInteger(String value, int intValue) {
			this.value = value;
			this.intValue = intValue;
			return this;
		}

		public Object stringStringNamed(String value, @Named(STRING_NAMED) String value2) {
			this.value = value;
			this.value2 = value2;
			return this;
		}

		public String getValue() {
			return value;
		}

		public String getValue2() {
			return value2;
		}

		public int getIntValue() {
			return intValue;
		}

	}

}
