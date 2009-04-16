
class JobController {
    
	def authenticateService

    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {	
	
		params.max = 15
	
        [ jobs: Job.list( params ) ]
    }

    def show = {
        def jobInstance = Job.get( params.id )

		def user = getLoggedUser()

		def isOwner = (jobInstance.company == user)
		
		def alreadyApplied = jobInstance.appliers.contains(user)

        if(!jobInstance) {
            flash.message = "Job not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ job : jobInstance, isOwner:isOwner, alreadyApplied:alreadyApplied ] }
    }

    def delete = {
        def jobInstance = Job.get( params.id )

		def user = getLoggedUser()
		
		if(jobInstance.company != user){
			flash.message = "Oops, you cannot delete this job."
			redirect(action:show,id:params.id)
			return
		}

        if(jobInstance) {
            try {
                jobInstance.delete()
                flash.message = "Job ${params.id} deleted"
                redirect(action:list)
            } catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Job ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Job not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def jobInstance = Job.get( params.id )

        if(!jobInstance) {
            flash.message = "Job not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ jobInstance : jobInstance ]
        }
    }

    def update = {
        def jobInstance = Job.get( params.id )
        if(jobInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(jobInstance.version > version) {
                    
                    jobInstance.errors.rejectValue("version", "job.optimistic.locking.failure", "Another user has updated this Job while you were editing.")
                    render(view:'edit',model:[jobInstance:jobInstance])
                    return
                }
            }
            jobInstance.properties = params
            if(!jobInstance.hasErrors() && jobInstance.save()) {
                flash.message = "Job ${params.id} updated"
                redirect(action:show,id:jobInstance.id)
            }
            else {
                render(view:'edit',model:[jobInstance:jobInstance])
            }
        }
        else {
            flash.message = "Job not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def job = new Job()
        job.properties = params
		println "ASD"
        return ['job':job]
    }

    def save = {
        def jobInstance = new Job(params)

		def user = getLoggedUser()
		
		if(user.type == "employee"){
			flash.message = "Ooops! You cannot create jobs."
			render(view:'create',model:[job:jobInstance])
			return
		}

		jobInstance.company = user

        if(!jobInstance.hasErrors() && jobInstance.save()) {
            flash.message = "Job created!"
            redirect(action:show,id:jobInstance.id)
        }
        else {
            render(view:'create',model:[job:jobInstance])
        }
    }

	def apply = {
		if(request.method == "GET"){
			def job = Job.get(params.id)
			if(!job){
				flash.message = "Job not found"
				redirect(action:index)
			}
		
			return [job:job]
		} else if (request.method == "POST"){
			def job = Job.get(params.id)
			job.addToAppliers(getLoggedUser())
			flash.message = "A message was sent to the company - you can wait that for their contact."
			redirect(action:list)
		}
	}
	
	def search = {
		if(!params.q.trim()){
			return [:]
		} else {
			def result = Job.search(params.q, params)
			return [ result: result.results, total: result.total ]
		}
	}
	
	private getLoggedUser(){
		if(authenticateService.isLoggedIn()){
			User.findByUsername(principalInfo.username, [cache:true])
		}
	}
	
}