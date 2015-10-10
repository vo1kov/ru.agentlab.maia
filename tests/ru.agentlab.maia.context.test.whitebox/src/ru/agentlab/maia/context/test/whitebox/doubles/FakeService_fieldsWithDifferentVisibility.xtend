package ru.agentlab.maia.context.test.whitebox.doubles

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

	def public static getFakeValues() {
		return #[
			new DummyObject,
			new DummyObject,
			new DummyObject,
			new DummyObject
		].toArray
	}

}