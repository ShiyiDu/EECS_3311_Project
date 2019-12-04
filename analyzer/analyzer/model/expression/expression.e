note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION
--inherit
--	ANY
--		undefine out
--	end
feature --public features, they should not be changed

	ass: detachable ROUTINE_ASSIGNMENT

	set_ass(new_ass: ROUTINE_ASSIGNMENT)
		do
			ass := new_ass
		end

	get_ass: ROUTINE_ASSIGNMENT
		do
			check attached ass as a then
				result := a
			end
		end

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

--	out: STRING
--		deferred
--		end
end
