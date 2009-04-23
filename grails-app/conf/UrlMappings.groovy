class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
	  "/profile/$id" {
	     controller = "profile"
		 action = "show"
	  }
	  "/jobs/$id" {
	     controller = "job"
	     action = "show"	
	  }
      "/"(controller:"job", action:"list")
	  "500"(view:'/error')
	}
}
