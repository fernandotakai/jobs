security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true

	loginUserDomainClass = "User"
	authorityDomainClass = "Role"
	requestMapClass = "Requestmap"
	
	useRequestMapDomainClass = false
	
	/**
	 * if useRequestMapDomainClass is false, set request map pattern in string
	 * see example below
	 */
	requestMapString = """
		CONVERT_URL_TO_LOWERCASE_BEFORE_COMPARISON
		PATTERN_TYPE_APACHE_ANT

		/login/**=IS_AUTHENTICATED_ANONYMOUSLY
		/job/create=ROLE_COMPANY
		/job/save=ROLE_COMPANY
		/job/apply/**=ROLE_EMPLOYEE
		/profile/**=IS_AUTHENTICATED_FULLY
		/**=IS_AUTHENTICATED_ANONYMOUSLY
	"""
	
}
