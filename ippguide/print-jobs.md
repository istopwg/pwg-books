Chapter 3: Jobs and Documents
=============================


What are Print Jobs?
--------------------

Print Jobs in IPP are objects that represent work to be done by a Printer,
typically printing or faxing a Document.  Print Jobs provide attributes that
describe the *status* of the Job (pending, held for some reason, printing,
completed, etc.), *general information* about the Job (the Job's owner, name,
submission time, etc.) the *Job Ticket* (print options), and the *Job Receipt*
(what print options were used, how many pages were printed, when the Job was
printed, etc.)


### Job Status Attributes

Job objects have two main status attributes: "job-state" and
"job-state-reasons".  The "job-state" attribute is a number that describes the
general state of the Job:

- '3': The Job is queued and pending.
- '4': The Job has been held, e.g., for "PIN printing".
- '5': The Job is being processed (printed, faxed, etc.)
- '6': The Job is stopped (out of paper, etc.)
- '7': The Job was canceled by the user.
- '8': The Job was aborted by the Printer.
- '9': The Job completed successfully.

The "job-state-reasons" attribute is a list of keyword strings that provide
details about the Job's state:

- 'none': Everything is super, nothing to report.
- 'document-format-error': The Document could not be printed due to a file
  format error.
- 'document-unprintable-error': The Document could not be printed for other
  reasons (too complex, out of memory, etc.)
- 'job-incoming': The Job is being received from the Client.
- 'job-password-wait': The Printer is waiting for the user to enter the PIN
  for the Job.

