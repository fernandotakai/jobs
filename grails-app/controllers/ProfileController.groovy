import org.undone.utils.CustomMultipartResolver

class ProfileController {
	
	def index = {
		def userLogged = getLoggedUser()

		if(!userLogged.profile){
			redirect(action:"create")
		}
		
		return [profile:userLogged.profile, type:userLogged.type, user:userLogged]
	}
	
	def create = {
		def type = getLoggedUser()?.type
		def profile = getProfileByType(type)
		
		return [profile:profile, type:type]
	}
	
	def show = {
		def profile = Profile.get(params.id)
		if(!profile){
			flash.message = "Could not find this profile. Sorry."
			redirect(uri:"/")
		}
		
		return [profile: profile]
	}
	
	def save = {
		def user = getLoggedUser()
		try {
			def profile = getProfileByType(user.type)
			
			def file = request.getFile("resume")
			
			if(file){
				if(!validateFile(file)){
					render(view:'create',model:[profile:profile, type:user.type])
					return
				}
			
				if(file.contentType != "application/octet-stream"){
					profile.resumeContentType = file.contentType
					profile.hasResume = (file.size > 0)
				}
			}
			
			user.profile = profile
			profile.user = user
			
			if(!profile.hasErrors() && profile.save()) {
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
			def filename = "${user.username}${profile.extention}"
		    response.setHeader("Content-disposition", "attachment; filename=${filename}")
		
			response.contentType = profile.resumeContentType
			response.outputStream << profile.resume
		}
	}
	
    def edit = {
		def user = getLoggedUser()
        def profile = user.profile

        if(!profile) {
            redirect(action:create)
        }
        else {
            return [ profile : profile, user : user ]
        }
    }

    def update = {
		def user = getLoggedUser()
        def profile = user.profile
        if(profile) {
			
			if(profile.user != user){
				flash.message = "Oops, you cannot update this profile."
				redirect(action:show,id:params.id)
				return
			}
	
            if(params.version) {
                def version = params.version.toLong()
                if(profile.version > version) {
                    profile.errors.rejectValue("version", "profile.optimistic.locking.failure", "Another user has updated this profile while you were editing.")
                    render(view:'edit',model:[profile:profile])
                    return
                }
            }

			def file =  request.getFile("resume")
			
			if(file){
				if(!validateFile(file)){
					render(view:'edit',model:[profile:profile])
					return
				}

			
				if(file.size == 0){
	            	bindData(profile, params, [exclude:"resume"])
				} else {
					profile.properties = params
					if(file.contentType != "application/octet-stream"){
						profile.resumeContentType = file.contentType
					}
				}
				profile.hasResume = (file.size > 0)
			} else {
				profile.properties = params
			}
			
			user.properties = params['user']
			
            if(!profile.hasErrors() && profile.save() && !user.hasErrors() && user.save()) {
                flash.message = "Profile updated"
                redirect(action:index)
            } else {
                render(view:'edit',model:[profile:profile])
            }
        } else {
            redirect(action:"create")
        }
    }

	
	private validateFile(file){
		
		if(request[CustomMultipartResolver.FILE_SIZE_EXCEEDED_ERROR]){
			flash.message = "Please, don't upload files > 90kb."
			return false
		}
		
		if(file){
			if(params.type != "employee"){
				flash.message = "Ooops, companies cannot upload resumes."
				return false
			}
			
			if (file.size != 0 && !(file.contentType == "application/msword" || file.contentType == "application/pdf")) {
				flash.message = "Sorry, we just accept pdfs and word documents."
				return false
			}
			
		}
		
		return true
	}
	
	private getProfileByType(type){
		if(type == "employee"){
			return new EmployeeProfile(params)
		} else if (type == "company") {
			return new CompanyProfile(params)
		}
	}
	
	private getLoggedUser(){
		User.findByUsername(principalInfo.username, [fetch:[profile:'join'], cache:false])
	}
}
