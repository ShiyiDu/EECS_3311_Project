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

	visit_equal(e: BINARY_EQUAL)
	deferred
	end

	visit_modulo(m: BINARY_MOD)
	deferred
	end

	visit_greater(m: BINARY_GREATER)
	deferred
	end

	visit_smaller(s: BINARY_SMALLER)
	deferred
	end


end
