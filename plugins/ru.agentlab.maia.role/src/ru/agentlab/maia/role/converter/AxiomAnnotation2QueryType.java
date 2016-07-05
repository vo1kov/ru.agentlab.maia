package ru.agentlab.maia.role.converter;

import java.lang.annotation.Annotation;

import de.derivo.sparqldlapi.types.QueryAtomType;
import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.role.AxiomType;

public class AxiomAnnotation2QueryType {

	protected static final String VALUE = "value";

	protected static final String TYPE = "type";

	public QueryAtomType getQueryType(Annotation ann) throws ConverterException {
		AxiomType type = Util.getMethodValue(ann, TYPE, AxiomType.class);
		String[] args = Util.getMethodValue(ann, VALUE, String[].class);
		checkLength(args, type.getArity());
		switch (type) {
		case ANNOTATION_ASSERTION:
			return QueryAtomType.ANNOTATION_PROPERTY;
		case ANNOTATION_PROPERTY_DOMAIN:
			return QueryAtomType.DOMAIN;
		case ANNOTATION_PROPERTY_RANGE:
			return QueryAtomType.RANGE;
		case ASYMMETRIC_OBJECT_PROPERTY:
			throw new UnsupportedOperationException();
		case CLASS_ASSERTION:
			return QueryAtomType.TYPE;
		case DATATYPE_DEFINITION:
			throw new UnsupportedOperationException();
		case DATA_PROPERTY_ASSERTION:
			return QueryAtomType.DATA_PROPERTY;
		case DATA_PROPERTY_DOMAIN:
			return QueryAtomType.DOMAIN;
		case DATA_PROPERTY_RANGE:
			return QueryAtomType.RANGE;
		case DECLARATION:
			throw new UnsupportedOperationException();
		case DIFFERENT_INDIVIDUALS:
			return QueryAtomType.DIFFERENT_FROM;
		case DISJOINT_CLASSES:
			return QueryAtomType.DISJOINT_WITH;
		case DISJOINT_DATA_PROPERTIES:
			return QueryAtomType.DISJOINT_WITH;
		case DISJOINT_OBJECT_PROPERTIES:
			return QueryAtomType.DISJOINT_WITH;
		case DISJOINT_UNION:
			return QueryAtomType.DISJOINT_WITH;
		case EQUIVALENT_CLASSES:
			return QueryAtomType.EQUIVALENT_CLASS;
		case EQUIVALENT_DATA_PROPERTIES:
			return QueryAtomType.EQUIVALENT_PROPERTY;
		case EQUIVALENT_OBJECT_PROPERTIES:
			return QueryAtomType.EQUIVALENT_PROPERTY;
		case FUNCTIONAL_DATA_PROPERTY:
			return QueryAtomType.FUNCTIONAL;
		case FUNCTIONAL_OBJECT_PROPERTY:
			return QueryAtomType.FUNCTIONAL;
		case HAS_KEY:
			throw new UnsupportedOperationException();
		case INVERSE_FUNCTIONAL_OBJECT_PROPERTY:
			return QueryAtomType.INVERSE_FUNCTIONAL;
		case INVERSE_OBJECT_PROPERTIES:
			return QueryAtomType.INVERSE_OF;
		case IRREFLEXIVE_OBJECT_PROPERTY:
			return QueryAtomType.IRREFLEXIVE;
		case NEGATIVE_DATA_PROPERTY_ASSERTION:
			throw new UnsupportedOperationException();
		case NEGATIVE_OBJECT_PROPERTY_ASSERTION:
			throw new UnsupportedOperationException();
		case OBJECT_PROPERTY_ASSERTION:
			return QueryAtomType.OBJECT_PROPERTY;
		case OBJECT_PROPERTY_DOMAIN:
			return QueryAtomType.DOMAIN;
		case OBJECT_PROPERTY_RANGE:
			return QueryAtomType.RANGE;
		case REFLEXIVE_OBJECT_PROPERTY:
			return QueryAtomType.REFLEXIVE;
		case SAME_INDIVIDUAL:
			return QueryAtomType.SAME_AS;
		case SUBCLASS_OF:
			return QueryAtomType.SUB_CLASS_OF;
		case SUB_ANNOTATION_PROPERTY_OF:
			return QueryAtomType.SUB_PROPERTY_OF;
		case SUB_DATA_PROPERTY:
			return QueryAtomType.SUB_PROPERTY_OF;
		case SUB_OBJECT_PROPERTY:
			return QueryAtomType.SUB_PROPERTY_OF;
		case SUB_PROPERTY_CHAIN_OF:
			throw new UnsupportedOperationException();
		case SWRL_RULE:
			throw new UnsupportedOperationException();
		case SYMMETRIC_OBJECT_PROPERTY:
			return QueryAtomType.SYMMETRIC;
		case TRANSITIVE_OBJECT_PROPERTY:
			return QueryAtomType.TRANSITIVE;
		default:
			throw new UnsupportedOperationException();
		}
	}

	private void checkLength(String[] args, int length) throws ConverterException {
		if (length == -1) {
			return;
		}
		if (args.length != length) {
			throw new ConverterException("Initial goal for Annotation assertion should contain 3 arguments");
		}
	}

}
