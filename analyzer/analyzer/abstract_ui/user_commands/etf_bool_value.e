note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_BOOL_VALUE
inherit
	ETF_BOOL_VALUE_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end
feature -- command
	bool_value(c: BOOLEAN)
    	do
			-- perform some update on the model state
			if pre_cond then
				model.bool_value (c)
			else
				set_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
