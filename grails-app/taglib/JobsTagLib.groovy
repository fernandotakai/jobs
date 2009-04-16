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
}
