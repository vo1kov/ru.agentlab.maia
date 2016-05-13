package ru.agentlab.maia.container.test.doubles;

import javax.inject.Inject;

public class FakeServiceConstructorsCase7 {

	public String s;

	@Inject
	public FakeServiceConstructorsCase7(String s) {
		this.s = s;
	}

}
