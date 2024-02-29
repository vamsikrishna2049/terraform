https://jhooq.com/terraform-for-and-for-each-loop/

We're learning about 
1. Loops with count
    1.1 Iterate List using count -Create IAM Users
    1.2 Iterate Set using count
    1.3 Iterate map using count

2. Loops with for_each 
    2.1 Iterate List using for_each
    Note : - It can only be used on set(string) or map(string)
    2.2 Iterate Set using for_each
    2.3 Iterate map using for_each

3. for loop
    3.1 How to iterate over Set using for?
    3.2 How to iterate over List using for?
    3.3 How to iterate over MAP using for?

Note:
    The difference between list and map syntax
    For list -
        {for <ITEM> in <LIST> : <OUTPUT_KEY> => <OUTPUT_VALUE>}
    
    For Map -
        {for <KEY>, <VALUE> in <MAP> : <OUTPUT_KEY> => <OUTPUT_VALUE>} 

4. What is the difference between for_each and count?

count works on a list and uses IDs that are whole numbers. 
for_each works with a map or set, and string keys are used as keys.

If you remove an item from the middle of your list using count, every item after it will move down to take its place, and Terraform will make them all over again. With for_each, each instance has a stable identity based on its key, and Terraform won't make new instances if you delete one.
for_each gives you more freedom and control, especially when you want to make resources with different traits, because you can map different resource options to values in each map or set.