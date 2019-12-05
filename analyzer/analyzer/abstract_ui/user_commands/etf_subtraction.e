note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SUBTRACTION
inherit
	ETF_SUBTRACTION_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end
feature -- command
	subtraction
    	do
			-- perform some update on the model state
			if pre_cond then
				model.sub
			else
				set_error
			end
			
			etf_cmd_container.on_change.notify ([Current])
    	end

end
