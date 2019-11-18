note
	description: "Summary description for {BOOL_CONST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOL_CONST
inherit EXPRESSION

create make

feature
	value: BOOLEAN

feature
	make(b: BOOLEAN)
	do
		value := b
	end

feature
	accept(v: VISITOR)
	do
		v.visit_bool(current)
	end
end
