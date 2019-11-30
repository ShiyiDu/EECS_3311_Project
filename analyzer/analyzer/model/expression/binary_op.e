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
	left_exp: EXPRESSION
		do
			check attached left as l then
				result := l
			end
		end

	right_exp: EXPRESSION
		do
			check attached right as r then
				result := r
			end
		end

feature

	fill(exp:EXPRESSION)
		do
			--recursively filling the expression in post-order
			if not has_left then
				left := exp
			else if not left_exp.full then
				left_exp.fill (exp)
			else if not has_right then
				right := exp
			else if not right_exp.full then
				right_exp.fill (exp)
			end end end end
		end

	full: BOOLEAN
		do
			if left /= void and right /= void then
				result := left_exp.full and right_exp.full
			else
				result := false
			end
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
