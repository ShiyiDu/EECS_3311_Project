note
	description: "Summary description for {BOOL_CONST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOL_CONST
inherit EXPRESSION

feature
	value: BOOLEAN

feature
	accept(v: VISITOR)
	do
		v.visit_bool(current)
	end
end
