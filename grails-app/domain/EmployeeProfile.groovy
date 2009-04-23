class EmployeeProfile extends Profile {
	byte[] resume
	String resumeContentType
	boolean hasResume
	
	def getExtention(){
		if(resumeContentType == "application/pdf"){
			return ".pdf"
		} else if (resumeContentType == "application/msword"){
			return ".doc"
		}
	}
	
	static constraints = {
		resume maxSize:90000, nullable:true
		resumeContentType nullable:true, inList:['application/msword', 'application/pdf']
	}
}