security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true

	loginUserDomainClass = "User"
	authorityDomainClass = "Role"
	requestMapClass = "Requestmap"
	
	useRequestMapDomainClass = false
	
	requestMapString = """
		CONVERT_URL_TO_LOWERCASE_BEFORE_COMPARISON
		PATTERN_TYPE_APACHE_ANT

		/login/**=IS_AUTHENTICATED_ANONYMOUSLY
		/job/create=ROLE_COMPANY
		/job/save=ROLE_COMPANY
		/job/apply/**=ROLE_EMPLOYEE
		/job/cancel/**=ROLE_EMPLOYEE
		/job/delete/**=ROLE_COMPANY
		/job/closeopen/**=ROLE_COMPANY
		/profile/**=IS_AUTHENTICATED_FULLY
		/**=IS_AUTHENTICATED_ANONYMOUSLY
	"""
	
}
