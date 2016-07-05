package ru.agentlab.maia.agent.converter;

import ru.agentlab.maia.role.converter.AnnotationFormatException;

public class MethodWrongFormatException extends AnnotationFormatException {

	private static final long serialVersionUID = 1L;

	public MethodWrongFormatException() {
		super();
	}

	public MethodWrongFormatException(String message, Throwable cause) {
		super(message, cause);
	}

	public MethodWrongFormatException(String message) {
		super(message);
	}

	public MethodWrongFormatException(Throwable cause) {
		super(cause);
	}

}
