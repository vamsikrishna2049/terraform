Local Variables
---------------
When you have a multi module terraform project, where you are have already defined some variable inside your (variable.tf). 
But you do not want to use same variable in your other module, then in that case you are going to need local variables.
So that their scope is just limited to that particular module.

Note:
In java, we have local variables and global variables.
Local variables means, variable declared inside a block and scope of the variable is within the block.
Local variables means, variable declared before main block and scope of the variable is entire the program.

1. Terraform Locals in a nutshell
A. Value assignment- 
    Terraform locals do not change their value once it is assigned, you have to re-assign a new value.
B. Power of Expression- 
    Apart from static value assignment terraform locals can use the power of expression, so instead of writing the same expression 
    the multiple times through the terraform configuration, you can declare a terraform locals and use the same terraform locals 
    at other places.

Benefits of using Terraform Locals
If you are working on a large enterprise infrastructure then it is impossible to work without Terraform Locals. 

1. Terraform locals can be re-used multiple numbers of times in the terraform configuration file.
2. It can reduce the work of updating your terraform configuration at multiple places. 
   With terraform locals you need to update its value once and it should reflect all over the place where it is referred.
