Chapter 2: Printers
===================


What are Printers?
------------------

Printers in IPP are an abstract object that represents a real printer, a
collection of printers, or a virtual output device (for
saving/emailing/publishing PDFs, etc.)

Printers provide attributes that describe the *status* of the printer (it is
printing something, has it run out of paper, etc.), the *capabilities* of the
printer (what paper sizes are supported, can the printer reproduce color, can
the printer staple the output, etc.), and *general information* about the
printer (where the printer is located, the URL for the printer's administrative
web page, etc.)

Printers also manage one or more queued print jobs and provide a history of jobs
that have been printed.


### Printer Status Attributes

Printers provide two main status attributes: "printer-state" and
"printer-state-reasons".  The "printer-state" attribute is a number that
describes the generate state of the printer:

- '3': The printer is idle.
- '4': The printer is processing a print job.
- '5': The printer is stopped and requires attention.

The "printer-state-reasons" attribute is a list of strings that provide details
about the printer's state:

- 'none': Everything is super, nothing to report.
- 'media-needed': The printer needs paper loaded.
- 'toner-low': The printer is low on toner.
- 'toner-empty': The printer is out of toner.
- 'marker-supply-low': The printer is low on ink.
- 'marker-supply-empty': The printer is out of ink.

The strings may also have a severity suffix ("-error", "-warning", or "-report")
to tell the client whether the reason prevents the printer from printing a job.

> Note: The [IANA IPP registry](https://www.iana.org/assignments/ipp-registrations/ipp-registrations.xml#ipp-registrations-4)
> lists all of the registered strings for the "printer-state-reasons" attribute.

Many printers also provide status attributes for alerts ("printer-alert"),
consumables ("printer-supply", "printer-supply-description", and
"printer-supply-info-uri"), input trays ("printer-input-tray"), output trays
("printer-output-tray"), and so forth.


### Printer Description Attributes

Printers provide seven main description attributes: "printer-uri-supported",
"uri-authentication-supported", "uri-security-supported", "printer-info",
"printer-more-info", "printer-location", and "printer-geo-location".

The "printer-uri-supported" attribute lists the supported printer URI values.
The "uri-authentication-supported" attribute lists the authorization and access
control requirements for each of the supported printer URI values.  Similarly,
the "uri-security-supported" attribute lists the encryption requirements for
each of the supported printer URI values.

The "printer-info" attribute provides a textual description of the printer and
often defaults to the make and model of the printer.  The "printer-more-info"
attribute provides a URL to the printer's administrative web page.

The "printer-location" attribute provides a textual location of the printer,
for example 'Second floor near the break room.'.  The "printer-geo-location"
attribute provides the GPS location of the printer, if known.


### Printer Capability Attributes

Printers provide many capability attributes, including:

- "ipp-features-supported": A list of IPP features that are supported.

- "ipp-versions-supported": A list of IPP versions that are supported.

- "operations-supported": A list of IPP operations that are supported.

- "charset-supported": A list of character sets that are supported ('utf-8' is
  required.)

- "job-creation-attributes-supported": A list of IPP attributes that are
  supported when submitting print jobs.

- "document-format-supported": A list of file formats that can be printed.

- "media-supported" and "media-col-database": A list of paper sizes and types
  that are supported.

- "media-ready" and "media-col-ready": A list of paper sizes and types that are
  loaded.

- "copies-supported": The maximum number of copies that can be produced.

- "sides-supported": A list of supported one and two sided printing modes.

- "print-quality-supported": A list of supported print qualities.

- "print-color-mode-supported": A list of supported color printing modes.

- "print-scaling-supported": A list of supported scaling modes.

- "printer-resolution-supported": A list of supported print resolutions.

- "page-ranges-supported": Specifies whether page ranges are supported.

- "finishings-supported" and "finishings-col-database": A list of finishing
  processes (staple, punch, fold, etc.) that are supported.

- "finishings-ready" and "finishings-col-ready": A list of finishing processes
  that can be requested without stopping the printer.


Querying the Printer Attributes
-------------------------------

The Get-Printer-Attributes operation is used to query any of the printer
attributes mentioned previously.  The following `ipptool` test will report the
current printer attribute values:

```
{
    VERSION 2.0
    OPERATION Get-Printer-Attributes

    GROUP operation-attributes-tag
    ATTR charset "attributes-charset" "utf-8"
    ATTR naturalLanguage "attributes-natural-language" "en"
    ATTR uri "printer-uri" "ipp://printer.example.com/ipp/print"
    ATTR name "requesting-user-name" "John Doe"
}
```

The same request using the CUPS API would look like the following:

```
#include <cups/cups.h>

...

http_t *http;
ipp_t *request, *response;

http = httpConnect2("printer.example.com", 631, NULL, AF_UNSPEC,
                    HTTP_ENCRYPTION_IF_REQUESTED, 1, 30000, NULL);

request = ippNewRequest(IPP_OP_GET_PRINTER_ATTRIBUTES);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL,
             "ipp://printer.example.com/ipp/print");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME, "requesting-user-name",
             NULL, "John Doe");

response = cupsDoRequest(http, request, "/ipp/print");

ipp_attribute_t *attr;
const char *name;
char value[2048];

for (attr = ippFirstAttribute(response); attr; attr = ippNextAttribute(response))
{
  name = ippGetName(attr);

  if (name)
  {
    ippAttributeString(attr, name, sizeof(name));
    printf("%s=%s\n", name, value);
  }
}
```

And this is how you'd query a printer using the nodejs API:

```
var ipp = require("ipp");
var printer = ipp.Printer("http://printer.example.com:631/ipp/print");

var msg = {
  "operation-attributes-tag": {
    "requesting-user-name": "John Doe",
  }
};

printer.execute("Get-Printer-Attributes", msg, function(err, res) {
        console.log(err);
        console.log(res);
});
```


Summary
-------

IPP printers track the state, capabilities, administrative information, and
print jobs of one or more real or virtual printers.  IPP printers provide many
attributes which are queried using the Get-Printer-Attributes request.
