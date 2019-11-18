note
	description: "Summary description for {INTEGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INT_CONST
inherit EXPRESSION

feature
	accept(v: VISITOR)
	do
		v.visit_int(Current)

	end
end
