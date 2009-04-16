class Job {
	
	static hasMany = [appliers:User]
	
	static searchable = [only:['title', 'description']]
	
	String title
	String description
	User company
	Date dateCreated
	
    static constraints = {
		title maxSize:40
		description maxSize:500
    }
}
