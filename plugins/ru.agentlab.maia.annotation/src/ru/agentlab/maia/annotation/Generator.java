package ru.agentlab.maia.annotation;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.semanticweb.owlapi.model.AxiomType;

import com.google.common.collect.ImmutableList;

import ru.agentlab.maia.EventType;

public class Generator {

	static List<String> aBoxPrefixes = ImmutableList.of(
		// @formatter:off
		"Goal",
		"Failed",
		"Added",
		"Removed"
		// @formatter:on
	);

	static List<String> allPrefixes = ImmutableList.of(
		// @formatter:off
		"Have",
		"Initial"
		// @formatter:on
	);

	static List<String> names = ImmutableList.of(
		// @formatter:off
		"Class",
		"Property",
		"Individual",
		"Type",
		"PropertyValue",
		"EquivalentClass",
		"SubClassOf",
		"EquivalentProperty",
		"SubPropertyOf",
		"InverseOf",
		"ObjectProperty",
		"DataProperty",
		"Functional",
		"InverseFunctional",
		"Transitive",
		"Symmetric",
		"Reflexive",
		"Irreflexive",
		"SameAs",
		"DisjointWith",
		"DifferentFrom",
		"ComplementOf",
		"Annotation"
		// @formatter:on
	);

	static List<String> extra = ImmutableList.of(
		// @formatter:off
		"StrictSubClassOf",
		"DirectSubClassOf",
		"DirectType",
		"StrictSubPropertyOf",
		"DirectSubPropertyOf"
		// @formatter:on
	);

	static List<AxiomType<?>> eventAnn = ImmutableList.of(
		// @formatter:off
		AxiomType.CLASS_ASSERTION,
		AxiomType.DATA_PROPERTY_ASSERTION,
		AxiomType.OBJECT_PROPERTY_ASSERTION,
		AxiomType.NEGATIVE_DATA_PROPERTY_ASSERTION,
		AxiomType.NEGATIVE_OBJECT_PROPERTY_ASSERTION
		// @formatter:on
	);

