package ru.agentlab.maia.agent;

import java.util.stream.Stream;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import ru.agentlab.maia.IRole;
import ru.agentlab.maia.agent.RoleBase;
import ru.agentlab.maia.tests.util.category.speed.QuickTests;
import ru.agentlab.maia.tests.util.category.type.UnitTests;
import ru.agentlab.maia.tests.util.category.visibility.WhiteBoxTests;

/**
 * Tests for {@link RoleBase#removeAll(java.util.stream.Stream)}
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
@Category({ UnitTests.class, QuickTests.class, WhiteBoxTests.class })
public class RoleBase_removeAllStream_NegativeUnitTests extends RoleBaseAbstractTest {

	@Test
	public void nullCollection_whenHave0Roles() {
		// Given
		thrown.expect(NullPointerException.class);
		thrown.expectMessage("Roles to remove should be non null");
		// When
		roleBase.removeAll((Stream<IRole>) null);
	}

}
