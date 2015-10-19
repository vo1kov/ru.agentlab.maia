Execution order with different scheduler types

Narrative:
In order to effectively execute task tree
As a task designer
I want to control execution order by using different schedulers with different types

Scenario: Executing sequential scheduler with parallel subtasks
Given a parallel schedulers A
And a sequential schedulers B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by <step> times
Then task <execute> have been executed
And task A have <A> state
And task B have <B> state
And task C have <C> state
And task B1 have <B1> state
And task B2 have <B2> state
And task B3 have <B3> state
And task B4 have <B4> state
And task C1 have <C1> state
And task C2 have <C2> state
And task C3 have <C3> state
And task C4 have <C4> state
Examples:
|step	|A		|B		|C		|B1		|B2		|B3		|B4		|C1		|C2		|C3		|C4		|execute|
|0		|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|		|
|1		|WORKING|WORKING|READY	|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|READY	|B1		|
|2		|WORKING|WORKING|WORKING|SUCCESS|READY	|READY	|READY	|SUCCESS|READY	|READY	|READY	|C1		|
|3		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|READY	|READY	|SUCCESS|READY	|READY	|READY	|B2		|
|4		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|READY	|READY	|SUCCESS|SUCCESS|READY	|READY	|C2		|
|5		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|SUCCESS|READY	|SUCCESS|SUCCESS|READY	|READY	|B3		|
|6		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|SUCCESS|READY	|SUCCESS|SUCCESS|SUCCESS|READY	|C3		|
|7		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|B4		|
|8		|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|C4		|