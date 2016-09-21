package ru.agentlab.maia.container.impl.tests.smoke;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;

import javax.inject.Inject;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;

import ru.agentlab.maia.container.impl.Injector;

public class InjectorUninjectFunctionalTest {

	static class FakePrimitive {
		@Inject
		byte byteValue;
		@Inject
		short shortValue;
		@Inject
		int intValue;
		@Inject
		long longValue;
		@Inject
		float floatValue;
		@Inject
		double doubleValue;
		@Inject
		boolean booleanValue;
		@Inject
		char charValue;
		{
			// Imitate value injection
			byteValue = (byte) RandomUtils.nextInt();
			shortValue = (short) RandomUtils.nextInt();
			intValue = (int) RandomUtils.nextInt();
			longValue = (long) RandomUtils.nextLong();
			floatValue = (float) RandomUtils.nextFloat();
			doubleValue = (double) RandomUtils.nextDouble();
			booleanValue = (boolean) true;
			charValue = (char) RandomUtils.nextInt();
		}
	}

	static class FakeObject {
		@Inject
		Object objectValue;
		@Inject
		String stringValue;
		{
			// Imitate value injection
			objectValue = new Object();
			stringValue = RandomStringUtils.random(10);
		}
	}

	static class FakeWithoutInject {
		Object objectValue;
		String stringValue;
		{
			// Imitate value injection
			objectValue = new Object();
			stringValue = RandomStringUtils.random(10);
		}
	}

	Injector injector = new Injector(null);

	@Test
	public void testPrimitiveTypes() {
		// Given
		FakePrimitive fake = new FakePrimitive();
		assertThat(fake.byteValue, not(equalTo((byte) 0)));
		assertThat(fake.shortValue, not(equalTo((short) 0)));
		assertThat(fake.intValue, not(equalTo((int) 0)));
		assertThat(fake.longValue, not(equalTo((long) 0L)));
		assertThat(fake.floatValue, not(equalTo((float) 0.0F)));
		assertThat(fake.doubleValue, not(equalTo((double) 0.0D)));
		assertThat(fake.booleanValue, not(equalTo((boolean) false)));
		assertThat(fake.charValue, not(equalTo((char) '\u0000')));
		// When
		injector.uninject(fake);
		// Then
		assertThat(fake.byteValue, equalTo((byte) 0));
		assertThat(fake.shortValue, equalTo((short) 0));
		assertThat(fake.intValue, equalTo((int) 0));
		assertThat(fake.longValue, equalTo((long) 0L));
		assertThat(fake.floatValue, equalTo((float) 0.0F));
		assertThat(fake.doubleValue, equalTo((double) 0.0D));
		assertThat(fake.booleanValue, equalTo((boolean) false));
		assertThat(fake.charValue, equalTo((char) '\u0000'));
	}

	@Test
	public void testObjectType() {
		// Given
		FakeObject fake = new FakeObject();
		assertThat(fake.objectValue, not(equalTo(null)));
		assertThat(fake.stringValue, not(equalTo(null)));
		// When
		injector.uninject(fake);
		// Then
		assertThat(fake.objectValue, equalTo(null));
		assertThat(fake.stringValue, equalTo(null));
	}

	@Test
	public void testWithoutInject() {
		// Given
		FakeWithoutInject fake = new FakeWithoutInject();
		assertThat(fake.objectValue, not(equalTo(null)));
		assertThat(fake.stringValue, not(equalTo(null)));
		Object objectValue = fake.objectValue;
		String stringValue = fake.stringValue;
		// When
		injector.uninject(fake);
		// Then
		assertThat(fake.objectValue, equalTo(objectValue));
		assertThat(fake.stringValue, equalTo(stringValue));
	}

}
