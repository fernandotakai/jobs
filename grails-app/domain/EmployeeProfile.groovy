class EmployeeProfile extends Profile {
	byte[] resume
	String resumeContentType
	
	static constraints = {
		resume maxSize:90000, nullable:true
	}
}