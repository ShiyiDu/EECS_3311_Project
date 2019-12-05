note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_EQUALS
inherit
	ETF_EQUALS_INTERFACE
create
	make

feature {NONE}
	pre_cond: BOOLEAN
		do
			result := checker.specifying_assignment
		end

feature -- command
	equals
    	do
			-- perform some update on the model state
			if pre_cond then
				model.equal_to
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
