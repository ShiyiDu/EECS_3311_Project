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
		end

feature
	visit_int(i: INT_CONST)
		do
			value := true
			type := "int"
		end

	visit_bool(b: BOOL_CONST)
		do
			value := true
			type := "bool"
		end

	visit_unary_op(u: UNARY_OP)
		local
			checker: TYPE_CHECKER
		do
			--todo: maybe expression must be a boolean value??
			value := true
			create checker.make

			u.exp.accept(checker)
			type := checker.type
		end

	visit_call_chain(c: CALL_CHAIN)
		do
			value := true
			--todo: you need to find if there is an attribute in the class fields
		end

	visit_addition(a: BINARY_ADD)
		do
			visit_binary(a, "int")
		end

	visit_substraction(s: BINARY_SUB)
		do
			visit_binary(s, "int")
		end

	visit_multiplication(m: BINARY_MULT)
		do
			visit_binary(m, "int")
		end

	visit_division(d: BINARY_DIV)
		do
			visit_binary(d, "int")
		end

	visit_equal(e: BINARY_EQUAL)
		do
			visit_binary(e, "int")
		end

	visit_modulo(m: BINARY_MOD)
		do
			visit_binary(m, "int")
		end

	visit_greater(g: BINARY_GREATER)
		do
			visit_binary(g, "int")
		end

	visit_smaller(s: BINARY_SMALLER)
		do
			visit_binary(s, "int")
		end
----------------------------------------- changes --------------------------------------	
	visit_and(a: BINARY_AND)
		do
			visit_binary(o, "bool")
		end

	visit_or(o: BINARY_OR)
		do
			visit_binary(o, "bool")
		end

feature --language clauses
	visit_attribute(a: CLASS_ATTRIBUTE)
		do
			value := true --the type check for attribute is done during input
			current.type := a.type
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
			across p.routines is r loop
				r.accept(type_check)
				value := type_check.value and value
			end

		end

	visit_assignment(a: ROUTINE_ASSIGNMENT)
		local
			type_check: TYPE_CHECKER
		do
			--todo: the expression is type correct and matches the type of name
			create type_check.make
			a.accept(type_check)
			value := type_check.value
		end

	visit_command(c: ROUTINE_COMMAND)
		deferred
		end

	visit_parameters(p: ROUTINE_PARAMETERS)
		deferred
		end

	visit_query(q: ROUTINE_QUERY)
		deferred
		end

feature {NONE} --helper method
	type: STRING --int, boolean, void, name

	visit_binary(a:BINARY_OP; t:STRING)
		local
			left, right: TYPE_CHECKER
		do
			create {TYPE_CHECKER} left.make
			create {TYPE_CHECKER} right.make
			a.left.accept(left)
			a.right.accept(right)

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
