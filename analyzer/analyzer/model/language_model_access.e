note
	description: "Singleton access to the default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	LANGUAGE_MODEL_ACCESS

feature
	m: LANGUAGE_MODEL
		once
			create Result.make
		end

invariant
	m = m
end




