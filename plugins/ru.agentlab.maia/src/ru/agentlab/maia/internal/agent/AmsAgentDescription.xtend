package ru.agentlab.maia.internal.agent

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * This class implements the concept of the fipa-agent-management ontology
 * representing the description of an Agent in the AMS catalogue.
 * @see jade.domain.FIPAAgentManagement.FIPAManagementOntology
 * @see jade.domain.AMSService
 * @author Fabio Bellifemine - CSELT S.p.A.
 * @version $Date: 2006-12-14 17:26:48 +0100 (gio, 14 dic 2006) $ $Revision: 5916 $
 */
public class AmsAgentDescription {

	/**
       String constant for the <code>initiated</code> agent life-cycle
       state.
	 */
	public static final String INITIATED = "initiated";

	/**
       String constant for the <code>active</code> agent life-cycle
       state.
	 */
	public static final String ACTIVE = "active";

	/**
       String constant for the <code>suspended</code> agent life-cycle
       state.
	 */
	public static final String SUSPENDED = "suspended";

	/**
       String constant for the <code>waiting</code> agent life-cycle
       state.
	 */
	public static final String WAITING = "waiting";

	/**
       String constant for the <code>transit</code> agent life-cycle
       state.
	 */
	public static final String TRANSIT = "transit";

	/**
    String constant for the <code>latent</code> agent life-cycle
    state. JADE specific state indicating an agent waiting to be restored after a 
    crash of the main container
	 */
	public static final String LATENT = "latent";
	
	@Accessors
	private AgentId name;
	
	@Accessors
	private String ownership;
	
	@Accessors
	private String state;

}
