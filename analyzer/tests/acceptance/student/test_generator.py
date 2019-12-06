import random

integer = "INTEGER"
boolean = "BOOLEAN"

def get_const():
	bool_const = "bool_value (" + random.choice(["true", "false"]) + ")\n"
	int_const = "int_value (" + str(random.randrange(1, 50)) + ")\n"
	return random.choice([bool_const, int_const])

def call_chain():
	num = random.randrange(1, 10)
	result = "add_call_chain(<<"
	for i in range(1, num, 1):
		result = result + (to_string(rand_name()) + ",")
	
	result = result + (to_string(rand_name()) + ">>)\n")
	return result

def binary_op():
	binary_arith = random.choice(["addition", "subtraction", "multiplication", "quotient", "modulo"]) + "\n"
	binary_logical = random.choice(["conjunction", "disjunction"]) + "\n"
	binary_rel = random.choice(["equals", "greater_than", "less_than"]) + "\n"
	
	operation = random.choice([binary_rel, binary_arith, binary_logical])
	return operation
	
def neg():
	neg = random.choice(["numerical_negation", "logical_negation"]) + "\n"
	return neg
	
def rand_name():
	upper_case = random.choice(["A", "B", "C", "D", "A", "B", "C", "D", integer])
	lower_case = random.choice(["a", "b", "c", "d", "e", "a", "b", "c", "d", "e", boolean]) #include some evil cases
	return random.choice([upper_case, lower_case])

def rand_type():
	result = random.choice([rand_name(), boolean, integer])
	return result

def array_str(a):
	result = "<<"
	for i in range(0, len(a) - 1, 1):
		result += a[i] + ", "
	result += a[len(a)-1] + ">>"
	return result
	
def tuple_str(a, b):
	result = "[\"" + a + "\", \"" + b + "\"]"
	return result

def parameter():
	amount = random.randrange(1, 10)
	result = []
	for i in range(0, amount, 1):
		tup = tuple_str(rand_name(), rand_type())
		result.append(tup)
	
	return array_str(result)

def to_string(a):
	result = "\"" + a + "\""
	return result

def garbage_command():
	return random.choice([get_const(), call_chain(), binary_op(), neg(), rand_command()])

def rand_command():
	type_check = "type_check"
	generate_code = "generate_java_code"
	add_class = "add_class(" + to_string(rand_name()) + ")"
	add_attribute = "add_attribute(" + to_string(rand_name()) + ", " + to_string(rand_name()) + ", " + to_string(rand_type()) + ")"
	add_command = "add_command(" + to_string(rand_name()) + ", " + to_string(rand_name()) + ", " + parameter() + ")"
	add_query = "add_query(" + to_string(rand_name()) + ", " + to_string(rand_name()) + ", " + parameter() + ", " + to_string(rand_name()) + ")"
	return random.choice([type_check, generate_code, add_class, add_attribute, add_attribute, add_command, add_command, add_query, add_query]) + "\n"

def ass_instruc():
	op_amount = random.randrange(1, 6)
	const_amount = random.randrange(op_amount, op_amount * 2)
	result = "add_assignment_instruction (" + to_string(rand_name()) + ", " + to_string(rand_name()) + ", " + to_string(rand_name()) + ")\n"
	dice = random.randrange(0, 3)
	if dice > 0:
		result = result + "add_assignment_instruction (" + to_string(rand_name()) + ", " + to_string(rand_name()) + ", " + to_string(rand_name()) + ")\n"
	
	while op_amount > 0 or const_amount > 0:
		dice = random.randrange(0, 3)
		if dice == 0: # const
			if const_amount > 0:
				result = result + random.choice([get_const(), call_chain()])
				const_amount = const_amount - 1
		elif dice == 1:
			if op_amount > 0:
				op_amount = op_amount - 1
				result = result + random.choice([binary_op(), neg()])
		else:
			result = result + rand_command() #add some evil garbage command 
			
	return result;

def generate_command(amount):
	result = ""
	while amount > 0:
		dice = random.choice([1,2,3])
		if dice == 1: # add instruction
			result = result + ass_instruc()
			amount = amount - 10
		elif dice == 2: # add command
			result = result + rand_command()
			amount = amount - 1
		else:
			result = result + garbage_command()
			amount = amount - 1
	return result
	

#print(generate_command(20))
#print(add_command)
#print(add_class)
#print(add_attribute)
#print(add_query)
#print(call_chain())
#print(ass_instruc())
#print(random.randrange(0, 2))
#print(array_str([tuple_str(integer, boolean)]))
#print(tuple_str("INTEGER", "INTEGER"))

#print(ass_instruc())
#print(rand_command())
#print(garbage_command())

def generate_file(index, amount):
	file_name = "at" + str(index) + ".txt"
	f = open(file_name, "w+")
	f.write(generate_command(amount))
	f.close
	
for i in range(1, 20):
	generate_file(i, 200)