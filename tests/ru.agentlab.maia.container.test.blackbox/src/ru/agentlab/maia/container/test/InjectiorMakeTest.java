package ru.agentlab.maia.container.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.UUID;

import org.junit.Before;
import org.junit.Test;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.container.Injector;
import ru.agentlab.maia.container.test.doubles.FakeServiceConstructorsCase7;
import ru.agentlab.maia.container.test.doubles.FakeServiceConstructorsEmptyPrivate;
import ru.agentlab.maia.container.test.doubles.FakeServiceConstructorsEmptyProtected;
import ru.agentlab.maia.container.test.doubles.FakeServiceConstructorsEmptyPublic;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ServiceNotFound;

/**
 * <p>
 * Test cases:
 * 
 * <pre>
 * ┌────┬────────────────────────────┬───────────────────────────────────────┬────────────────────┐
 * │ ## │                  container │                constructor signatures │             result │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  0 │                            │                              public() │            created │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  1 │                            │                           protected() │            created │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  2 │                            │                             private() │            created │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  3 │                            │                              public() │            created │
 * │    │                            │              @Inject public(String s) │          s == null │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  4 │                            │              @Inject public(String s) │    ServiceNotFound │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  5 │                            │                   public(int, String) │  InjectorException │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  6 │       String.class: "TEST" │                   public(int, String) │  InjectorException │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  7 │       String.class: "TEST" │              @Inject public(String s) │            created │
 * │    │                            │                                       │        s == "TEST" │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  8 │ "java.lang.String": "TEST" │              @Inject public(String s) │            created │
 * │    │                            │                                       │        s == "TEST" │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │  9 │                 "number":9 │                 @Inject public(int i) │            created │
 * │    │                            │ @Inject public(@Named("number")int i) │             i == 9 │
 * ├────┼────────────────────────────┼───────────────────────────────────────┼────────────────────┤
 * │ 10 │       String.class: "TEST" │                              public() │            created │
 * │    │                            │              @Inject public(String s) │        s == "TEST" │
 * │    │                            │       @Inject public(String s, int i) │                    │
 * └────┴────────────────────────────┴───────────────────────────────────────┴────────────────────┘
 * </pre>
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class InjectiorMakeTest {

	protected IContainer container;

	protected IInjector injector;

	@Before
	public void before() throws ServiceNotFound {
		// Given
		container = mock(IContainer.class);
		injector = new Injector(container);
	}

	@Test
	public void testCase0() throws InjectorException, ContainerException {
		// When
		Object service = injector.make(FakeServiceConstructorsEmptyPublic.class);
		// Then
		assertNotNull(service);
	}

	@Test
	public void testCase1() throws InjectorException, ContainerException {
		// When
		Object service = injector.make(FakeServiceConstructorsEmptyProtected.class);
		// Then
		assertNotNull(service);
	}

	@Test
	public void testCase2() throws InjectorException, ContainerException {
		// When
		Object service = injector.make(FakeServiceConstructorsEmptyPrivate.class);
		// Then
		assertNotNull(service);
	}

	@Test
	public void testCase7() throws InjectorException, ContainerException {
		// Given
		String value = UUID.randomUUID().toString();
		when(container.get(String.class)).thenReturn(value);
		container = mock(IContainer.class);
		// When
		FakeServiceConstructorsCase7 service = injector.make(FakeServiceConstructorsCase7.class);
		// Then
		assertNotNull(service);
		assertEquals(value, service.s);
	}

}
