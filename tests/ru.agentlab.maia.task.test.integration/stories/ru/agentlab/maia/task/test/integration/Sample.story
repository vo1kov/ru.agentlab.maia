Sample story

Narrative:
In order to communicate effectively to the business some functionality
As a development team
I want to use Behaviour-Driven Development
					 
Scenario: Executing sequential scheduler with parallel subtasks
Given a sequential schedulers A
And a parallel schedulers B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by 8 times
Then execution order is B1, B2, B3, B4, C1, C2, C3, C4
					 
Scenario: Executing parallel scheduler with sequential subtasks
Given a parallel schedulers A
And a sequential schedulers B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by 8 times
Then execution order is B1, C1, B2, C2, B3, C3, B4, C4