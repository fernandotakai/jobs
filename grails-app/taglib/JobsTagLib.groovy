import org.joda.time.*

class JobsTagLib {
	def timeSince = { attrs ->
		def since = attrs.since
		
		if(!since)
			throw new IllegalArgumentException("timeSince tagLib needs a since argument")
			
		def date = Calendar.instance.time
		
		def interval = new Interval(since.getTime(), date.getTime())
		def period = interval.toPeriod()
		
		def buff = new StringBuffer()
		
		if(period.years > 0) buff << period.years + (period.years == 1 ? " year, " : " years, ")
		if(period.months > 0) buff << period.months + (period.months == 1 ? " month, " : " months, ")
		if(period.weeks > 0) buff << period.weeks + (period.weeks == 1 ? " weeks, " : " week, ")
		if(period.days > 0) buff << period.days + (period.days == 1 ? " day, " : " days, ")
		if(period.hours > 0) buff << period.hours + (period.hours == 1 ? " hour, " : " hours, ")
		if(period.minutes > 0) buff << period.minutes + (period.minutes == 1 ? " minute, " : " minutes, ")
		if(buff.size() == 0) buff << period.seconds + (period.seconds == 1 ? " second " : " seconds ")
		
		out << buff.toString()[0..buff.size()-3] + " ago"
	}
	
	def formForDomain = { attrs, body ->
		
		def controller = attrs.controller
		def action = attrs.action
		
		def domainAttributes = attrs.attributes
		
		def instance = attrs.model
		
		if(!controller) throw new Exception("You must provide a controller attribute to formTag")
		if(!action) throw new Exception("You must provide a action attribute to formTag")
		if(!domainAttributes) throw new Exception("You must provide a attributes attribute to formTag")
		if(!domainAttributes instanceof Map) throw new Exception("attributes attribute must be a list")
		
		def buff = new StringBuffer()
		
		domainAttributes.each { att ->
			def maxSize = instance?.constraints?."${att.value}"?.maxSize
			def value = instance?."${att.value}" ? instance?."${att.value}" : ""
			def field = maxSize && maxSize > 250 ? createTextArea(att.value, value) : g.textField(name:att.value, value:value)
			buff << "<label for='${att.value}'>${att.key}</label>${field}\n<br />"
		}
		
		out << g.form(action:action, controller:controller){
			out << buff.toString()
			out << body()
		}
		
	}
	
	private createTextArea(key, value){
		"<textarea id='${key}' name='${key}'>${value}</textarea>"
	}
}
