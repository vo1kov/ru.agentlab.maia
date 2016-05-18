package ru.agentlab.maia.container.test.doubles;

import javax.inject.Inject;

public class FakeServiceConstructorsMany {

	public String stringValue;

	public Integer intValue;

	@Inject
	public FakeServiceConstructorsMany(String s) {
		this.stringValue = s;
	}

	@Inject
	public FakeServiceConstructorsMany(Integer i, String s) {
		this.stringValue = s;
		this.intValue = i;
	}
}
