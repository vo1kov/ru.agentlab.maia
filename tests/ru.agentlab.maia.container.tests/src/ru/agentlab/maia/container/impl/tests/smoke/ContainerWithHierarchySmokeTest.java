package ru.agentlab.maia.container.impl.tests.smoke;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.container.ContainerWithHierarchy;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;

@Category({ UnitTests.class, QuickTests.class })
public class ContainerWithHierarchySmokeTest {

	public class ParentClass implements ParentInterface {
	}

	public class ChildClass extends ParentClass {
	}

	public interface ParentInterface {
	}

	ContainerWithHierarchy container = new ContainerWithHierarchy();

	@Test
	public void testInheritance() {
		// Given
		ChildClass childClass = new ChildClass();
		// When
		container.put(childClass);
		// Then
		assertThat(container.getLocal(ParentClass.class), equalTo(childClass));
		assertThat(container.getLocal(ParentInterface.class), equalTo(childClass));
		assertThat(container.getLocal(ChildClass.class), equalTo(childClass));
	}

	@Test
	public void testInheritance2() {
		// Given
		ParentClass parentClass = new ParentClass();
		ChildClass childClass = new ChildClass();
		// When
		container.put(parentClass);
		container.put(childClass);
		// Then
		assertThat(container.getLocal(ParentInterface.class), equalTo(parentClass));
		// When
		container.remove(parentClass);
		// Then
		assertThat(container.getLocal(ParentInterface.class), equalTo(childClass));
	}

	@Test
	public void testObjectClass() {
		// Given
		ParentClass parentClass = new ParentClass();
		ChildClass childClass = new ChildClass();
		// When
		container.put(parentClass);
		container.put(childClass);
		container.put(Object.class, parentClass);
		container.put(Object.class, childClass);
		// Then
		assertThat(container.getLocal(Object.class), equalTo(childClass));
		// When
		container.remove(childClass);
		// Then
		assertThat(container.getLocal(Object.class), equalTo(parentClass));
		// When
		container.remove(parentClass);
		// Then
		assertThat(container.getLocal(Object.class), equalTo(null));

	}
}
