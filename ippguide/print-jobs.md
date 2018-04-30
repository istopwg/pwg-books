Chapter 3: Print Jobs
=====================


What are Print Jobs?
--------------------

Print jobs in IPP are an abstract object that represents work to be done by a
printer - typically printing or faxing a document.

Print jobs provide attributes that describe the *status* of the job (pending,
held for some reason, printing, completed, etc.), *general information* about
the job (the job's owner, name, submission time, etc.) the *job ticket* (print
options), and the *job receipt* (what print options were used, how many pages
were printed, when the job was printed, etc.)

Print jobs contain zero or more documents that are processed (printed, faxed,
etc.) as a single work item, although most printers only support a single
document per job so the multiple-document capability of IPP is rarely used.

> Note: A print job with no documents cannot be processed and will (eventually)
> be aborted so that other jobs can be processed.


### Job Status Attributes

Jobs provide five main status attributes: "job-id", "job-originating-user-name",
"job-printer-uri", "job-state", and "job-state-reasons".  The "job-id" and
"job-printer-uri" attributes provide an identifying (integer) number and the
printer that will be processing the job.  The "job-originating-user-name"
attribute provides the name of the submitter, e.g., "Bob Smith".  The
"job-originating-user-name" and "job-printer-uri" attributes are provided in
the job creation request (Create-Job or Print-Job), while the printer generates
a unique "job-id" for each job, starting at 1.

The "job-state" attribute is a number that describes the general state of the
job:

- '3': The job is queued and pending.
- '4': The job has been held, either because the user asked for it or because
  a passcode needs to be entered on the printer ("PIN printing").
- '5': The job is being processed (printed, faxed, etc.)
- '6': The job is stopped (out of paper, etc.)
- '7': The job was canceled by the user.
- '8': The job was aborted by the printer.
- '9': The job completed successfully.

The "job-state-reasons" attribute is a list of strings that provide details
about the job's state:

- 'none': Everything is super, nothing to report.
- 'document-format-error': The document could not be printed due to a file
  format error.
- 'document-unprintable-error': The document could not be printed for other
  reasons (too complex, out of memory, etc.)
- 'job-incoming': The job is being received from the client.
- 'job-password-wait': The printer is waiting for the user to enter the passcode
  for the job.

