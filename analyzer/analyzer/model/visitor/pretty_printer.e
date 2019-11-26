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
	create print_result.make

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

	visit_equals_to(e: BINARY_EQUALS_TO)
		do
			binary_operation(d, "==")
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
				print_result := print_result + (if i /= 1 then "." end) + c[i]
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
			binary_operation(m, "%")
		end

	visit_greater(m: BINARY_GREATER)
		do
			binary_operation(m, ">")
		end

	visit_smaller(s: BINARY_SMALLER)
		do
			binary_operation(s, "<")
		end

feature {NONE}-- query
	binary_operation(b: BINARY_OP, input: STRING)
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
