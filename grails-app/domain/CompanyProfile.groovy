class CompanyProfile extends Profile {
	String description
	
	static constraints = {
		description maxSize:1200
	}
}