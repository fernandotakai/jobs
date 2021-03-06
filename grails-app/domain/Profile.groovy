class Profile {
	
	static belongsTo = [user:User]
	
	String phone
	boolean phoneShow = false
	String address
	
	static constraints = {
		address maxSize:120, nullable: false, blank:false
		phone nullable: false, blank:false
	}
	
	static mapping = {
		cache true
		tablePerHierarchy false
	}
}