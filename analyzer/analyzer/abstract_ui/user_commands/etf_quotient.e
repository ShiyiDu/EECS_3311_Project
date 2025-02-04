note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_QUOTIENT
inherit
	ETF_QUOTIENT_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end
feature -- command
	quotient
    	do
			-- perform some update on the model state
			if pre_cond then
				model.div
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
