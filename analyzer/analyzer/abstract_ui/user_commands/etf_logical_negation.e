note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_LOGICAL_NEGATION
inherit
	ETF_LOGICAL_NEGATION_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end
feature -- command
	logical_negation
    	do
			-- perform some update on the model state
			if pre_cond then
				model.logic_neg
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
