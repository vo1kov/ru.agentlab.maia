package ru.agentlab.maia.container.impl.test.smoke;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

import org.junit.Test;

import ru.agentlab.maia.container.impl.ContainerWithHierarchy;
import ru.agentlab.maia.container.impl.test.doubles.A;
import ru.agentlab.maia.container.impl.test.doubles.B;
import ru.agentlab.maia.container.impl.test.doubles.Int;

public class ContainerWithHierarchySmokeTest {

	ContainerWithHierarchy container = new ContainerWithHierarchy();

	@Test
	public void testInheritance() {
		// Given
		B b = new B();
		// When
		container.put(b);
		// Then
		assertThat(container.getLocal(A.class), equalTo(b));
		assertThat(container.getLocal(Int.class), equalTo(b));
		assertThat(container.getLocal(B.class), equalTo(b));
	}

	@Test
	public void testInheritance2() {
		// Given
		A a = new A();
		B b = new B();
		// When
		container.put(a);
		container.put(b);
		// Then
		assertThat(container.getLocal(Int.class), equalTo(a));
		// When
		container.remove(a);
		// Then
		assertThat(container.getLocal(Int.class), equalTo(b));
	}

	@Test
	public void testObjectClass() {
		// Given
		A a = new A();
		B b = new B();
		// When
		container.put(a);
		container.put(b);
		container.put(Object.class, a);
		container.put(Object.class, b);
		// Then
		assertThat(container.getLocal(Object.class), equalTo(b));
		// When
		container.remove(b);
		// Then
		assertThat(container.getLocal(Object.class), equalTo(a));
		// When
		container.remove(a);
		// Then
		assertThat(container.getLocal(Object.class), equalTo(null));

	}
}
