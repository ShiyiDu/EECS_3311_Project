note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			program := program_access.program
			state := 1
			error_msg := "OK."
			create pretty_printer.make
			create type_checker.make
			create java_code.make_empty
		end

feature -- model attributes

	program : PROGRAM
	program_access : PROGRAM_ACCESS
	pretty_printer : PRETTY_PRINTER
	type_checker: TYPE_CHECKER
	error_checker: ERROR_CHECKER
	java_code: STRING

	state: INTEGER
	default_state: INTEGER = 1
	generate_code: INTEGER = 2
	type_checking: INTEGER = 3

	error_msg: STRING
	set_error(msg: STRING)
		do
			error_msg := msg
		end

	ass: detachable ROUTINE_ASSIGNMENT -- the current assignment to be filled
feature -- model operations
	reset
			-- Reset model state.
		do
			make
		end
feature --user commands
	type_check
		require
			not error_checker.specifying_assignment
		do
			--todo
			state := type_checking
		end

	generate_java_code
		do
			--todo
			pretty_printer.make
			program.accept (pretty_printer)
			java_code := pretty_printer.print_result
			state := generate_code
		end

	add_class(cn: STRING)
		require
			not error_checker.specifying_assignment
			and not error_checker.class_exists (cn)
		local
			new: PROGRAM_CLASS
		do
			create new.make (cn)
			program.add_class (new)
		end

	add_attribute(cn:STRING; fn:STRING; ft:STRING)
		require
			not error_checker.specifying_assignment
			and error_checker.class_exists (cn)
			and not error_checker.feature_exists (cn, fn)
			and not error_checker.type_not_exist (ft)
		local
			att: CLASS_ATTRIBUTE
			cl: PROGRAM_CLASS
		do
			cl := program_access.get_class(cn);
			create att.make (ft, fn, cl)
			cl.add_attribute (att)
		end

	add_command(class_name:STRING; feature_name:STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]])
		require
			not error_checker.specifying_assignment
			and error_checker.class_exists (class_name)
			and not error_checker.feature_exists (class_name, feature_name)
			and not error_checker.name_clash (class_name, pars)
			and not error_checker.duplicated_parameter (pars)
			and not error_checker.par_type_not_exist (pars)
		local
			com: ROUTINE_COMMAND
			cl: PROGRAM_CLASS
		do
			cl := program_access.get_class (class_name)
			create com.make ("void", feature_name, cl)

			across pars is p loop
				com.add_parameter (p.type, p.name)
			end

			cl.add_command (com)
		end

	add_query(cn: STRING; fn: STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]]; rt: STRING)
		require
			not error_checker.specifying_assignment
			and error_checker.class_exists (cn)
			and not error_checker.feature_exists (cn, fn)
			and not error_checker.name_clash (cn, pars)
			and not error_checker.duplicated_parameter (pars)
			and not error_checker.par_type_not_exist (pars)
			and not error_checker.type_not_exist (rt)
		local
			que: ROUTINE_QUERY
			cl: PROGRAM_CLASS
		do
			cl := program_access.get_class (cn)
			create que.make (rt, fn, cl)

			across pars is p loop
				que.add_parameter (p.type, p.name)
			end

			cl.add_query (que)
		end

	add_assignment_instruction(cn: STRING; fn: STRING; n: STRING)
		require
			not error_checker.specifying_assignment
			and error_checker.class_exists (cn)
			and error_checker.feature_exists (cn, fn)
			and not error_checker.feature_is_attribute (cn, fn)
		local
			cl: PROGRAM_CLASS
			routine: CLASS_ROUTINE
			assignment: ROUTINE_ASSIGNMENT
		do
			cl := program_access.get_class (cn);
			routine := program_access.get_routine(cl, fn);
			create assignment.make (n, void, routine)
			ass := assignment
			routine.add_assignment (my_ass)
		end

	add_call_chain(chain: ARRAY[STRING])
		require
			error_checker.specifying_assignment
			and not error_checker.empty_call_chain (chain)
		local
			new_chain: CALL_CHAIN
		do
			create new_chain.make (chain)

			my_ass.add_expression (new_chain)

			check_assignment

			--todo: ass can not be void
		end

	bool_value(c: BOOLEAN)
		require
			error_checker.specifying_assignment
		local
			new_exp: BOOL_CONST
		do
			create new_exp.make (c)
			my_ass.add_expression (new_exp)
			check_assignment
		end

	int_value(c: INTEGER)
		require
			error_checker.specifying_assignment
		local
			new_int: INT_CONST
		do
			create new_int.make (c)
			my_ass.add_expression (new_int)
			check_assignment
		end

	add
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_ADD}.make)
		end

	sub
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_SUB}.make)
		end

	mult
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_MULT}.make)
		end

	div --quotient
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_DIV}.make)
		end

	mod
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_MOD}.make)
		end

	conjunc
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_AND}.make)
		end

	disjunc
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_OR}.make)
		end

	equal_to
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_EQUAL}.make)
		end

	greater
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_GREATER}.make)
		end

	less
		require
			error_checker.specifying_assignment
		do
			my_ass.add_expression (create {BINARY_SMALLER}.make)
		end

	num_neg
		require
			error_checker.specifying_assignment
		local
			neg: UNARY_OP
		do
			create neg.make ('-')
			my_ass.add_expression (neg)
			--todo
		end

	logic_neg
		require
			error_checker.specifying_assignment
		local
			neg: UNARY_OP
		do
			create neg.make ('!')
			my_ass.add_expression (neg)
			--todo
		end

	check_assignment -- if the assignment is filled, add it to class
		do
			if my_ass.expression_full then
				ass := void
			end
		end
feature {ERROR_CHECKER} --helper
	my_ass: ROUTINE_ASSIGNMENT
		do
			check attached ass as a then
				result := a
			end
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("")
			type_checker.make
			inspect state
			when default_state then
				Result.append ("  Status: " + error_msg)
				error_msg := "OK."
				Result.append (program.out)
				if ass /= void then
					Result.append ("%N  Routine currently being implemented: " + "{")
					Result.append (my_ass.routine.parent_class.name + "}.")
					Result.append (my_ass.routine.name)
					Result.append ("%N  Assignment being specified: " + my_ass.out)
				end
			when generate_code then
				Result.append(java_code);
				state := default_state
			when type_checking then
				--todo: print type checking result

				program.accept (type_checker)

				Result.append (type_checker.error_msg)
				if not Result.is_empty then Result.remove (1) end
				state := default_state
			else

			end
		end
end




