note
	description: "Summary description for {CALL_CHAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALL_CHAIN
inherit EXPRESSION

create
	make

feature
	chain: ARRAY[STRING]

feature
	make(c: ARRAY[STRING])
	do
		chain := c
	end

feature
	accept(v: VISITOR)
	do
		--todo
		v.visit_call_chain(Current)
	end
end
