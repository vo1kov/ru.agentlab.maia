package ru.agentlab.maia;

public class ResolveException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ResolveException() {
		super();
	}

	public ResolveException(String message, Throwable cause) {
		super(message, cause);
	}

	public ResolveException(String message) {
		super(message);
	}

	public ResolveException(Throwable cause) {
		super(cause);
	}

}
