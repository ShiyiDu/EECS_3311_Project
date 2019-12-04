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

feature
	make
		do
			value := false
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

			if u.exp /= void then
				u.exp_instance.accept(checker)
			else
				--todo: error?	
			end
			type := checker.type
		end

	visit_call_chain(c: CALL_CHAIN)
		local
			current_class: PROGRAM_CLASS --the current class being accessing and checking
			current_routine: CLASS_ROUTINE
		do
			current_class := c.get_ass.routine.parent_class
			current_routine := c.get_ass.routine;
			--the first one checks for both attributes and parameters

			if program_access.contain_attribute (current_class, c.chain[1]) then
				current_class := program_access.get_attribute_type (current_class, c.chain[1])
			end

			--todo: you need to find if there is an attribute in the class fields
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

	visit_equal(e: BINARY_EQUAL)
		do
			visit_binary(e, "INTEGER")
		end

	visit_modulo(m: BINARY_MOD)
		do
			visit_binary(m, "INTEGER")
		end

	visit_greater(g: BINARY_GREATER)
		do
			visit_binary(g, "INTEGER")
		end

	visit_smaller(s: BINARY_SMALLER)
		do
			visit_binary(s, "INTEGER")
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
				c.accept(type_check)
				value := type_check.value and value
			end
		end

	visit_class(c: PROGRAM_CLASS)
		local
			type_check: TYPE_CHECKER
		do
			value := true
			create type_check.make
			--all attributes type correct, all routine type correct
			across c.queries is r loop
				r.accept(type_check)
				value := type_check.value and value
			end

			across c.commands is r loop
				r.accept(type_check)
				value := type_check.value and value
			end

		end

	visit_assignment(a: ROUTINE_ASSIGNMENT)
		local
			exp_check: TYPE_CHECKER
		do
			--todo: the expression is type correct and matches the type of name
			create exp_check.make
			check attached a.exp as e then
				e.accept (exp_check)
			end

			--check parameter in routine and attribute in the corrsponding class
			if program_access.contain_parameter(a.routine, a.name) then
				type := program_access.get_parameter_type(a.routine, a.name)
				value := exp_check.type ~ type
			else if program_access.contain_attribute(a.routine.parent_class, a.name) then
				type := program_access.get_attribute_type(a.routine.parent_class, a.name)
				value := exp_check.type ~ type
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
		do
			--check for every assignment for correctness
			create ass_check.make
			value := true
			across r.assignments is ass loop
				ass.accept(ass_check)
				value := value and ass_check.value
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


			value := left.type ~ right.type

	------------------------------ changes (not sure) ----------------------------------------
			value := (left.type ~ t) and (right.type ~ t)
	-------------------------------------------------------------------------------
		end

---------------------------------- changes (not sure)----------------------------------	
--	visit_logical(a: BINARY_OP)
--	local
--		left, right: TYPE_CHECKER
--	do
--		create {TYPE_CHECKER} left.make
--		create {TYPE_CHECKER} right.make
--		a.left.accept(left)
--		a.right.accept(right)
--	    value := (left.type ~ "bool") and (right.type ~ "bool")
--	end

-------------------------------------------------------------------------------------	

end
