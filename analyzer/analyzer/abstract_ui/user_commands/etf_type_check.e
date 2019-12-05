note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TYPE_CHECK
inherit
	ETF_TYPE_CHECK_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := not checker.specifying_assignment
		end
feature -- command
	type_check
    	do
			-- perform some update on the model state
			if pre_cond then
				model.type_check
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
