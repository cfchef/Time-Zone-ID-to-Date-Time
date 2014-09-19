component name="TimeZoneIdToDateTime"
	output="false"
{
	public any function init() {
		return this;
	}

	// This function is used directly on the server side where you already 
	// have the Time Zone ID to supply. 
	public function getDateTimeByTimeZoneId(required string timeZone = "")
		output="false"
	{
		var jTimeZone = createObject("java", "java.util.TimeZone");
		var timeZones = jTimeZone.getAvailableIDs();
		var jSimpleDateFormat = createObject("java", "java.text.SimpleDateFormat").init("yyyy-MM-dd HH:mm:ss");

		if (!arrayFind(timeZones, arguments.timeZone)) {
			throw(message = "Not a valid Time Zone ID.", detail = "Refer to results from java.util.TimeZone.getAvailableIDs()");
		}
		jSimpleDateFormat.setTimeZone(jTimeZone.getTimeZone(arguments.timeZone));

		return jSimpleDateFormat.format(now());
	}

	// This function is used along with a AJAX call that passes in a Time Zone ID
	// that was obtained from the client-side via JavaScript. 
	remote function remoteDateTimeByTimeZoneId(required string timeZone = "")
		output="false"
		returnFormat="JSON"
	{
		return getDateTimeByTimeZone(arguments.timeZone);
	}
}
