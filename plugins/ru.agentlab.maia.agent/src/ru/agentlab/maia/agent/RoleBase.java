package ru.agentlab.maia.agent;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import javax.annotation.PostConstruct;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IConverter;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.event.RoleResolvedEvent;
import ru.agentlab.maia.event.RoleUnresolvedEvent;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

public class RoleBase implements IRoleBase {

	IInjector injector;

	private Map<IRole, Object> map = new HashMap<>();

	private final Queue<IEvent<?>> eventQueue;

	IConverter converter;

	IPlanBase planBase;

	IGoalBase goalBase;

	IBeliefBase beliefBase;

	IAgent agent;

	public RoleBase(Queue<IEvent<?>> eventQueue, IInjector injector) {
		this.eventQueue = eventQueue;
		this.injector = injector;
	}

	@Override
	public Object addRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException {
		if (!agent.getState().isDeployed()) {
			throw new IllegalStateException("Agetn should be deployed into container to add new roles!");
		}
		try {
			// Create instance of role object
			Object roleObject = injector.make(roleClass);
			// Inject services
			injector.inject(roleObject);
			// Convert role object to plans
			Map<IPlan, EventType> planRegistrations = converter.getPlans(roleObject);
			// Add plans to agent plan base
			planRegistrations.forEach((plan, type) -> planBase.add(type, plan));
			// Convert initial beliefs from the role object
			List<OWLAxiom> initialBeliefs = converter.getInitialBeliefs(roleObject);
			// Add initial beliefs
			beliefBase.addAxioms(initialBeliefs);
			// Convert initial beliefs from the role object
			List<OWLAxiom> initialGoals = converter.getInitialGoals(roleObject);
			// Add initial goals
			goalBase.addAxioms(initialGoals);
			// Invoke @PostConstruct to initialize role object
			injector.invoke(roleObject, PostConstruct.class);
			// Generate internal event
			eventQueue.offer(new RoleResolvedEvent(roleClass));
			return roleObject;
		} catch (InjectorException | ContainerException | ConverterException e) {
			eventQueue.offer(new RoleUnresolvedEvent(roleClass));
			throw new ResolveException(e);
		}
	}

	@Override
	public Collection<Object> getRoles() {
		return map.keySet();
	}

	@Override
	public void remove(IRole roleClass) {
		map.remove(roleClass);
	}

	@Override
	public boolean contains(Class<?> roleClass) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void remove(Class<?> roleClass) {
		// TODO Auto-generated method stub
		
	}

}
