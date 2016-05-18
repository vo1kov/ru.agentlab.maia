package ru.agentlab.maia.container.logs;

import java.text.MessageFormat;
import java.util.ResourceBundle;

public class Messages {
  public final static String AFTER_CREATE_CONTEXT = "afterCreateContext";
  
  public final static ResourceBundle MESSAGES = ResourceBundle.getBundle("Messages");
  
  public static String getString(final String s) {
    return Messages.MESSAGES.getString(s);
  }
  
  public static String getMessage(final String s, final String... ss) {
    return MessageFormat.format(s, ss);
  }
}
