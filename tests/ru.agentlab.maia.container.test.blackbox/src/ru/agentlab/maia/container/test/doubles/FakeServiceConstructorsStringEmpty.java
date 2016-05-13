package ru.agentlab.maia.container.test.doubles;

import javax.inject.Inject;

public class FakeServiceConstructorsStringEmpty {
	
	String s;

	public FakeServiceConstructorsStringEmpty() {
		super();
	}

	@Inject
	public FakeServiceConstructorsStringEmpty(String s) {
		super();
		this.s = s;
	}

}
