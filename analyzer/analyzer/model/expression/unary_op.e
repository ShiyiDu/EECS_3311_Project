note
	description: "Summary description for {UNARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_OP
inherit EXPRESSION

create
	make

feature
	symbol: CHARACTER
	exp: detachable EXPRESSION

feature
	make(s: CHARACTER;)
		require --! means logical negation, - means numerical negation
			s ~ '!' or s ~ '-'
		do
			symbol := s
			exp := e
		end

feature {NONE}
	exp_instance: EXPRESSION
		require
			exp_not_void: exp /= void
		do
			check attached exp as e then
				result := e
			end
		end

feature

	accept(v: VISITOR)
		do
			--todo
			v.visit_unary_op(Current)
		end
	fill(new_exp:EXPRESSION)
		do
			--todo:
			if exp = void then
				exp := new_exp
			else
				exp.fill (new_exp)
			end
		end

	full:BOOLEAN
		do
			--todo:
			if exp = void then
				result := false
			else
				result := exp.full
			end
		end
end
