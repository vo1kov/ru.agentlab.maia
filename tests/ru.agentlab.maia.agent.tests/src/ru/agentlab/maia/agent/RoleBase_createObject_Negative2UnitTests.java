package ru.agentlab.maia.agent;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Object)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createObject_Negative2UnitTests extends RoleBaseAbstractTest {

	{
		thrown.expect(IllegalArgumentException.class);
		thrown.expectMessage("Role class to create should be non primitive type");
	}

	@Test
	public void byteService() {
		roleBase.create((byte) 1);
	}

	@Test
	public void shortService() {
		roleBase.create((short) 2);
	}

	@Test
	public void intService() {
		roleBase.create((int) 3);
	}

	@Test
	public void longService() {
		roleBase.create((long) 4L);
	}

	@Test
	public void floatService() {
		roleBase.create((float) 5.6F);
	}

	@Test
	public void doubleService() {
		roleBase.create((double) 7D);
	}

	@Test
	public void booleanService() {
		roleBase.create(true);
	}

	@Test
	public void charService() {
		roleBase.create('w');
	}

}
