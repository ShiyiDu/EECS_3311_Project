note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION
feature --public features, they should not be changed
	accept(v: VISITOR)
		deferred
		end

	fill(exp: EXPRESSION)
		--fill the expression
		require
			can_be_filled: not full
		deferred
		end

	full:BOOLEAN
		--can the expression be filled with more constant/call chain
		deferred
		end
end
