package ru.agentlab.maia.execution.scheduler.scheme.test

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.pattern.impl.PatternScheduler
import ru.agentlab.maia.execution.scheduler.pattern.impl.PatternScheme
import ru.agentlab.maia.execution.tree.IExecutionAction
import ru.agentlab.maia.memory.IMaiaContext

@RunWith(MockitoJUnitRunner)
class SchemeSchedulerTests {

	@Mock
	IMaiaContext context

	@Mock
	PatternScheme scheme

	@Mock
	IExecutionAction action1

	@Mock
	IExecutionAction action2

	PatternScheduler scheduler = new PatternScheduler(context, scheme)

	@Test
	def void test() {
//		scheduler => [
//			add(action1)
//			add(action2)
//			println(nextNode)
//			println(nextNode)
//			println(nextNode)
//			println(nextNode)
//			println(nextNode)
//			println(nextNode)
//		]
//		val rootContextRef = Activator.context.getServiceReference(IMaiaContext)
//		val rootContext = Activator.context.getService(rootContextRef)
//		scheduler.add(firstChildContext)
//		scheduler.add(secondChildContext)
////		when(scheduler.c).thenReturn(cList)
//		assertEquals(firstChildContext, scheduler.currentContext)
//		assertEquals(secondChildContext, scheduler.nextContext)
//		assertEquals(firstChildContext, scheduler.nextContext)
//		assertEquals(secondChildContext, scheduler.nextContext)
//		assertEquals(firstChildContext, scheduler.nextContext)
//		val cList = new ArrayList<IMaiaContext> => [
//			add(firstChildContext)
//			add(secondChildContext)
//		]
//
//		val list = mock(List)
//		list.add("2")
//		println(list.get(0))
//		when(rootContext.childs).thenReturn(cList)
//		assertEquals(cList, rootContext.childs)
//
////		when(childList.get(0)).thenReturn(firstChildContext)
////		when(childList.get(1)).thenReturn(secondChildContext)
//		println(rootContext.childs)
////		assertEquals(firstChildContext, childList.get(0))
//		assertEquals(firstChildContext, rootContext.childs.get(0))
//
//		rootContext.dump
//		verify(rootContext).dump
//		assertEquals(firstChildContext, rootContext.childs.get(0))
	}

}