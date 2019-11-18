note
	description: "Summary description for {VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR
feature
	visit_int(i: CONST_INT)
	deferred
	end

	visit_bool(b: CONST_BOOL)
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
end
