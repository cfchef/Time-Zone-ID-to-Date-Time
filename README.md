Time Zone ID to Date/Time
==========================

A ColdFusion approach via a CFC with functions, for Server-Side & Client-Side, that use underlying Java methods to obtain a DateTime string value from a supplied Time Zone ID.

## Server-Side Example...

For a list of Time Zone IDs, you can retrieve a returned array like so:

`writeDump( createObject("java", "java.util.TimeZone").getAvailableIDs() );`

A full call to the CFC can be done in 2 lines:

```
dt = createObject("component", "path.to.cfc.TimeZoneIDToDateTime");
writeOutput( dt.getDateTimeByTimeZoneID("America/New_York") );
// Example Result: 2014-09-17 20:55:07
```

## Client-Side (via AJAX) Example...

This example makes use of [jstz-1.0.4.min.js](https://bitbucket.org/pellepim/jstimezonedetect/downloads) and [jQuery](http://jquery.com/download/).

```
<!DOCTYPE html>
<html lang="en-us">	
	<head>
		<title>Get Date/Time By Time Zone ID AJAX Example</title>
		<meta charset="utf-8">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	</head>

	<body>
		<script type="text/javascript">
			var timezone = jstz.determine();
			console.log("Time Zone ID: " + timezone.name());
			$.ajax({
				url: "TimeZoneIDToDateTime.cfc",
				type: "GET",
				data: {method: "remoteDateTimeByTimeZoneID", timeZoneID: timezone.name()},
				dataType: "JSON"
			}).done(function(result) {
				$(".call").append(result);
				console.log(result);
			}).fail(function(jqXHR, textStatus) {
				console.log("Request failed: " + textStatus);
			});
		</script>

		<div class="call"><!--Result prints here--></div>
	</body>
</html>
```
