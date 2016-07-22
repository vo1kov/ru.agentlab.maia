package ru.agentlab.maia.agent.belief.annotation.converter;

public abstract class AssertionFormatException extends AnnotationFormatException {

	private static final long serialVersionUID = 1L;

	public AssertionFormatException() {
		super();
	}

	public AssertionFormatException(String message, Throwable cause) {
		super(message, cause);
	}

	public AssertionFormatException(String message) {
		super(message);
	}

	public AssertionFormatException(Throwable cause) {
		super(cause);
	}

}
