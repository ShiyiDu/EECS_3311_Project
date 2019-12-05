note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CALL_CHAIN
inherit
	ETF_ADD_CALL_CHAIN_INTERFACE
create
	make

feature {NONE}
	pre_cond(chain: ARRAY[STRING]): BOOLEAN
		do
			result := checker.specifying_assignment
				and not checker.empty_call_chain (chain)
		end

feature -- command
	add_call_chain(chain: ARRAY[STRING])
    	do
			-- perform some update on the model state
			if pre_cond(chain) then
				model.add_call_chain (chain)
			else
				set_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
