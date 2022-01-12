# Question 3 and 4
## Wording
First search on google by the sentence "text manipulation problem": https://www.toolbox.com/tech/programming/question/text-manipulation-problem-1-102007/

I will add some conditions to increase a bit the complexity:
- After applying the first row filter, if there's rows where the second columns are equals the values of theis fifth columns should be added.
- The output should be sorted from greater to lowest

**Summary**

Given a file in the format below, print the second and fifth column of the rows in which the value of ther fifth column is in the ranges [-50,0) and (0, 50]. After this, group the rows in which the new first column values are equal by adding the value of the second column.

The final output should be sorted from greatest to lowest of the fifth column.

Sample file:
```txt
DCX|ABC|400|700|300|40000
DCX|ABC|400|700|-15|40000
DCX|ABC|400|700|  2|40000
DCX|ghj|400|700| 50|40000
DCX|xyz|400|700| 15|40000
DCX|asd|400|700| 60|40000
DCX|kjl|400|700|  0|40000

```
Sample output:
```txt
ghj,50
xyz,15
ABC,-13
```

## Question 3
The solution as a script would be
```bash
awk -F\| '{if( $5>=-50 && $5<=50 && $5!=0 )print$2,$5}' <sample.txt | awk '{arr[$1]+=$2} END {for (i in arr) {print i","arr[i]}}' | sort -t, -rnk2
```

## Question 4
The problem is also solved as with python(3.7.9), it could have been solved with few lines but since that was the purpouse of question3 here I used proper programming techniques such as encapulating funcitonalities on different functions (Using object oriented programming was not necessary for this problem since it is a very small domain).

```bash
python question5.py -f sample.txt
```
