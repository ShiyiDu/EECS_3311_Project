note
	description: "Summary description for {PRETTY_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRETTY_PRINTER
inherit
	VISITOR
create
	make

feature -- Constructor
	make
		do
			create print_result.make
		end
feature
	print_result: STRING

feature

	visit_int(i: INT_CONST)
		do
			print_result := print_result + i.value
		end
--------------------------------------------------------
	visit_bool(b: BOOL_CONST)
		do
			print_result := print_result + b.value

		end
---------------------- changes ------------------------------------	
	visit_and(a: BINARY_AND)
		do
			binary_operation(d, "&&")
		end

	visit_or(o: BINARY_OR)
		do
			binary_operation(d, "||")
		end
--------------------------------------------------------
	visit_unary_op(u: UNARY_OP)
	-- deferred
	-- Handling the expressions
		local
	--		unary_left: CHARACTER
			unary_right: PRETTY_PRINTER
		do
	--		create unary_left.make
			create unary_right.make
			u.exp.accept(unary_right)

			 print_result := "( " + u.symbol + " " + unary_right.value + ")"

		end
	--------------------------------------------------------------------------------------
	visit_call_chain(c: CALL_CHAIN)
		local
			i: INTEGER
	--	deferred
	--	end
		do
			from
				i := 1
			until
				i > c.upper
			loop
				print_result := print_result + if i /= 1 then "." else "" end + c[i]
				i := i + 1
			end

		end
--------------------------------------------------------------------------------------
	visit_addition(a: BINARY_ADD)
	-- deferred

		do
			print_result := binary_operation(a, "+")

		end
----------------------------------------------------------------------------------------

	visit_substraction(s: BINARY_SUB)

		do
			binary_operation(s, "-")
		end
--------------------------------------------------------------------------------------
	visit_multiplication(m: BINARY_MULT)
		do
			binary_operation(m, "*")
		end

	visit_division(d: BINARY_DIV)
		do
			binary_operation(d, "/")
		end

	visit_equal(e: BINARY_EQUAL)
		do
			binary_operation(e, "==")
		end

	visit_modulo(m: BINARY_MOD)
		do
			binary_operation(m, "%%")
		end

	visit_greater(m: BINARY_GREATER)
		do
			binary_operation(m, ">")
		end

	visit_smaller(s: BINARY_SMALLER)
		do
			binary_operation(s, "<")
		end

feature -- for language clauses
	visit_attribute(a: CLASS_ATTRIBUTE)
		do
			print_result := a.type + " " + a.name + ";"
		end

	visit_program(p: PROGRAM)
		local
			i : INTEGER
			pretty_print : PRETTY_PRINTER
		do
			create pretty_print.make
			from
				i := 1
			until
				i > p.classes.count
			loop
				p.classes[i].accept(pretty_print)
				print_result.append(pretty_print.print_result)
				if i /= p.classes.count then
					print_result.append("%N")
				end
				i := i+1
			end

		end

	visit_class(c: PROGRAM_CLASS)
		local
			i : INTEGER
			pretty_print : PRETTY_PRINTER
		do
			create pretty_print.make
			print_result := "class " + c.name + " {"

			--print all attribut
			from
				i := 1
			until
				i > c.attributes.count
			loop
				c.attributes[i].accept(pretty_print)
				print_result.append("%N" + pretty_print.print_result);
				i := i + 1
			end

			from
				i := 1
			until
				i > c.routines.count
			loop
				c.routines[i].accept(pretty_print)
				print_result.append("%N" + pretty_print.print_result);
				i := i + 1
			end

			print_result := "%N}"
		end

	visit_assignment(a: ROUTINE_ASSIGNMENT)
		local
			pretty_print: PRETTY_PRINTER
		do
			create pretty_print.make
			--name + '=' + expression
			if a.exp = void then
				print_result := a.name + " = null;"
			else
				check attached a.exp as exp then
					exp.accept(pretty_print)
					print_result := a.name + " = " + pretty_print.print_result + ";"
				end
			end


		end

	visit_command(c: ROUTINE_COMMAND)
		local
			pretty_print: PRETTY_PRINTER
			i: INTEGER
		do
			c.parameters.accept(pretty_print)
			print_result := c.type + " " + c.name + pretty_print.print_result + " {"

			from
				i := 1
			until
				i > c.assignments.count
			loop
				c.assignments[i].accept(pretty_print)
				print_result.append(pretty_print.print_result + "%N")
				i := i + 1
			end

			print_result.append("}")
		end

	visit_parameters(p: ROUTINE_PARAMETERS)
		local
			i: INTEGER
			assignment: TUPLE[STRING, STRING]
		do
			print_result := ""
			if p.count > 0 then
				print_result := "("
				from
					i := 1
				until
					i = p.count
				loop
					assignment := p.get_parameter(i)
					print_result.append(assignment[0] + " " + assignment[1] + " , ")
					i := i + 1
				end
				assignment := p.get_parameter(i)
				print_result.append(assignment[0] + " " + assignment[1] + ")")
			end
		end

	visit_query(q: ROUTINE_QUERY)
		local
			pretty_print: PRETTY_PRINTER
			i: INTEGER
		do
			c.parameters.accept(pretty_print)
			print_result := c.type + " " + c.name + pretty_print.print_result + " {%N"

			print_result := c.type + " "
			from
				i := 1
			until
				i > c.assignments.count
			loop
				c.assignments[i].accept(pretty_print)
				print_result.append(pretty_print.print_result + "%N")
				i := i + 1
			end
			print_result.append("return Result;%N")
			print_result.append("}")
		end

feature {NONE}-- query
	binary_operation(b: BINARY_OP; input: STRING)
		local
			binary_left: PRETTY_PRINTER
			binary_right: PRETTY_PRINTER

		do
			b.left.accept(binary_left)
			b.left.accept(binary_right)
			Result := "(" + " " + binary_left.value + " " + input + " "
			+ binary_right.value + ")"

		end


end
