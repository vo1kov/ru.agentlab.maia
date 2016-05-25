package ru.agentlab.maia.agent.converter;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.JavaAnyMatcher;
import ru.agentlab.maia.agent.match.JavaBooleanMatcher;
import ru.agentlab.maia.agent.match.JavaDoubleMatcher;
import ru.agentlab.maia.agent.match.JavaFloatMatcher;
import ru.agentlab.maia.agent.match.JavaIntegerMatcher;
import ru.agentlab.maia.agent.match.JavaStringMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralBooleanMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralDoubleMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralFloatMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralIntegerMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralPlainMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralTypedMatcher;
import ru.agentlab.maia.agent.match.OWLNamedObjectMatcher;
import ru.agentlab.maia.agent.match.VariableMatcher;

public class MatcherUtil {

	public static final String HEX_BINARY = OWL2Datatype.XSD_HEX_BINARY.getShortForm();
	public static final String NORMALIZED_STRING = OWL2Datatype.XSD_NORMALIZED_STRING.getShortForm();
	public static final String RATIONAL = OWL2Datatype.OWL_RATIONAL.getShortForm();
	public static final String REAL = OWL2Datatype.OWL_REAL.getShortForm();
	public static final String STRING = OWL2Datatype.XSD_STRING.getShortForm();
	public static final String LITERAL = OWL2Datatype.RDFS_LITERAL.getShortForm();
	public static final String XML_LITERAL = OWL2Datatype.RDF_XML_LITERAL.getShortForm();

	public final static String RDF = Namespaces.RDF.toString();
	public final static String RDFS = Namespaces.RDFS.toString();
	public final static String OWL = Namespaces.OWL.toString();
	public final static String XSD = Namespaces.XSD.toString();

	public static IMatcher<? super String> _str(String value) {
		return new JavaStringMatcher(value);
	}

	public static IMatcher<? super Boolean> _boo(boolean value) {
		return new JavaBooleanMatcher(value);
	}

	public static IMatcher<? super Float> _flo(float value) {
		return new JavaFloatMatcher(value);
	}

	public static IMatcher<? super Integer> _int(int value) {
		return new JavaIntegerMatcher(value);
	}

	public static IMatcher<? super Double> _dou(double value) {
		return new JavaDoubleMatcher(value);
	}

	public static IMatcher<? super OWLDatatype> _typ(String namespace, String value) {
		return new OWLNamedObjectMatcher(IRI.create(namespace, value));
	}

	public static IMatcher<? super Object> _var(String value) {
		return new VariableMatcher(value);
	}

	public static IMatcher<? super Object> _any() {
		return JavaAnyMatcher.getInstance();
	}

	public static IMatcher<? super OWLLiteral> plainMatcher(IMatcher<? super String> literalMatcher,
			IMatcher<? super String> languageMatcher) {
		return new OWLLiteralPlainMatcher(literalMatcher, languageMatcher);
	}

	public static IMatcher<? super OWLLiteral> typedMatcher(IMatcher<? super String> literalMatcher,
			IMatcher<? super OWLDatatype> datatypeMatcher) {
		return new OWLLiteralTypedMatcher(literalMatcher, datatypeMatcher);
	}

	public static IMatcher<? super OWLLiteral> boolnMatcher(IMatcher<? super Boolean> matcher) {
		return new OWLLiteralBooleanMatcher(matcher);
	}

	public static IMatcher<? super OWLLiteral> floatMatcher(IMatcher<? super Float> matcher) {
		return new OWLLiteralFloatMatcher(matcher);
	}

	public static IMatcher<? super OWLLiteral> intgrMatcher(IMatcher<? super Integer> matcher) {
		return new OWLLiteralIntegerMatcher(matcher);
	}

	public static IMatcher<? super OWLLiteral> doublMatcher(IMatcher<? super Double> matcher) {
		return new OWLLiteralDoubleMatcher(matcher);
	}
}