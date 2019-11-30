note
	description: "Summary description for {INTEGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INT_CONST
inherit EXPRESSION

create
	make

feature
	value: INTEGER

feature
	make(i: INTEGER)
		require
			value_in_range: 0 <= i and i <= 9
		do
			value := i
		end

feature
	accept(v: VISITOR)
		do
			v.visit_int(Current)

		end
	fill(exp: EXPRESSION)
		do
			
		end

	full: BOOLEAN
		--constant is already filled
		do
			result := true
		end
end
