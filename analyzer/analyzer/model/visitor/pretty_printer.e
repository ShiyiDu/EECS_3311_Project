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
			create print_result.make_empty
		end
feature
	print_result: STRING

feature

	visit_int(i: INT_CONST)
		do
			print_result := print_result + i.value.out
		end
--------------------------------------------------------
	visit_bool(b: BOOL_CONST)
		do
			print_result := print_result + b.value.out

		end
---------------------- changes ------------------------------------	
	visit_and(a: BINARY_AND)
		do
			binary_operation(a, "&&")
		end

	visit_or(o: BINARY_OR)
		do
			binary_operation(o, "||")
		end
--------------------------------------------------------
	visit_unary_op(u: UNARY_OP)
	-- deferred
	-- Handling the expressions
		local
			pretty_print: PRETTY_PRINTER
			str: STRING
		do
			create pretty_print.make
			create str.make_empty
			if u.exp /= void then
				u.exp_instance.accept(pretty_print)
				str := pretty_print.print_result
			else
				str := "?"
			end

			print_result := "(" + u.symbol.out + " " + str + ")"

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
				i > c.chain.count
			loop
				print_result := print_result + if i /= 1 then "." else "" end + c.chain[i]
				i := i + 1
			end

		end
--------------------------------------------------------------------------------------
	visit_addition(a: BINARY_ADD)
	-- deferred

		do
			binary_operation(a, "+")

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
			print_result := "    " + out_type(a.type) + " " + a.name + ";"
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
			print_result := "  class " + c.name + " {"

			--print all attribut
			from
				i := 1
			until
				i > c.sequence.count
			loop
				if c.sequence[i].is_att then
					check attached c.sequence[i].att as att then
						att.accept(pretty_print)
					end
				else
					check attached c.sequence[i].rou as rou then
						rou.accept(pretty_print)
					end
				end
				print_result.append("%N" + pretty_print.print_result);
				i := i + 1
			end
			print_result.append ("%N  }")
		end

	visit_assignment(a: ROUTINE_ASSIGNMENT)
		local
			pretty_print: PRETTY_PRINTER
		do
			create pretty_print.make
			--name + '=' + expression
			if a.exp = void then
				if a.null then
					print_result := "      " + a.name + " = null;"
				else
					print_result := "      " + a.name + " = ?;"
				end
			else
				check attached a.exp as exp then
					exp.accept(pretty_print)
					print_result := "      " + a.name + " = " + pretty_print.print_result + ";"
				end
			end


		end

	visit_command(c: ROUTINE_COMMAND)
		local
			pretty_print: PRETTY_PRINTER
			i: INTEGER
		do
			create pretty_print.make
			c.parameters.accept(pretty_print)
			print_result :="    " + out_type(c.type) + " " + c.name + pretty_print.print_result + " {"

			from
				i := 1
			until
				i > c.assignments.count
			loop
				c.assignments[i].accept(pretty_print)
				print_result.append("%N" + pretty_print.print_result)
				i := i + 1
			end

			print_result.append("%N    }")
		end

	visit_parameters(p: ROUTINE_PARAMETERS)
		local
			i: INTEGER
			assignment: TUPLE[type:STRING; name:STRING]
		do
			print_result := ""
			if p.count > 0 then
				print_result.append ("(")
				from
					i := 1
				until
					i = p.count
				loop
					assignment := p.get_parameter(i)
					print_result.append(out_type(assignment.type) + " " + assignment.name + " , ")
					i := i + 1
				end
				assignment := p.get_parameter(i)
				print_result.append(out_type(assignment.type) + " " + assignment.name + ")")
			end
		end

	visit_query(q: ROUTINE_QUERY)
		local
			pretty_print: PRETTY_PRINTER
			i: INTEGER
		do
			create pretty_print.make
			q.parameters.accept(pretty_print)
			print_result := "    "+ out_type(q.type) + " " + q.name + pretty_print.print_result + " {"

			from
				i := 1
			until
				i > q.assignments.count
			loop
				q.assignments[i].accept(pretty_print)
				if i ~ 1 then
					pretty_print.print_result.remove_head (6)
					print_result.append("%N      " + out_type(q.type) + " " + pretty_print.print_result)
				else
					print_result.append("%N" + pretty_print.print_result)
				end

				i := i + 1
			end
			print_result.append("%N      return Result;")
			print_result.append("%N    }")
		end

feature {NONE}-- query
	out_type(actual: STRING): STRING
		do
			if actual ~ "INTEGER" then
				result := "int"
			else if actual ~ "BOOLEAN" then
				result := "bool"
			else
				result := actual
			end end
		end

	binary_operation(b: BINARY_OP; input: STRING)
		local
			binary_left: PRETTY_PRINTER
			binary_right: PRETTY_PRINTER
			left_str: STRING
			right_str: STRING
		do
			create binary_left.make
			create binary_right.make
			create left_str.make_empty
			create right_str.make_empty

			if b.left = void then
				left_str := "?"
				right_str := "nil"
			else if b.right = void then
				b.left_exp.accept (binary_left)
				left_str := binary_left.print_result

				if b.left_exp.full then
					right_str := "?"
				else
					right_str := "nil"
				end
			else
				b.left_exp.accept (binary_left)
				b.right_exp.accept (binary_right)
				left_str := binary_left.print_result
				right_str := binary_right.print_result
			end end

			print_result := "(" + left_str + " " + input + " "
			+ right_str + ")"

		end


end
