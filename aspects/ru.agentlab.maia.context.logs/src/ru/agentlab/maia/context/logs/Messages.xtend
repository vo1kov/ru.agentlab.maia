package ru.agentlab.maia.context.logs

import java.util.ResourceBundle
import java.text.MessageFormat

class Messages {

	val public static AFTER_CREATE_CONTEXT = "afterCreateContext"

	val public static MESSAGES = ResourceBundle.getBundle("Messages")
	
	def static String getString(String s){
		MESSAGES.getString(s)
	}
	
	def static String getMessage(String s, String... ss){
		MessageFormat.format(s, ss);
	}
	
}
