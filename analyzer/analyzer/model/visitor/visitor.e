note
	description: "Summary description for {VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR
feature
	visit_int(i: INT_CONST)
		deferred
		end

	visit_bool(b: BOOL_CONST)
		deferred
		end

	visit_unary_op(u: UNARY_OP)
		deferred
		end

	visit_call_chain(c: CALL_CHAIN)
		deferred
		end

	visit_addition(a: BINARY_ADD)
		deferred
		end

	visit_substraction(s: BINARY_SUB)
		deferred
		end

	visit_multiplication(m: BINARY_MULT)
		deferred
		end

	visit_division(d: BINARY_DIV)
		deferred
		end

	visit_modulo(m: BINARY_MOD)
		deferred
		end

	visit_equal(e: BINARY_EQUAL)
		deferred
		end

	visit_greater(g: BINARY_GREATER)
		deferred
		end

	visit_smaller(s: BINARY_SMALLER)
		deferred
		end
------------------------------------- changes-------------------------------------------
	visit_and(a: BINARY_AND)
		deferred
		end

	visit_or(o: BINARY_OR)
		deferred
		end
-------------------------------------------------------------------------------------------

feature --for language clauses
	visit_attribute(a: CLASS_ATTRIBUTE)
		deferred
		end

	visit_program(p: PROGRAM)
		deferred
		end

	visit_class(c: PROGRAM_CLASS)
		deferred
		end

	visit_assignment(a: ROUTINE_ASSIGNMENT)
		deferred
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
end
