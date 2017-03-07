package ru.agentlab.maia.context.hashmap.test.performance

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.IContainer
import ru.agentlab.maia.container.hashmap.HashMapContext
import ru.agentlab.maia.context.test.performance.AbstractContextSetPerformanceTests

import static org.mockito.Mockito.*

class HashMapContextSetPerformanceTests extends AbstractContextSetPerformanceTests {

	@Accessors
	IContainer context = spy(new HashMapContext)

}
