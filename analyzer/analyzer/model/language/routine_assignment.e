note
	description: "Summary description for {ROUTINE_ASSIGNMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_ASSIGNMENT

inherit
	ANY
		redefine out
	end

create
	make

feature
	name: STRING --name can be attribute in the class, parameter in the routine
	exp: detachable EXPRESSION --name = NULL if it is void
	routine: CLASS_ROUTINE -- the parent routine this assignment is in

feature
	make(new_name: STRING; new_exp: detachable EXPRESSION; new_routine: CLASS_ROUTINE)
		do
			name := new_name
			exp := new_exp
			routine := new_routine
		end
	accept(v:VISITOR)
		do
			v.visit_assignment (current)
		end

	add_expression(expression: EXPRESSION)
		require
			can_be_filled: not expression_full
		do
			expression.set_ass (current)
			if exp = void then
				exp := expression
			else
				check attached exp as e then
					e.fill(expression)
				end
			end
		end
	expression_full: BOOLEAN
		do
			if exp = void then
				result := false
			else
				check attached exp as e then
					result := e.full
				end
			end
		end

feature
	out: STRING
		local
			printer: PRETTY_PRINTER
			str: STRING
		do
			create printer.make
			str := "?"
			result := name + " := "
			if exp /= void then
				check attached exp as e then
					e.accept (printer)
					str := printer.print_result
				end
			end

			result.append (str)
		end
end