	static Map<String, EventType> eventAnnotations = new HashMap<>();
	static {
		// @formatter:off
		eventAnnotations.put("AddedClassAssertion", 					EventType.ADDED_CLASS_ASSERTION);
		eventAnnotations.put("AddedDataPropertyAssertion", 				EventType.ADDED_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("AddedObjectPropertyAssertion", 			EventType.ADDED_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("AddedNegativeDataPropertyAssertion", 		EventType.ADDED_NEGATIVE_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("AddedNegativeObjectPropertyAssertion", 	EventType.ADDED_NEGATIVE_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("RemovedClassAssertion", 					EventType.REMOVED_CLASS_ASSERTION);
		eventAnnotations.put("RemovedDataPropertyAssertion", 			EventType.REMOVED_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("RemovedObjectPropertyAssertion", 			EventType.REMOVED_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("RemovedNegativeDataPropertyAssertion", 	EventType.REMOVED_NEGATIVE_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("RemovedNegativeObjectPropertyAssertion", 	EventType.REMOVED_NEGATIVE_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("GoalClassAssertion", 						EventType.GOAL_CLASS_ASSERTION);
		eventAnnotations.put("GoalDataPropertyAssertion", 				EventType.GOAL_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("GoalObjectPropertyAssertion", 			EventType.GOAL_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("GoalNegativeDataPropertyAssertion", 		EventType.GOAL_NEGATIVE_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("GoalNegativeObjectPropertyAssertion", 	EventType.GOAL_NEGATIVE_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("FailedClassAssertion", 					EventType.FAILED_CLASS_ASSERTION);
		eventAnnotations.put("FailedDataPropertyAssertion", 			EventType.FAILED_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("FailedObjectPropertyAssertion", 			EventType.FAILED_OBJECT_PROPERTY_ASSERTION);
		eventAnnotations.put("FailedNegativeDataPropertyAssertion", 	EventType.FAILED_NEGATIVE_DATA_PROPERTY_ASSERTION);
		eventAnnotations.put("FailedNegativeObjectPropertyAssertion", 	EventType.FAILED_NEGATIVE_OBJECT_PROPERTY_ASSERTION);
		// @formatter:on
	};

	public static void main(String[] args) throws IOException {
		eventAnnotations.forEach((k, v)->{
			try {
				generateEventAnnJava(v.toString(), k);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
//		for (String prefix : aBoxPrefixes) {
//			for (AxiomType<?> axiomType : eventAnn) {
//				generateEventAnnJava(prefix.toUpperCase() + "_" + axiomType, prefix + axiomType.getName());
//			}
//		}
		for (String prefix : allPrefixes) {
			for (AxiomType<?> axiomType : AxiomType.TBoxAxiomTypes) {
				generateJava(prefix + axiomType.getName());
			}
			for (AxiomType<?> axiomType : AxiomType.ABoxAxiomTypes) {
				generateJava(prefix + axiomType.getName());
			}
			for (AxiomType<?> axiomType : AxiomType.RBoxAxiomTypes) {
				generateJava(prefix + axiomType.getName());
			}
		}
		// for (String name : extra) {
		// String className = "Have" + name;
		// generateJava(className);
		// }
	}

	private static void generateEventAnnJava(String type, String className) throws IOException {
		File java = new File("output/" + className + ".java");
		java.createNewFile();
		PrintWriter pw = new PrintWriter(new FileWriter(java));
		printEventContent(pw, className, type);
		pw.flush();
		pw.close();
	}

	private static void generateJava(String className) throws IOException {
		File java = new File("output/" + className + ".java");
		java.createNewFile();
		PrintWriter pw = new PrintWriter(new FileWriter(java));
		printContent(pw, className);
		pw.flush();
		pw.close();
	}

	private static void printEventContent(PrintWriter writer, String className, String type) {
		writer.println("package ru.agentlab.maia.annotation.event;");
		writer.println();
		writer.println("import java.lang.annotation.Documented;");
		writer.println("import java.lang.annotation.ElementType;");
		writer.println("import java.lang.annotation.Retention;");
		writer.println("import java.lang.annotation.RetentionPolicy;");
		writer.println("import java.lang.annotation.Target;");
		writer.println();
		writer.println("import ru.agentlab.maia.EventType;");
		writer.println("import ru.agentlab.maia.annotation.EventMatcher;");
		writer.println();
		writer.println("/**");
		writer.println(" * @author Dmitriy Shishkin");
		writer.println(" */");
		writer.println("@Documented");
		writer.println("@Retention(RetentionPolicy.RUNTIME)");
		writer.println("@Target(ElementType.METHOD)");
		writer.print("@EventMatcher(EventType.");
		writer.print(type);
		writer.println(")");
		writer.print("public @interface ");
		writer.print(className);
		writer.println(" {");
		writer.println();
		writer.println("	String value();");
		writer.println();
		writer.println("}");
	}

	private static void printContent(PrintWriter writer, String className) {
		writer.println("package ru.agentlab.maia.annotation.initial;");
		writer.println();
		writer.println("import java.lang.annotation.Documented;");
		writer.println("import java.lang.annotation.ElementType;");
		writer.println("import java.lang.annotation.Retention;");
		writer.println("import java.lang.annotation.RetentionPolicy;");
		writer.println("import java.lang.annotation.Target;");
		writer.println();
		// writer.println("import ru.agentlab.maia.EventType;");
		// writer.println();
		writer.println("/**");
		writer.println(" * @author Dmitriy Shishkin");
		writer.println(" */");
		writer.println("@Documented");
		writer.println("@Retention(RetentionPolicy.RUNTIME)");
		writer.println("@Target(ElementType.TYPE)");
		// writer.println("@EventMatcher(EventType.BELIEF_CLASSIFICATION_ADDED)");
		writer.print("public @interface ");
		writer.print(className);
		writer.println(" {");
		writer.println();
		writer.println("	String[] value();");
		writer.println();
		writer.println("}");
	}

}
