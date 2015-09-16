package ru.agentlab.maia.memory.injector.test.unit.doubles

import javax.inject.Inject

class FakeService_fieldsWithDifferentVisibility {

	@Inject
	public DummyObject publicReference

	@Inject
	protected DummyObject protectedReference

	@Inject
	package DummyObject packageReference

	@Inject
	private DummyObject privateReference

	def public static getExpectedKeys() {
		return #[
			DummyObject,
			DummyObject,
			DummyObject,
			DummyObject
		].toArray
	}

}