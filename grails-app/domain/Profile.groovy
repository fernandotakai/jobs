class Profile {
	
	static belongsTo = [user:User]
	
	String phone
	String address
	
	static constraints = {
		address maxSize:120
	}
	
	static mapping = {
		cache true
		tablePerHierarchy false
	}
}