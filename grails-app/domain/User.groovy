class User {
	static transients = ['pass']
	static hasMany = [authorities: Role]
	static belongsTo = Role

	String username
	String userRealName
	String passwd
	boolean enabled

	String email
	boolean emailShow

	String description = ''

	String pass = '[secret]'
	
	Profile profile
	
	String type

	static constraints = {
		username(blank: false, unique: true)
		userRealName(blank: false)
		passwd(blank: false)
		profile(nullable:true)
		type(inList:['employee', 'company'])
		enabled()
		email(email:true)
	}
	
	static mapping = {
		cache true
	}
	
	boolean equals(other){
		(other instanceof User) && this.username.equals(other?.username)
	}
	
	int hashCode(){
		int result = 17; 
		result = 31 * result + username.hashCode(); 
		return result
	}
	
	def jobsApplied(){
		if(type == "company")
			throw new IllegalAccessException("Companies do not have jobs!")
			
		def user = this
		
		Job.withCriteria { 
			appliers { 
				eq('username', user.username) 
			} 
			cache true
		}
	}
}
