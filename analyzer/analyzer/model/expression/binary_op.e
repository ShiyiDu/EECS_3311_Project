note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BINARY_OP
inherit EXPRESSION COMPOSITE

feature
	make
		do
			left := void
			right := void
			parent := void
		end

feature

	fill(exp:EXPRESSION)
		do

		end

	has_right: BOOLEAN
		do
			result := right /= void
		end

	has_left: BOOLEAN
		do
			result := left /= void
		end

	set_right(exp: EXPRESSION)
		do
			right := exp
		end

	set_left(exp: EXPRESSION)
		do
			left := exp
		end

	set_parent(exp: EXPRESSION)
		do
			parent := exp
		end
	accept(v: VISITOR)
		deferred
		end
end
