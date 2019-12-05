note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DISJUNCTION
inherit
	ETF_DISJUNCTION_INTERFACE
create
	make
feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end

feature -- command
	disjunction
    	do
			-- perform some update on the model state
			if pre_cond then
				model.disjunc
			else
				set_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
