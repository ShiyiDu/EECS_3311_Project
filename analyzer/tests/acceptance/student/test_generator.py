import random

def get_const():
	bool_const = "bool_value (" + random.choice(["true", "false"]) + ")\n"
	int_const = "int_value (" + random.randrange(1, 50) + ")\n"
	return random.choice([bool_const, int_const])

def binary_op():
	binary_arith = random.choice(["addition", "subtraction", "multiplication", "quotient", "modulo"]) + "\n"
	binary_logical = random.choice(["conjunction", "disjunction"]) + "\n"
	binary_rel = random.choice(["equals", "greater_than", "less_than"]) + "\n"
	
	operation = random.choice([binary_rel, binary_arith, binary_logical])
	return operation
	
def neg():
	neg = random.choice(["numerical_negation", "logical_negation"]) + "\n"
	return neg
	
def call_chain():
	num = random.randrange(1, 10)
	result = "add_call_chain(<<"
	for i in range(1, num, 1):
		result = result + (rand_name() + ",")
	
	result = result + (rand_name() + ">>)\n")
	return result

def rand_name():
	upper_case = random.choice(["A", "B", "C", "D"])
	lower_case = random.choice(["a", "b", "c", "d", "e"])
	return random.choice([upper_case, lower_case])
	
print(call_chain())
#
#f = open("test14.txt", "w+")
#for i in range (100):
#	for i in range(random.randrange(1, 17)):
##		setting up chess
#		f.write(command(0) + '\n')
#	f.write(command(1) + '\n')
#	for i in range(random.randrange(1, 400)):
#		f.write(command(3) + '\n')
#	for i in range(random.randrange(1, 30)):
#		f.write(command(-1) + '\n')
#f.close