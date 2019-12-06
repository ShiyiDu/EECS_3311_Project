note
	description: "Summary description for {TYPE_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CHECKER

inherit VISITOR

create
	make

feature
	value: BOOLEAN
	error_msg: STRING

feature
	make
		do
			value := false
			create error_msg.make_empty
			create type.make_empty
		end

feature
	visit_int(i: INT_CONST)
		do
			value := true
			type := "INTEGER"
		end

	visit_bool(b: BOOL_CONST)
		do
			value := true
			type := "BOOLEAN"
		end

	visit_unary_op(u: UNARY_OP)
		local
			checker: TYPE_CHECKER
		do
			--todo: maybe expression must be a boolean value??
			value := true
			create checker.make

			if u.symbol ~ '!' then
				type := "BOOLEAN"
			else
				type := "INTEGER"
			end

			u.exp_instance.accept(checker)
			if type ~ checker.type then
				value := true and checker.value
			else
				value := false
			end
		end

	visit_call_chain(c: CALL_CHAIN)
		local
			current_class: PROGRAM_CLASS --the current class being accessing and checking
			current_routine: CLASS_ROUTINE
			class_name: STRING
			i: INTEGER
		do
			current_class := c.get_ass.routine.parent_class
			current_routine := c.get_ass.routine;
			--the first one checks for both attributes and parameters
			value := true
			i := 1
			--if parameter exist, skip i to 2 and change class to the coresponding one
			if program_access.contain_parameter (current_routine, c.chain[i]) then
				class_name := program_access.get_parameter_type (current_routine, c.chain[i])
				if class_name ~ "BOOLEAN" or class_name ~ "INTEGER" then
					--the call chain should end here
					if c.chain.count > i then
						value := false
					else
						type := class_name
					end
					i := c.chain.count + 1 --skip the loop
				else
					current_class := program_access.get_class (class_name)
					type := class_name
					i := 2
				end
			end

			from
			until
				i > c.chain.count
			loop
				if program_access.contain_attribute (current_class, c.chain[i]) then
					class_name := program_access.get_attribute_type (current_class, c.chain[i])
					if class_name ~ "BOOLEAN" or class_name ~ "INTEGER" then
						--the call chain should end here
						if c.chain.count > i then
							value := false
						else
							type := class_name
						end
						i := c.chain.count + 1 --skip the loop
					else
						current_class := program_access.get_class (class_name)
						type := class_name
					end
				else
					value := false
					i := c.chain.count + 1 --skip the loop
				end

				i := i + 1
			end

			--if it is Result, and the routine is a query, override everything we have done
			if c.chain.count = 1 and c.chain[1] ~ "Result" and c.get_ass.routine.type /~ "void" then
				value := true
				type := c.get_ass.routine.type --not void!!
			end
		end

	visit_addition(a: BINARY_ADD)
		do
			visit_binary(a, "INTEGER")
		end

	visit_substraction(s: BINARY_SUB)
		do
			visit_binary(s, "INTEGER")
		end

	visit_multiplication(m: BINARY_MULT)
		do
			visit_binary(m, "INTEGER")
		end

	visit_division(d: BINARY_DIV)
		do
			visit_binary(d, "INTEGER")
		end

	visit_modulo(m: BINARY_MOD)
		do
			visit_binary(m, "INTEGER")
		end

	visit_equal(e: BINARY_EQUAL)
		do
			visit_binary(e, "INTEGER")
			type := "BOOLEAN"
		end

	visit_greater(g: BINARY_GREATER)
		do
			visit_binary(g, "INTEGER")
			type := "BOOLEAN"
		end

	visit_smaller(s: BINARY_SMALLER)
		do
			visit_binary(s, "INTEGER")
			type := "BOOLEAN"
		end
----------------------------------------- changes --------------------------------------	
	visit_and(a: BINARY_AND)
		do
			visit_binary(a, "BOOLEAN")
		end

	visit_or(o: BINARY_OR)
		do
			visit_binary(o, "BOOLEAN")
		end

feature --language clauses
	visit_attribute(a: CLASS_ATTRIBUTE)
		do
			value := true --the type check for attribute is done during input
			type := a.type
		end

	visit_program(p: PROGRAM)
		local
			type_check: TYPE_CHECKER
		do
			value := true
			create type_check.make
			across p.classes is c loop
				type_check.make
				c.accept(type_check)
				if not type_check.value then
					value := false
					error_msg.append ("%N  class " + c.name + " is not type-correct:")
					error_msg.append (type_check.error_msg)
				else
					error_msg.append ("%N  class " + c.name + " is type-correct.")
				end
			end
		end

	visit_class(c: PROGRAM_CLASS)
		local
			type_check: TYPE_CHECKER
		do
			value := true
			create type_check.make
			--all attributes type correct, all routine type correct

			across c.routines is r loop
				type_check.make
				r.accept(type_check)
				if not type_check.value then
					value := false
					error_msg.append (type_check.error_msg)
				end
			end

		end

	visit_assignment(a: ROUTINE_ASSIGNMENT)
		local
			exp_check: TYPE_CHECKER
		do
			--todo: the expression is type correct and matches the type of name
			value := false

			create exp_check.make
			if not a.null then
				check attached a.exp as e then
					e.accept (exp_check)
				end
				value := exp_check.value
			end

			--check parameter in routine and attribute in the corrsponding class
			if program_access.contain_parameter(a.routine, a.name) then
				type := program_access.get_parameter_type(a.routine, a.name)
				if not a.null then
					value := (exp_check.type ~ type) and value
				else
					value := true
				end
			else if program_access.contain_attribute(a.routine.parent_class, a.name) then
				type := program_access.get_attribute_type(a.routine.parent_class, a.name)
				if not a.null then
					value := (exp_check.type ~ type) and value
				else
					value := true
				end
			else
				value := false
			end
			end

		end

	visit_command(c: ROUTINE_COMMAND)
		do
			visit_routine(c)
		end

	visit_parameters(p: ROUTINE_PARAMETERS)
		do
			--todo
			value := true
		end

	visit_query(q: ROUTINE_QUERY)
		do
			visit_routine(q)
		end

feature {TYPE_CHECKER} --helper method
	type: STRING --int, boolean, void, name

	program_access: PROGRAM_ACCESS

	visit_routine(r: CLASS_ROUTINE)
		local
			ass_check: TYPE_CHECKER
			printer: PRETTY_PRINTER
		do
			--check for every assignment for correctness
			create ass_check.make
			create printer.make
			value := true
			across r.assignments is ass loop
				printer.make
				ass_check.make
				ass.accept(ass_check)
				if not ass_check.value then
					ass.accept(printer)
					printer.print_result.remove_tail (1)
					printer.print_result.remove_head (2)
					error_msg.append ("%N" + printer.print_result + " in routine " + r.name + " is not type-correct.")
					value := false
				end
			end
		end


	visit_binary(a:BINARY_OP; t:STRING)
		local
			left, right: TYPE_CHECKER
		do
			create {TYPE_CHECKER} left.make
			create {TYPE_CHECKER} right.make

			check attached a.left as l then
				check attached a.right as r then
					l.accept(left)
					r.accept(right)
				end
			end

			value := (left.type ~ t) and (right.type ~ t) and left.value and right.value
			type := t
		end

end
