note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_GREATER_THAN
inherit
	ETF_GREATER_THAN_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end
feature -- command
	greater_than
    	do
			-- perform some update on the model state
			if pre_cond then
				model.greater
			else
				set_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
