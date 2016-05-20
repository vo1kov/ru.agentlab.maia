package ru.agentlab.maia.admin.bundles;

import javax.inject.Named;

import org.osgi.framework.Bundle;
import org.osgi.framework.BundleException;

import ru.agentlab.maia.admin.bundles.internal.Activator;
import ru.agentlab.maia.annotation.GoalClassificationAdded;
import ru.agentlab.maia.annotation.HaveBelief;
import ru.agentlab.maia.annotation.Prefix;

@Prefix(name = "osgi", namespace = "http://www.agentlab.ru/ontologies/osgi")
public class BundleManager {

	@GoalClassificationAdded("?bundle osgi:hasBundleState osgi:STARTRED")
	@HaveBelief("?bundle osgi:hasBundleState osgi:INSTALLED")
	@HaveBelief("?bundle osgi:hasBundleId ?bundleId")
	public void startBundle(@Named("bundleId") long bundleId) throws BundleException {
		Bundle bundle = Activator.context.getBundle(bundleId);
		bundle.start();
	}

	@GoalClassificationAdded("?bundle osgi:hasBundleState osgi:INSTALLED")
	@HaveBelief("?bundle osgi:hasBundleLocation ?location")
	public void installBundle(@Named("location") String location) throws BundleException {
		Activator.context.installBundle(location);
	}

}
