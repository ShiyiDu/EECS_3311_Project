note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	LANGUAGE_MODEL

inherit
	ANY
		redefine
			out
		end

create {LANGUAGE_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			program := program_access.program
			create pretty_printer.make
			create type_checker.make
		end

feature -- model attributes

	program : PROGRAM
	program_access : PROGRAM_ACCESS
	pretty_printer : PRETTY_PRINTER
	type_checker: TYPE_CHECKER

	exp: detachable EXPRESSION -- the current expression being set, void if not setting
	ass: detachable ROUTINE_ASSIGNMENT -- same as above
feature -- model operations
	default_update
			-- Perform update to the model state.
		do
		end

	reset
			-- Reset model state.
		do
			make
		end
feature --user commands
	type_check
		do
			--todo
		end

	generate_java_code
		do
			--todo
		end

	add_class(cn: STRING)
		local
			new: PROGRAM_CLASS
		do
			create new.make (cn)
			program.add_class (new)
		end

	add_attribute(cn:STRING; fn:STRING; ft:STRING)
		local
			att: CLASS_ATTRIBUTE
			cl: PROGRAM_CLASS
		do
			cl := program_access.get_class(cn);
			create att.make (ft, fn, cl)
			cl.add_attribute (att)
		end

	add_command(class_name:STRING; feature_name:STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]])
		local
			com: ROUTINE_COMMAND
			cl: PROGRAM_CLASS
		do
			cl := program_access.get_class (class_name)
			create com.make ("void", feature_name, cl)

			across pars is p loop
				com.add_parameter (p.type, p.name)
			end

			cl.add_routine (com)
		end

	add_query(cn: STRING; fn: STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]]; rt: STRING)
		local
			que: ROUTINE_QUERY
			cl: PROGRAM_CLASS
		do
			cl := program_access.get_class (cn)
			create que.make (rt, fn, cl)

			across pars is p loop
				que.add_parameter (p.type, p.name)
			end

			cl.add_routine (que)
		end

	add_assignment_instruction(cn: STRING; fn: STRING; n: STRING)
		local
			cl: PROGRAM_CLASS
			routine: CLASS_ROUTINE
			assignment: ROUTINE_ASSIGNMENT
		do
			cl := program_access.get_class (cn);
			routine := program_access.get_routine(cl, fn);
			create assignment.make (n, void, routine)
			ass := assignment
		end

	add_call_chain(chain: ARRAY[STRING])
		local
			new_chain: CALL_CHAIN
		do
			create new_chain.make (chain)
			if exp = void then
				exp := new_chain
				check attached ass as a then
					a.set_expression(new_chain)
				end
				ass := void
				exp := void
			else
				--if it is not void then we are currently setting expression

			end
			--todo: ass can not be void
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("System State: default model state ")
			Result.append ("(")
			Result.append (")")
		end

end




