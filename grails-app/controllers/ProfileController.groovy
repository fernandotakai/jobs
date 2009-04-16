import org.undone.utils.CustomMultipartResolver

class ProfileController {
	
	def index = {
		def user = getLoggedUser()
		if(!user.profile){
			redirect(action:"create")
		}
		
		return [profile:user.profile, type:user.type, user:user]
	}
	
	def create = {
		def type = getLoggedUser()?.type
		def profile = getProfileByType(type)
		
		return [profile:profile, type:type]
	}
	
	def save = {
		def user = getLoggedUser()
		try {
			def profile = getProfileByType(user.type)
			
			if(request[CustomMultipartResolver.FILE_SIZE_EXCEEDED_ERROR]){
				flash.message = "Please, don't upload files > 90kb."
				render(view:'create',model:[profile:profile, type:user.type])
				return
			}
			
			user.profile = profile
			profile.user = user
			
			def file = request.getFile("resume")
		
			if(file){
				if(params.type != "employee"){
					flash.message = "Ooops, companies cannot upload resumes."
					render(view:'create',model:[profile:profile, type:user.type])				
					return
				}
			
				if (!(file.contentType == "application/msword" || file.contentType == "application/pdf")) {
					flash.message = "Sorry, we just accept pdfs and word documents."
					render(view:'create',model:[profile:profile, type:user.type])
					return
				}
			
				profile.resumeContentType = file.contentType
			}
		
			if(!profile.hasErrors() && profile.validate()) {
				profile.save()
				flash.message = "You've being successfully registered!"
	            redirect(uri:'/')
			} else {
				render(view:'create',model:[profile:profile, type:user.type])
			}		
				
		} catch(org.springframework.dao.DataIntegrityViolationException e) {
			flash.message = "Could not save your profile, because ${e.message}"
			render(view:'create',model:[profile:profile, type:user.type])
		}
	}
	
	def download = {
		def user = User.findById(params.id, [fetch:[profile:'join'], cache:false])
		if(!user){
			flash.message = "Could not find user. Sorry."
			render(view:'index')
		}
		
		if(user.type == "employee"){
			def profile = user.profile
			response.outputStream << profile.resume
			response.contentType = profile.resumeContentType
		}
	}
	
	private getProfileByType(type){
		if(type == "employee"){
			return new EmployeeProfile(params)
		} else if (type == "company") {
			return new CompanyProfile(params)
		}
	}
	
	private getLoggedUser(){
		User.findByUsername(principalInfo.username, [cache:true])
	}
}