> Note: The [IANA IPP registry](https://www.iana.org/assignments/ipp-registrations/ipp-registrations.xml#ipp-registrations-4)
> lists all of the registered strings for the "job-state-reasons" attribute.

Page counts are recorded in the following attributes:

- "job-impressions-completed": The number of sides/images that were printed or
  sent.
- "job-media-sheets-completed": The number of sheets that were printed.
- "job-pages-completed": The number of document pages that were processed.

Some printers also record a read-only job receipt in attributes named
"xxx-actual" for each [job template](#job-template-attrbutes) attribute, for
example "copies-actual", "media-actual", and so forth.


### Job Description Attributes

Jobs provide many descriptive attributes, including the job's name ("job-name")
and page counts ("job-impressions", "job-media-sheets", and "job-pages") which
are provided in the job creation request (Create-Job or Print-Job).


### Job Template Attributes

Job template attributes tell the printer how you want the document(s) printed.
Clients can query the [printer capability attributes](#printer-capability-attributes)
to get the supported values. The following is a list of commonly-supported job
template attributes:

- "media": The desired paper size for the print job using a self-describing
  name (keyword) value.  For example, US Letter paper is 'na\_letter\_8.5x11in'
  and ISO A4 paper is 'iso\_a4\_210x297mm'.

- "media-col": The desired paper size and other attributes for the print job
  using a collection of key/value pairs for size, type, source (tray), and
  margins.

- "copies": The number of copies to produce. This attribute is typically only
  supported for higher-level formats like PDF and JPEG, so it is important to
  specify the "document-format" value when you query the printer capabilities.

- "sides": A keyword that specifies whether to do two sided printing. Values
  include 'one-sided', 'two-sided-long-edge' (typical 2-sided printing for
  portrait documents), and 'two-sided-short-edge' (2-sided printing for
  landscape documents).

- "print-quality": An enumeration specifying the desired print quality. '3' is
  draft, '4' is normal, and '5' is best quality.

- "print-color-mode": A keyword specifying the color printing mode to use. The
  value 'color' specifies a full-color print, 'monochrome' specifies a grayscale
  print, and 'bi-level' specifies a black-and-white (no shades of gray) print.

- "print-scaling": A keyword specifying how to scale the document for printing.
  This is typically used only when printing images, but can be used for any
  format. Values include 'auto' (scale to fit or fill as needed), 'auto-fit'
  (scale to fit as needed), 'fill' (scale to fill the page), 'fit' (scale to fit
  the document/image on the page), and 'none' (no scaling).

- "printer-resolution": The output resolution to use when printing. The
  default is usually influenced by the "print-quality" value, but this attribute
  can be used to force the output resolution to a particular value that is
  supported by the printer.

- "page-ranges": A list of document pages to be printed, for example '1-8' to
  print pages 1 through 8. This attribute is typically only supported for
  higher-level formats like PDF so it is important to specify the
  "document-format" value when you query the printer capabilities.

- "finishings": A list of enumerations specifying how the output should be
  finished, for example '3' for no finishing, '4' to staple, '5' to punch, and
  '4,5' to staple and punch.

- "finishings-col": A list of collections of key/value pairs describing how the
  output should be finished. Basically an advanced alternative to the
  "finishings" attribute.


- When to use media vs. media-col

- When to use finishings vs. finishings-col


Documents
---------

Printers report the list of document formats they support in the
["document-format" printer capability attribute](#printer-capability-attributes).
Most IPP printers support standard formats like PDF ('application/pdf'), PWG
Raster ('image/pwg-raster'), and JPEG (image/jpeg). AirPrint printers also
support a simple raster format called Apple Raster ('image/urf').

Many IPP printers also support legacy formats such as Adobe PostScript
('application/postscript'), and HP Page Control Language (PCL,
'application/vnd.hp-pcl'), along with a variety of vendor-specific languages.

The 'application/octet-stream' document format is used to tell the printer it
should automatically detect the format. Detection accuracy varies widely between
printers, so you should specify the actual format whenever possible.


Submitting Print Jobs
---------------------

There are two ways to submit a print job:

- Using the Print-Job operation, and
- Using the Create-Job and Send-Document operations.


### The Print-Job Operation

The Print-Job operation allows you to create a print job and send the document
data in one request. While all IPP printers support this operation, using it
means that you cannot reliably cancel the job while it is being submitted, and
for many document formats this means that the entire job will be printed
before you get the response to the request.

The following `ipptool` test will submit a US Letter print job using the
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

    GROUP job-attributes-tag
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

And this is how you'd print a job using the nodejs API:

```
var ipp = require("ipp");
var fs = require("fs");
var printer = ipp.Printer("http://printer.example.com:631/ipp/print");
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

The Create-Job and Send-Document operations split the job submission into two
steps. You first send a Create-Job request with your job template attributes,
and the printer will return a "job-id" value to identify the new job you've
just created. You then send a Send-Document request with your document data to
complete the job submission. If you want to stop the job while sending the
document data, you can open a separate connection to the printer and send a
Cancel-Job request using the "job-id" value you got from the Create-Job request.

The following `ipptool` test will submit a US Letter print job using the
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

    GROUP job-attributes-tag
    ATTR keyword media "na_letter_8.5x11in"

    EXPECT job-id OF-TYPE integer
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

int job_id = ippGetInteger(ippFindAttribute(response, "job-id", IPP_TAG_INTEGER), 0);

ippDelete(response);

request = ippNewRequest(IPP_OP_SEND_DOCUMENT);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_URI, "printer-uri", NULL, "ipp://printer.example.com/ipp/print");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_INTEGER, "job-id", job_id);
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_NAME, "requesting-user-name", NULL, "John Doe");
ippAddString(request, IPP_TAG_OPERATION, IPP_TAG_MIMETYPE, "document-format", NULL, filetype);

ippDelete(cupsDoFileRequest(http, request, "/ipp/print", filename));

```

And this is how you'd print a job using the nodejs API:

```
var ipp = require("ipp");
var fs = require("fs");
var printer = ipp.Printer("http://printer.example.com:631/ipp/print");
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

var job_id = 0;

printer.execute("Create-Job", msg, function(err, res) {
        console.log(err);
        console.log(res);

	job_id = res["job-id"];
});

var send_msg = {
  "operation-attributes-tag": {
    "job-id": job_id,
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


Summary
-------

IPP print jobs track the state and options of an individual document that has
been submitted for printing. IPP supports a wide range of printing options using
job template attributes. IPP provides two ways to submit print jobs.
