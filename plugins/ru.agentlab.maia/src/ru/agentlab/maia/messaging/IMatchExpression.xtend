package ru.agentlab.maia.messaging

/**
 * 	 This interface must be overriden in order to define an application 
 * 	 specific MessageTemplate.
 * 	 In particular in the method <code> match()</code> the programmer
 * 	 should realize the necessary checks on the ACLMessage in order 
 * 	 to return <b>true</b> if the message match with the application 
 * 	 specific requirements <b>false</b> otherwise.
 */
interface IMatchExpression {
	
	/**
	 *  Check whether a given ACL message matches this
	 *  template. Concrete implementations of this interface will
	 *  have this method called to accept or refuse an ACL message.
	 *  @param msg The ACL message to match against this message
	 *  template.
	 *  @return A compliant implementation will return
	 *  <code>true</code> if the parameter ACL message matches the
	 *  template, and <code>false</code> otherwise.
	 */
	def boolean match(IMessage msg)

}