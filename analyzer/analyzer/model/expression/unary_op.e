note
	description: "Summary description for {UNARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_OP
inherit EXPRESSION


feature
	accept(v: VISITOR)
	do
		--todo
		v.visit_unary_op(Current)
	end
end
