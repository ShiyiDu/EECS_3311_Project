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

	visit_addition(a: BINARY_ADD)
	deferred
	end

	visit_substraction(a: BINARY_ADD)
	deferred
	end

end
