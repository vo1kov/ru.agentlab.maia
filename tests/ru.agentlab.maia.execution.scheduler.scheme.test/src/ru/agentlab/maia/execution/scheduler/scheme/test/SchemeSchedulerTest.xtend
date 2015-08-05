package ru.agentlab.maia.execution.scheduler.scheme.test

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.scheduler.scheme.IMaiaExecutorSchedulerScheme
import ru.agentlab.maia.execution.scheduler.scheme.SchemeScheduler
import ru.agentlab.maia.execution.IMaiaExecutorAction

@RunWith(MockitoJUnitRunner)
class SchemeSchedulerTest {

	@Mock
	IMaiaContext context

	@Mock
	IMaiaExecutorSchedulerScheme scheme

	@Mock
	IMaiaExecutorAction action1

	@Mock
	IMaiaExecutorAction action2

	SchemeScheduler scheduler = new SchemeScheduler(context, scheme)

	@Test
	def void test() {
		scheduler => [
			add(action1)
			add(action2)
			println(nextContext)
			println(nextContext)
			println(nextContext)
			println(nextContext)
			println(nextContext)
			println(nextContext)
		]
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