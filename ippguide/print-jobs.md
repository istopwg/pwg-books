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
"xxx-actual" for each job ticket attribute, for example "copies-actual",
"media-actual", and so forth.


### Job Description Attributes

Jobs provide many descriptive attributes, including the job's name ("job-name")
and page counts ("job-impressions", "job-media-sheets", and "job-pages") which
are provided in the job creation request (Create-Job or Print-Job).


### Job Template Attributes

The job ticket ("copies", "media", etc.),

Documents
---------

- Standard formats: PDF, PWG Raster, JPEG

- Historical formats: PostScript, PCL, other vendor PDLs


Submitting Print Jobs
---------------------

- Using Create-Job + Send-Document

- When to use media vs. media-col

- When to use finishings vs. finishings-col

- ipptool examples

- CUPS API examples

- Node.js examples

Further Reading
---------------

Links to additional reading - IIG 2, etc.
