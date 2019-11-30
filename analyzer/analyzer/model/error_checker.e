note
	description: "Summary description for {ERROR_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ERROR_CHECKER

feature{NONE}
	program_access: PROGRAM_ACCESS

	program: PROGRAM
		do
			result := program_access.program
		end

feature --enquires


end
