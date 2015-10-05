package ru.agentlab.maia.execution.scheduler.sequential.test.func;

import java.text.SimpleDateFormat;
import java.util.List;

import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Pending;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.configuration.Configuration;
import org.jbehave.core.configuration.MostUsefulConfiguration;
import org.jbehave.core.embedder.Embedder;
import org.jbehave.core.embedder.EmbedderControls;
import org.jbehave.core.io.CodeLocations;
import org.jbehave.core.io.LoadFromClasspath;
import org.jbehave.core.parsers.RegexPrefixCapturingPatternParser;
import org.jbehave.core.reporters.CrossReference;
import org.jbehave.core.reporters.StoryReporterBuilder;
import org.jbehave.core.reporters.StoryReporterBuilder.Format;
import org.jbehave.core.steps.InjectableStepsFactory;
import org.jbehave.core.steps.InstanceStepsFactory;
import org.jbehave.core.steps.ParameterConverters;
import org.jbehave.core.steps.ParameterConverters.DateConverter;
import org.jbehave.core.steps.SilentStepMonitor;
import org.junit.Test;

@SuppressWarnings("restriction")
public class MySteps {
	
	@Given("Scheduler with $size subtasks")
	@Pending
	public void givenSchedulerWithSubtasks(int size) {
		// TODO
	}

	@When("Remove any existing subtask")
	@Pending
	public void whenRemoveAnyExistingSubtask() {
		// TODO
	}

	@Then("step represents the outcome of the event")
	@Pending
	public void whenRemoveAnyExistingSubtask1() {
		// TODO
	}
	
	@Test
    public void runClasspathLoadedStoriesAsJUnit() {
        // Embedder defines the configuration and candidate steps
        Embedder embedder = new TraderEmbedder();
        List<String> storyPaths = null; // use StoryFinder to look up paths
        embedder.runStoriesAsPaths(storyPaths);
    }
	
	public class TraderEmbedder extends Embedder {
		 
	    @Override
	    public EmbedderControls embedderControls() {
	        return new EmbedderControls().doIgnoreFailureInStories(true).doIgnoreFailureInView(true);
	    }
	 
	    @Override
	    public Configuration configuration() {
	        Class<? extends TraderEmbedder> embedderClass = this.getClass();
	        return new MostUsefulConfiguration()
	            .useStoryLoader(new LoadFromClasspath(embedderClass.getClassLoader()))
	            .useStoryReporterBuilder(new StoryReporterBuilder()
	                .withCodeLocation(CodeLocations.codeLocationFromClass(embedderClass))
	                .withDefaultFormats()
//	                .withFormats(Format.CONSOLE, Format.TXT, Format.HTML, Format.XML)
	                .withCrossReference(new CrossReference()))
	            .useParameterConverters(new ParameterConverters()
	                    .addConverters(new DateConverter(new SimpleDateFormat("yyyy-MM-dd")))) // use custom date pattern
	            .useStepPatternParser(new RegexPrefixCapturingPatternParser(
	                            "%")) // use '%' instead of '$' to identify parameters
	            .useStepMonitor(new SilentStepMonitor());                               
	    }
	 
//	    @Override
//	    public InjectableStepsFactory stepsFactory() {
//	        return new InstanceStepsFactory(configuration(), new TraderSteps(new TradingService()), new BeforeAfterSteps());
//	    }
	 
	}
}