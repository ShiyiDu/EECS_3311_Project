note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_GENERATE_JAVA_CODE
inherit
	ETF_GENERATE_JAVA_CODE_INTERFACE
create
	make
feature -- command
	generate_java_code
    	do
			-- perform some update on the model state
			--no pre-condition required, you can generate java code any time you want
			model.generate_java_code
			etf_cmd_container.on_change.notify ([Current])
    	end

end
