package ru.agentlab.maia.agent;

import static org.mockito.Mockito.mock;

import java.util.Map;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#create(Object, java.util.Map)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_createObjectMap_Negative2UnitTests extends RoleBaseAbstractTest {

	{
		thrown.expect(IllegalArgumentException.class);
		thrown.expectMessage("Role class to create should be non primitive type");
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> extra = mock(Map.class);

	@Test
	public void byteService() {
		roleBase.create((byte) 1, extra);
	}

	@Test
	public void shortService() {
		roleBase.create((short) 2, extra);
	}

	@Test
	public void intService() {
		roleBase.create((int) 3, extra);
	}

	@Test
	public void longService() {
		roleBase.create((long) 4L, extra);
	}

	@Test
	public void floatService() {
		roleBase.create((float) 5.6F, extra);
	}

	@Test
	public void doubleService() {
		roleBase.create((double) 7D, extra);
	}

	@Test
	public void booleanService() {
		roleBase.create(true, extra);
	}

	@Test
	public void charService() {
		roleBase.create('w', extra);
	}

}
