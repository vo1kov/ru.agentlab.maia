package ru.agentlab.maia.execution.scheduler.scheme.test

import ru.agentlab.maia.context.IMaiaContext

class TestContext implements IMaiaContext {
	
	override getParent() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getChilds() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override get(String name) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override <T> get(Class<T> clazz) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getLocal(String name) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override <T> getLocal(Class<T> clazz) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override remove(String name) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override remove(Class<?> clazz) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override set(String name, Object value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override <T> set(Class<T> clazz, T value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override dump() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}