> Note: The [IANA IPP registry](https://www.iana.org/assignments/ipp-registrations/ipp-registrations.xml#ipp-registrations-4)
> lists all of the registered keyword strings for the "job-state-reasons"
> attribute.  All strings are in English but can be localized using message
> catalogs provided by each Printer.

Page counts are recorded in the following attributes:

- "job-impressions-completed": The number of sides/images that were printed or
  sent.
- "job-media-sheets-completed": The number of sheets that were printed.
- "job-pages-completed": The number of Document pages that were processed.


### Job Information Attributes

Job objects have many informational attributes, including the Job's name
("job-name"), number ("job-id"), owner ("job-originating-user-name"),
Printer ("job-printer-uri"), and page counts ("job-impressions",
"job-media-sheets", and "job-pages") which are provided or generated in the Job
creation request (Create-Job or Print-Job).


### Job Ticket Attributes

Job ticket attributes tell the Printer how you want the Document(s) printed.
Clients can query the [Printer capability attributes](#printer-capability-attributes)
to get the supported values. The following is a list of commonly-supported
attributes:

- "media": The desired paper size for the print Job using a self-describing
  name (keyword) value.  For example, US Letter paper is 'na\_letter\_8.5x11in'
  and ISO A4 paper is 'iso\_a4\_210x297mm'.

- "media-col": The desired paper size and other attributes for the print Job
  using a collection of key/value pairs for size, type, source (tray), and
  margins.

- "copies": The number of copies to produce. This attribute is typically only
  supported for higher-level formats like PDF and JPEG, so it is important to
  specify the "document-format" value when you query the Printer capabilities.

- "sides": A keyword that specifies whether to do two sided printing. Values
  include 'one-sided', 'two-sided-long-edge' (typical 2-sided printing for
  portrait Documents), and 'two-sided-short-edge' (2-sided printing for
  landscape Documents).

- "print-quality": An enumeration specifying the desired print quality. '3' is
  draft, '4' is normal, and '5' is best quality.

- "print-color-mode": A keyword specifying the color printing mode to use. The
  value 'color' specifies a full-color print, 'monochrome' specifies a grayscale
  print, and 'bi-level' specifies a black-and-white (no shades of gray) print.

- "print-scaling": A keyword specifying how to scale the Document for printing.
  This is typically used only when printing images, but can be used for any
  format. Values include 'auto' (scale to fit or fill as needed), 'auto-fit'
  (scale to fit as needed), 'fill' (scale to fill the page), 'fit' (scale to fit
  the Document/image on the page), and 'none' (no scaling).

- "printer-resolution": The output resolution to use when printing. The
  default is usually influenced by the "print-quality" value, but this attribute
  can be used to force the output resolution to a particular value that is
  supported by the Printer.

- "page-ranges": A list of Document pages to be printed, for example '1-8' to
  print pages 1 through 8. This attribute is typically only supported for
  higher-level formats like PDF so it is important to specify the
  "document-format" value when you query the Printer capabilities.

- "finishings": A list of enumerations specifying how the output should be
  finished, for example '3' for no finishing, '4' to staple, '5' to punch, and
  '4,5' to staple and punch.

- "finishings-col": A list of collections of key/value pairs describing how the
  output should be finished. Basically an advanced alternative to the
  "finishings" attribute.

- "job-password" and "job-password-encryption": A password that is used to
  release the Job for printing on the printer, for example to specify PIN
  printing.


### Job Receipt Attributes

Some Printers also record a read-only Job receipt in attributes named
"xxx-actual" for each [job template](#job-template-attrbutes) attribute, for
example "copies-actual", "media-actual", and so forth.


Documents
---------

Printers report the Document formats they support in the
["document-format-supported" Printer capability attribute](#printer-capability-attributes).
Most IPP Printers support standard formats like PDF ('application/pdf'), PWG
Raster ('image/pwg-raster'), and JPEG (image/jpeg).  AirPrint Printers also
support a simple raster format called Apple Raster ('image/urf').

Many IPP Printers also support legacy formats such as Adobe PostScript
('application/postscript'), and HP Page Control Language (PCL,
'application/vnd.hp-pcl'), along with a variety of vendor-specific languages.

The 'application/octet-stream' Document format is used to tell the Printer it
should automatically detect the format.  Detection accuracy varies widely
among Printers, so you should specify the actual format whenever possible.


Submitting Print Jobs
---------------------

There are two ways to submit a print Job:

- Using the Print-Job operation, and
- Using the Create-Job and Send-Document operations.


### The Print-Job Operation

The Print-Job operation allows you to create a print Job and send the Document
data in one request. While all IPP Printers support this operation, using it
means that you cannot reliably cancel the Job while it is being submitted, and
for many Document formats this means that the entire Job will be printed
before you get the response to the request.

The following `ipptool` test will submit a US Letter print Job using the
Print-Job operation:

```
{
    VERSION 2.0
    OPERATION Print-Job

    GROUP operation-attributes-tag
    ATTR charset "attributes-charset" "utf-8"
    ATTR naturalLanguage "attributes-natural-language" "en"
    ATTR uri "printer-uri" "ipp://printer.example.com/ipp/print"
    ATTR name "requesting-user-name" "John Doe"
    ATTR mimeMediaType "document-format" "$filetype"

    GROUP Job-attributes-tag
    ATTR keyword media "na_letter_8.5x11in"

    FILE $filename
}
```

The same request using the CUPS API would look like the following:

```
#include <cups/cups.h>

...

const char *filename;
const char *filetype;
http_t *http;
ipp_t *request;

http = httpConnect2("printer.example.com", 631, NULL, AF_UNSPEC, HTTP_ENCRYPTION_IF_REQUESTED, 1, 30000, NULL);

request = ippNewRequest(IPP_OP_PRINT_JOB);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL, "ipp://printer.example.com/ipp/print");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME, "requesting-user-name", NULL, "John Doe");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_MIMETYPE, "document-format", NULL, filetype);

ippAddString(request, IPP_TAG_JOB, IPP_TAG_KEYWORD, "media", NULL, "na_letter_8.5x11in");

ippDelete(cupsDoFileRequest(http, request, "/ipp/print", filename));
```

And this is how you'd print a Job using the nodejs API:

```
var ipp = require("ipp");
var fs = require("fs");
var Printer = ipp.Printer("http://printer.example.com:631/ipp/print");
var filename;
var filetype;

var filedata = "";
fs.readFile(filename, function(err,data) {
  filedata = data;
}

var msg = {
  "operation-attributes-tag": {
    "requesting-user-name": "John Doe",
    "document-format": filetype
  },
  "job-attributes-tag": {
    "media": "na_letter_8.5x11in"
  },
  data: filedata
};

printer.execute("Print-Job", msg, function(err, res) {
        console.log(err);
        console.log(res);
});
```


### The Create-Job and Send-Document Operations

The Create-Job and Send-Document operations split the Job submission into two
steps. You first send a Create-Job request with your Job template attributes,
and the Printer will return a "job-id" value to identify the new Job you've
just created. You then send a Send-Document request with your Document data to
complete the Job submission. If you want to stop the Job while sending the
document data, you can open a separate connection to the Printer and send a
Cancel-Job request using the "job-id" value you got from the Create-Job request.

The following `ipptool` test will submit a US Letter print Job using the
Create-Job and Send-Document operations:

```
{
    VERSION 2.0
    OPERATION Create-Job

    GROUP operation-attributes-tag
    ATTR charset "attributes-charset" "utf-8"
    ATTR naturalLanguage "attributes-natural-language" "en"
    ATTR uri "printer-uri" "ipp://printer.example.com/ipp/print"
    ATTR name "requesting-user-name" "John Doe"

    GROUP Job-attributes-tag
    ATTR keyword media "na_letter_8.5x11in"

    EXPECT Job-id OF-TYPE integer
}

{
    VERSION 2.0
    OPERATION Send-Document

    GROUP operation-attributes-tag
    ATTR charset "attributes-charset" "utf-8"
    ATTR naturalLanguage "attributes-natural-language" "en"
    ATTR uri "printer-uri" "ipp://printer.example.com/ipp/print"
    ATTR integer "job-id" $job-id
    ATTR name "requesting-user-name" "John Doe"
    ATTR mimeMediaType "document-format" "$filetype"
    ATTR boolean "last-document" true

    FILE $filename
}
```

The same request using the CUPS API would look like the following:

```
#include <cups/cups.h>

...

const char *filename;
const char *filetype;
http_t *http;
ipp_t *request, *response;

http = httpConnect2("printer.example.com", 631, NULL, AF_UNSPEC, HTTP_ENCRYPTION_IF_REQUESTED, 1, 30000, NULL);

request = ippNewRequest(IPP_OP_CREATE_JOB);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL, "ipp://printer.example.com/ipp/print");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME, "requesting-user-name", NULL, "John Doe");

ippAddString(request, IPP_TAG_JOB, IPP_TAG_KEYWORD, "media", NULL, "na_letter_8.5x11in");

response = cupsDoFileRequest(http, request, "/ipp/print", filename);

int Job_id = ippGetInteger(ippFindAttribute(response, "job-id", IPP_TAG_INTEGER), 0);

ippDelete(response);

request = ippNewRequest(IPP_OP_SEND_DOCUMENT);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL, "ipp://printer.example.com/ipp/print");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_INTEGER, "job-id", Job_id);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME, "requesting-user-name", NULL, "John Doe");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_MIMETYPE, "document-format", NULL, filetype);

ippDelete(cupsDoFileRequest(http, request, "/ipp/print", filename));

```

And this is how you'd print a Job using the nodejs API:

```
var ipp = require("ipp");
var fs = require("fs");
var Printer = ipp.Printer("http://printer.example.com:631/ipp/print");
var filename;
var filetype;

var filedata = "";
fs.readFile(filename, function(err,data) {
  filedata = data;
}

var create_msg = {
  "operation-attributes-tag": {
    "requesting-user-name": "John Doe"
  },
  "job-attributes-tag": {
    "media": "na_letter_8.5x11in"
  }
};

var Job_id = 0;

printer.execute("Create-Job", msg, function(err, res) {
        console.log(err);
        console.log(res);

	job_id = res["job-id"];
});

var send_msg = {
  "operation-attributes-tag": {
    "job-id": Job_id,
    "requesting-user-name": "John Doe",
    "document-format": filetype
  },
  data: filedata
};

printer.execute("Send-Document", msg, function(err, res) {
        console.log(err);
        console.log(res);
});

```
