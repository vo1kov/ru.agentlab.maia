package ru.agentlab.maia.container.logs;

import java.text.MessageFormat;
import java.util.ResourceBundle;

public class Messages {

	public final static String AFTER_CREATE_CONTEXT = "afterCreateContext";

	public final static ResourceBundle MESSAGES = ResourceBundle.getBundle("Messages");

	public static String getString(String s) {
		return Messages.MESSAGES.getString(s);
	}

	public static String getMessage(String s, Object... ss) {
		return MessageFormat.format(s, ss);
	}

}
