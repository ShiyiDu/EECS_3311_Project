note
	description: "Summary description for {CALL_CHAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALL_CHAIN
inherit EXPRESSION
feature
	accept(v: VISITOR)
	do
		--todo
		v.visit_call_chain(Current)
	end
end
