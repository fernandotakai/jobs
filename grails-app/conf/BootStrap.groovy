class BootStrap {

	def init = { servletContext ->
		if(Role.count() == 0){
			def roleCompany = new Role(authority: "ROLE_COMPANY", description: "Role for Companies")
			def roleEmployee = new Role(authority: "ROLE_EMPLOYEE", description: "Role for Employees")
			
			if(!roleCompany.save() || !roleEmployee.save()){
				throw new Exception("Could not save roles")
			}
			
			println roleCompany
			println roleEmployee
		}
		
	}
	def destroy = {
	}
} 