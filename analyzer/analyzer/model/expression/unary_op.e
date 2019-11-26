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
	exp: EXPRESSION

feature
	make(s: CHARACTER; e: EXPRESSION)
		require
			s ~ '!' or s ~ '-'
		do
			symbol := s
			exp := e
		end

feature
	accept(v: VISITOR)
		do
			--todo
			v.visit_unary_op(Current)
		end
end
