Chapter 2: Printers
===================


What are Printers?
------------------

Printers in IPP are objects that represent real or virtual (for saving,
emailing, etc.) output devices.  Printer objects provide attributes that
describe the *status* of the Printer (printing something, out of paper, etc.),
the *capabilities* of the Printer (what paper sizes are supported, can the
Printer reproduce color, can the Printer staple the output, etc.), and *general
information* about the Printer (where the Printer is located, the URL for the
printer's administrative web page, etc.)  Printers also manage a queue of print
jobs.


### Printer Status Attributes

Printers have two main status attributes: "printer-state" and
"printer-state-reasons".  The "printer-state" attribute is a number that
describes the general state of the Printer:

- '3': The Printer is idle.
- '4': The Printer is processing a print job.
- '5': The Printer is stopped and requires attention.

The "printer-state-reasons" attribute is a list of keyword strings that provide
details about the Printer's state:

- 'none': Everything is super, nothing to report.
- 'media-needed': The Printer needs paper loaded.
- 'toner-low': The Printer is low on toner.
- 'toner-empty': The Printer is out of toner.
- 'marker-supply-low': The Printer is low on ink.
- 'marker-supply-empty': The Printer is out of ink.

The string may also have a severity suffix ("-error", "-warning", or "-report")
to tell the Clients whether the reason affects the printing of a job.

> Note: The [IANA IPP registry](https://www.iana.org/assignments/ipp-registrations/ipp-registrations.xml#ipp-registrations-4)
> lists all of the registered keyword strings for the "printer-state-reasons"
> attribute.  All strings are in English but can be localized using message
> catalogs provided by each Printer.

Many Printers also provide status attributes for alerts ("printer-alert"),
consumables ("printer-supply", "printer-supply-description", and
"printer-supply-info-uri"), input trays ("printer-input-tray"), output trays
("printer-output-tray"), and so forth.


### Printer Capability Attributes

Printers have many capability attributes, including:

- "ipp-features-supported": A list of IPP features that are supported, for
  example 'ipp-everywhere' and 'icc-color-matching'.

- "ipp-versions-supported": A list of IPP versions that are supported, for
  example '1.1' and '2.0'.

- "operations-supported": A list of IPP operations that are supported, for
  example Print-Job, Create-Job, Send-Document, Cancel-Job, Get-Jobs,
  Get-Job-Attributes, and Get-Printer-Attributes.

- "charset-supported": A list of character sets that are supported ('utf-8' is
  required.)

- "job-creation-attributes-supported": A list of IPP attributes that are
  supported when submitting print jobs, for example 'media', 'media-col', and
  'print-quality'.

- "document-format-supported": A list of file formats that can be printed,
  for example 'application/pdf' and 'image/pwg-raster'.

- "media-supported" and "media-col-database": A list of paper sizes and types
  that are supported, for example 'na\_letter\_8.5x11in' and
  'iso\_a4\_210x297mm'.

- "media-ready" and "media-col-ready": A list of paper sizes and types that are
  loaded, for example 'na\_letter\_8.5x11in' and
  'iso\_a4\_210x297mm'.

- "copies-supported": The maximum number of copies that can be produced, for
  example '99'.

- "sides-supported": A list of supported one and two sided printing modes, for
  example 'one-sided', 'two-sided-long-edge', and 'two-sided-short-edge'.

- "print-quality-supported": A list of supported print qualities, for example
  '3' (draft), '4' (normal), and '5' (high).

- "print-color-mode-supported": A list of supported color printing modes, for
  example 'bi-level', 'monochrome', and 'color'.

- "print-scaling-supported": A list of supported scaling modes, for example
  'auto', 'fill', and 'fit'.

- "printer-resolution-supported": A list of supported print resolutions, for
  example '300dpi' and '600dpi'.

- "page-ranges-supported": Specifies whether page ranges are supported
  (boolean).

- "finishings-supported" and "finishings-col-database": A list of finishing
  processes (staple, punch, fold, etc.) that are supported.

- "finishings-ready" and "finishings-col-ready": A list of finishing processes
  that can be requested without stopping the Printer.

- "job-password-supported", "job-password-encryption-supported",
  "job-password-repertoire-configured", and "job-password-repertoire-supported":
  The supported Job password/PIN values that can be specified when creating a
  Job.


### Printer Information Attributes

Printers have seven main informational attributes: "printer-uri-supported",
"uri-authentication-supported", "uri-security-supported", "printer-info",
"printer-more-info", "printer-location", and "printer-geo-location".

The "printer-uri-supported" attribute lists the supported Printer URI values.
The "uri-authentication-supported" attribute lists the authorization and access
control requirements for each of the supported Printer URI values.  Similarly,
the "uri-security-supported" attribute lists the encryption requirements for
each of the supported Printer URI values.

The "printer-info" attribute provides a textual description of the Printer and
often defaults to the make and model of the Printer.  The "printer-more-info"
attribute provides a URL to the Printer's administrative web page.

The "printer-location" attribute provides a textual location of the Printer,
for example 'Second floor near the break room.'.  The "printer-geo-location"
attribute provides the geographic location of the Printer, if known, as a
[geo:](https://tools.ietf.org/html/rfc5870) URI.


Querying the Printer Attributes
-------------------------------

The Get-Printer-Attributes operation is used to query any of the Printer
attributes mentioned previously.  The following example `ipptool` test file will
report the current Printer attribute values when printing PWG Raster files:

```
{
    VERSION 2.0
    OPERATION Get-Printer-Attributes

    GROUP operation-attributes-tag
    ATTR charset "attributes-charset" "utf-8"
    ATTR naturalLanguage "attributes-natural-language" "en"
    ATTR uri "printer-uri" "ipp://printer.example.com/ipp/print"
    ATTR name "requesting-user-name" "John Doe"
    ATTR mimeMediaType "document-format" "image/pwg-raster"
    ATTR keyword "requested-attributes" "printer-description","job-template","media-col-database"
}
```

> Note: The "requested-attributes" attribute lists attributes (or groups of
> attributes) that the Client is interested in.  The 'printer-description'
> group asks for all status and information attributes while the 'job-template'
> group asks for all capability attributes.  For compatibility reasons, the
> "media-col-database" attribute needs to be requested explicitly.

The same request using the CUPS API would look like the following:

```
#include <cups/cups.h>

...

http_t *http;
ipp_t *request, *response;
static const char * const requested_attributes[] =
{
  "printer-description",
  "job-template",
  "media-col-database"
};

http = httpConnect2("printer.example.com", 631, NULL, AF_UNSPEC, HTTP_ENCRYPTION_IF_REQUESTED, 1, 30000, NULL);

request = ippNewRequest(IPP_OP_GET_PRINTER_ATTRIBUTES);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL, "ipp://printer.example.com/ipp/print");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME, "requesting-user-name", NULL, "John Doe");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_MIMETYPE, "document-format", NULL, "image/pwg-raster");
ippAddStrings(request, IPP_TAG_OPERATION, IPP_TAG_KEYWORD, "requested-attributes", (int)(sizeof(requested_attributes) / sizeof(requested_attributes[0])), NULL, requested_attributes);

response = cupsDoRequest(http, request, "/ipp/print");

ipp_attribute_t *attr;
const char *name;
char value[2048];

for (attr = ippFirstAttribute(response); attr; attr = ippNextAttribute(response))
{
  name = ippGetName(attr);

  if (name)
  {
    ippAttributeString(attr, value, sizeof(value));
    printf("%s=%s\n", name, value);
  }
}
```

And this is how you'd query a Printer using the nodejs API:

```
var ipp = require("ipp");
var Printer = ipp.Printer("http://printer.example.com:631/ipp/print");

var msg = {
  "operation-attributes-tag": {
    "requesting-user-name": "John Doe",
    "document-format": "image/pwg-raster",
    "requested-attributes": ["printer-description", "job-template", "media-col-database"]
  }
};

printer.execute("Get-Printer-Attributes", msg, function(err, res) {
        console.log(err);
        console.log(res);
});
```
