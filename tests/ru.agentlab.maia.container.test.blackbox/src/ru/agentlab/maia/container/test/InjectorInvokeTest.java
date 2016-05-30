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
public class InjectorInvokeTest {

	private static final Class<InjectorException> EXCEPTION = InjectorException.class;

	private static final String STRING_VALUE1 = "Test";
	private static final String STRING_VALUE2 = "zxcqw-wer3#$%^&*e";
	private static final String STRING_NAMED = "STRING_NAMED";

	private static final int INT_VALUE1 = 12334;
	private static final int INT_VALUE2 = 12;

	// @formatter:off
	private static final Method PUBLIC_VOID_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("publicVoid")).findFirst().get();
	private static final Method PROTECTED_VOID_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("protectedVoid")).findFirst().get();
	private static final Method PRIVATE_VOID_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("privateVoid")).findFirst().get();
	
	private static final Method PUBLIC_VOID_STRING_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("publicVoidString")).findFirst().get();
	private static final Method PROTECTED_VOID_STRING_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("protectedVoidString")).findFirst().get();
	private static final Method PRIVATE_VOID_STRING_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("privateVoidString")).findFirst().get();
	
	private static final Method PUBLIC_RETURN_STRING_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("publicReturnString")).findFirst().get();
	private static final Method PROTECTED_RETURN_STRING_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("protectedReturnString")).findFirst().get();
	private static final Method PRIVATE_RETURN_STRING_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("privateReturnString")).findFirst().get();
	
	private static final Method STRING_NAMED_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("stringNamed")).findFirst().get();
	private static final Method STRING_INTEGER_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("stringInteger")).findFirst().get();
	private static final Method STRING_STRING_NAMED_METHOD = Stream.of(MethodsService.class.getDeclaredMethods()).filter(m->m.getName().equals("stringStringNamed")).findFirst().get();
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
		// Method without parameters at all	
		/*  0 */ { PUBLIC_VOID_METHOD,                null,           null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_VOID_METHOD,             null,           null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_VOID_METHOD,               null,           null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", nullValue()), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                                                                  
		// Method with 1 String parameter with different visibility	                                                      
		/*  0 */ { PUBLIC_VOID_STRING_METHOD,         TSTRING1,       null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_VOID_STRING_METHOD,      TSTRING1,       null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_VOID_STRING_METHOD,        TSTRING1,       null,           nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                                                                  
		/*  0 */ { PUBLIC_VOID_STRING_METHOD,         null,           TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_VOID_STRING_METHOD,      null,           TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_VOID_STRING_METHOD,        null,           TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                                                                  
		/*  0 */ { PUBLIC_VOID_STRING_METHOD,         TSTRING2,       TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_VOID_STRING_METHOD,      TSTRING2,       TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_VOID_STRING_METHOD,        TSTRING2,       TSTRING1,       nullValue(),                        allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },

		// Method with 1 String parameter with different visibility and returning Object	
		/*  0 */ { PUBLIC_RETURN_STRING_METHOD,       TSTRING1,       null,           notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_RETURN_STRING_METHOD,    TSTRING1,       null,           notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_RETURN_STRING_METHOD,      TSTRING1,       null,           notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                              
		/*  0 */ { PUBLIC_RETURN_STRING_METHOD,       null,           TSTRING1,       notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_RETURN_STRING_METHOD,    null,           TSTRING1,       notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_RETURN_STRING_METHOD,      null,           TSTRING1,       notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE1)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		                                                                              
		/*  0 */ { PUBLIC_RETURN_STRING_METHOD,       TSTRING2,       TSTRING1,       notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PROTECTED_RETURN_STRING_METHOD,    TSTRING2,       TSTRING1,       notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },
		/*  0 */ { PRIVATE_RETURN_STRING_METHOD,      TSTRING2,       TSTRING1,       notNullValue(MethodsService.class),  allOf(notNullValue(), hasProperty("value", is(STRING_VALUE2)), hasProperty("value2", nullValue()), hasProperty("intValue", is(0))) },

		// Method with 1 String parameter with @Named	
		
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
			Object invokeResult = injector.invoke(service, method);
			// Then
			if (resultMatcher != null) {
				fail("Expected [" + resultMatcher + "], but was: [" + service + "]");
			}
			assertThat(service, serviceMatcher);
			assertThat(invokeResult, (Matcher<? super Object>) resultMatcher);
		} catch (Exception e) {
			// Then
			if (resultMatcher == null) {
				fail("Expected [" + resultMatcher + "], but was: [" + e + "]");
			}
			assertThat(e, instanceOf((Class<?>) resultMatcher));
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

	public static class MethodsService {

		String value;

		String value2;

		int intValue;

		public void publicVoid() {
			this.value = "EMPTY_PARAMETERS";
		}

		protected void protectedVoid() {
			this.value = "EMPTY_PARAMETERS";
		}

		@SuppressWarnings("unused")
		private void privateVoid() {
			this.value = "EMPTY_PARAMETERS";
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
