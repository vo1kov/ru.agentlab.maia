Execution order with different scheduler types

Narrative:
In order to effectively execute task tree
As a task designer
I want to control execution order by using different schedulers with different types

Scenario: Executing sequential scheduler with parallel subtasks
Given a sequential schedulers A
And a parallel schedulers B, C
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
|step	|execute|A		|B		|C		|B1		|B2		|B3		|B4		|C1		|C2		|C3		|C4		|
|0		|		|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|1		|B1		|WORKING|WORKING|READY	|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|2		|B2		|WORKING|WORKING|READY	|SUCCESS|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|
|3		|B3		|WORKING|WORKING|READY	|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|READY	|READY	|READY	|
|4		|B4		|WORKING|SUCCESS|READY	|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|READY	|READY	|
|5		|C1		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|READY	|
|6		|C2		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|
|7		|C3		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|
|8		|C4		|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|

Scenario: Executing sequential scheduler with sequential subtasks
Given a sequential schedulers A, B, C
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
|step	|execute|A		|B		|C		|B1		|B2		|B3		|B4		|C1		|C2		|C3		|C4		|
|0		|		|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|1		|B1		|WORKING|WORKING|READY	|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|2		|B2		|WORKING|WORKING|READY	|SUCCESS|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|
|3		|B3		|WORKING|WORKING|READY	|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|READY	|READY	|READY	|
|4		|B4		|WORKING|SUCCESS|READY	|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|READY	|READY	|
|5		|C1		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|READY	|
|6		|C2		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|READY	|
|7		|C3		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|
|8		|C4		|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|

Scenario: Executing parallel scheduler with sequential subtasks
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
|step	|execute|A		|B		|C		|B1		|B2		|B3		|B4		|C1		|C2		|C3		|C4		|
|0		|		|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|1		|B1		|WORKING|WORKING|READY	|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|2		|C1		|WORKING|WORKING|WORKING|SUCCESS|READY	|READY	|READY	|SUCCESS|READY	|READY	|READY	|
|3		|B2		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|READY	|READY	|SUCCESS|READY	|READY	|READY	|
|4		|C2		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|READY	|READY	|SUCCESS|SUCCESS|READY	|READY	|
|5		|B3		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|SUCCESS|READY	|SUCCESS|SUCCESS|READY	|READY	|
|6		|C3		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|SUCCESS|READY	|SUCCESS|SUCCESS|SUCCESS|READY	|
|7		|B4		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|
|8		|C4		|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|

Scenario: Executing parallel scheduler with parallel subtasks
Given a parallel schedulers A, B, C
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
|step	|execute|A		|B		|C		|B1		|B2		|B3		|B4		|C1		|C2		|C3		|C4		|
|0		|		|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|1		|B1		|WORKING|WORKING|READY	|SUCCESS|READY	|READY	|READY	|READY	|READY	|READY	|READY	|
|2		|C1		|WORKING|WORKING|WORKING|SUCCESS|READY	|READY	|READY	|SUCCESS|READY	|READY	|READY	|
|3		|B2		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|READY	|READY	|SUCCESS|READY	|READY	|READY	|
|4		|C2		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|READY	|READY	|SUCCESS|SUCCESS|READY	|READY	|
|5		|B3		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|SUCCESS|READY	|SUCCESS|SUCCESS|READY	|READY	|
|6		|C3		|WORKING|WORKING|WORKING|SUCCESS|SUCCESS|SUCCESS|READY	|SUCCESS|SUCCESS|SUCCESS|READY	|
|7		|B4		|WORKING|SUCCESS|WORKING|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|READY	|
|8		|C4		|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|SUCCESS|