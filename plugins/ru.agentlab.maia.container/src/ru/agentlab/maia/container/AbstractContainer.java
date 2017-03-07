package ru.agentlab.maia.container;

import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentSkipListSet;
import java.util.concurrent.atomic.AtomicReference;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IInjector;

import static com.google.common.base.Preconditions.checkNotNull;

public abstract class AbstractContainer implements IContainer {

	protected final UUID uuid = UUID.randomUUID();
	protected final IInjector injector = new Injector(this);
	protected final AtomicReference<IContainer> parent = new AtomicReference<IContainer>(null);
	protected final Set<IContainer> childs = new ConcurrentSkipListSet<IContainer>();

	public AbstractContainer() {
		super();
	}

	@Override
	public UUID getUuid() {
		return uuid;
	}

	@Override
	public IContainer getParent() {
		return parent.get();
	}

	@Override
	public IInjector getInjector() {
		return injector;
	}

	@Override
	public void removeChild(IContainer container) {
		checkNotNull(container, "Child container should ne non null");
		childs.remove(container);
		container.setParent(null);
	}

	@Override
	public void clearChilds() {
		childs.forEach(container -> container.setParent(null));
		childs.clear();
	}

	@Override
	public Iterable<IContainer> getChilds() {
		return childs;
	}

	@Override
	public IContainer setParent(IContainer container) {
		checkNotNull(container, "Parent container should ne non null");
		return parent.getAndSet(container);
	}

	@Override
	public void addChild(IContainer container) {
		checkNotNull(container, "Child container should ne non null");
		childs.add(container);
		container.setParent(this);
	}

}