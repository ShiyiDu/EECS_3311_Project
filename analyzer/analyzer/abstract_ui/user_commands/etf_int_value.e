note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INT_VALUE
inherit
	ETF_INT_VALUE_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end
feature -- command
	int_value(c: INTEGER_32)
    	do
			-- perform some update on the model state
			if pre_cond then
				model.int_value (c)
			else
				set_error
			end
			
			etf_cmd_container.on_change.notify ([Current])
    	end

end
