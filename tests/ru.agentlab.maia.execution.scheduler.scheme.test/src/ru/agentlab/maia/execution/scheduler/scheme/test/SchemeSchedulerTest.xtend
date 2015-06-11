package ru.agentlab.maia.execution.scheduler.scheme.test

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.scheme.SchemeScheduler

import static org.junit.Assert.*
import ru.agentlab.maia.context.injector.e4.E4MaiaContext

@RunWith(MockitoJUnitRunner)
class SchemeSchedulerTest {

//	@Mock
//	IMaiaContext rootContext
	@Mock
	IMaiaContextAction firstChildContext

	@Mock
	IMaiaContextAction secondChildContext

	SchemeScheduler scheduler = new SchemeScheduler
	
	val c = new E4MaiaContext

	@Test
	def void test() {
		val rootContextRef = Activator.context.getServiceReference(IMaiaContext)
		val rootContext = Activator.context.getService(rootContextRef)
		scheduler.add(firstChildContext)
		scheduler.add(secondChildContext)
//		when(scheduler.c).thenReturn(cList)
		assertEquals(firstChildContext, scheduler.currentContext)
		assertEquals(secondChildContext, scheduler.nextContext)
		assertEquals(firstChildContext, scheduler.nextContext)
		assertEquals(secondChildContext, scheduler.nextContext)
		assertEquals(firstChildContext, scheduler.nextContext)

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