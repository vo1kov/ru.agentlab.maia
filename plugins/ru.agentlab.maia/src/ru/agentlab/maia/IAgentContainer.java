package ru.agentlab.maia;

public interface IAgentContainer extends IContainer {

	@Override
	default public Iterable<IContainer> getChilds() {
		return null;
	}

	@Override
	default public void addChild(IContainer container) {
		throw new UnsupportedOperationException();
	}

	@Override
	default public void removeChild(IContainer container) {
		throw new UnsupportedOperationException();
	}

	@Override
	default public void clearChilds() {
		throw new UnsupportedOperationException();
	}

	@Override
	default public Object remove(String key) {
		throw new UnsupportedOperationException();
	}

	@Override
	default public boolean clear() {
		throw new UnsupportedOperationException();
	}

	@Override
	default public Object put(String key, Object value) {
		throw new UnsupportedOperationException();
	}

}
