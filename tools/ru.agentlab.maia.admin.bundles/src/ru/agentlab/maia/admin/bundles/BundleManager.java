package ru.agentlab.maia.admin.bundles;

import static ru.agentlab.maia.belief.annotation.AxiomType.DATA_PROPERTY_ASSERTION;
import static ru.agentlab.maia.belief.annotation.AxiomType.OBJECT_PROPERTY_ASSERTION;

import javax.inject.Named;

import org.osgi.framework.Bundle;
import org.osgi.framework.BundleException;

import ru.agentlab.maia.admin.bundles.internal.Activator;
import ru.agentlab.maia.belief.annotation.Prefix;
import ru.agentlab.maia.belief.annotation.WhenHaveBelief;
import ru.agentlab.maia.goal.annotation.OnGoalAdded;

@Prefix(name = "osgi", namespace = "http://www.agentlab.ru/ontologies/osgi")
public class BundleManager {

	@OnGoalAdded(value = { "?bundle", "osgi:hasBundleState", "osgi:STARTRED" }, type = OBJECT_PROPERTY_ASSERTION)
	@WhenHaveBelief(value = { "?bundle", "osgi:hasBundleState", "osgi:INSTALLED" }, type = OBJECT_PROPERTY_ASSERTION)
	@WhenHaveBelief(value = { "?bundle", "osgi:hasBundleId", "?bundleId" }, type = DATA_PROPERTY_ASSERTION)
	public void startBundle(@Named("bundleId") long bundleId) throws BundleException {
		Bundle bundle = Activator.context.getBundle(bundleId);
		bundle.start();
	}

	@OnGoalAdded(value = { "?bundle", "osgi:hasBundleState", "osgi:INSTALLED" }, type = OBJECT_PROPERTY_ASSERTION)
	@WhenHaveBelief(value = { "?bundle", "osgi:hasBundleLocation", "?location" }, type = DATA_PROPERTY_ASSERTION)
	public void installBundle(@Named("location") String location) throws BundleException {
		Activator.context.installBundle(location);
	}

}
