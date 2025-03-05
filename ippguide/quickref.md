Appendix A: Quick Reference
================================

Tools and Libraries
-------------------

Network debugging tools:

- [Wireshark](https://wireshark.org)

Libraries and sample code:

- C-based: [CUPS](https://www.cups.org/) and
  [PWG IPP Sample Code](https://istopwg.github.io/ippsample)
- Java: [Java IPP Client Implementation](https://code.google.com/archive/p/jspi/)
  and
  [Core parser for a Java implementation of IPP](https://github.com/HPInc/jipp)
- [Javascript IPP Client Implementation](https://github.com/williamkapke/ipp)
- [Python IPP Client Implementation](http://www.pykota.com/software/pkipplib/)


Common Operations
-----------------

The following table lists the common IPP operations (all defined in
[RFC 8011](https://tools.ietf.org/html/rfc8011)) and the commonly-used
attributes.  Each request always starts with the following three attributes:

- "attributes-charset (charset)": Usually "utf-8".
- "attributes-natural-language (naturalLanguage)": Often just "en", the format
  is either "ll" or "ll-cc" where "ll" is the two-letter language code and "cc"
  is the country/region code.
- "printer-uri (uri)": Usually "ipp://*address*/ipp/print" or
  "ipps://*address*/ipp/print".

> Note: The syntax uses the standard IPP data types.  Except for Job attributes,
> all attributes are in the operation group.  The "document-format" attribute
> is optional for the Get-Printer-Attributes operation but highly recommended.

| Operation              | Required Attributes (syntax)                  | Optional Attributes (syntax)                                                   |
|------------------------|-----------------------------------------------|--------------------------------------------------------------------------------|
| Cancel-Job             | job-id (integer), requesting-user-name (name) |                                                                                |
| Create-Job             | requesting-user-name (name), job-name (name)  | [Job Attributes](#common-job-attributes)                                       |
| Get-Job-Attributes     | job-id (integer), requesting-user-name (name) | requested-attributes (1setOf keyword)                                          |
| Get-Jobs               | requesting-user-name (name)                   | my-jobs (boolean), requested-attributes (1setOf keyword), which-jobs (keyword) |
| Get-Printer-Attributes |                                               | document-format (mimeMediaType), requested-attributes (1setOf keyword)         |
| Print-Job              | requesting-user-name (name), job-name (name)  | [Job Attributes](#common-job-attributes)                                       |
| Send-Document          | job-id (integer), requesting-user-name (name) | document-format (mimeMediaType), document-name (name)                          |


Common Document Formats
-----------------------

The "document-format" attribute specifies the format of a print file.  The
following is a list of common formats used for printing:

- "application/pdf": Portable Document Format (PDF) files.
- "application/postscript": Adobe PostScript files (legacy).
- "application/vnd.hp-pcl": HP Page Control Language (PCL) files (legacy).
- "image/jpeg": JPEG images.
- "image/pwg-raster": PWG Raster Format files.
- "image/urf": Apple Raster files (AirPrint).
- "text/plain": Plain (ASCII) text with CR LF line endings (legacy).


Common Job Attributes
---------------------

The following table lists the common Job attributes that are supported by most
IPP Printers in the Create-Job and Print-Job operations.  You can query the
corresponding Printer attributes using the Get-Printer-Attributes operation,
just remember to send a "document-format (mimeMediaType)" attribute to get the
values for the file format you are using.

> Note: The syntax uses the standard IPP data types.  A "1setOf something" is
> an array of one or more values.  The "finishings-ready" and "media-ready"
> Printer attributes should be used when available, otherwise use the
> "finishings-supported" and "media-supported" attributes.  Similarly, the
> "finishings-col-ready" and "media-col-ready" Printer attributes should be used
> when available, otherwise use the "finishings-col-database" and
> "media-col-database" attributes.

| Job Attribute (syntax)             | printer Attribute (Syntax)                       | Standard                                        |
|------------------------------------|--------------------------------------------------|-------------------------------------------------|
| copies (integer)                   | copies-supported (integer)                       | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| finishings (1setOf enum)           | finishings-ready (1setOf enum)                   | [PWG 5100.1](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings30-20220527-5100.1.pdf) |
| finishings-col (1setOf collection) | finishings-col-ready (1setOf collection)         | [PWG 5100.1](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings30-20220527-5100.1.pdf) |
| media (keyword)                    | media-ready (1setOf keyword)                     | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
|                                    | media-supported (1setOf keyword)                 | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| media-col (collection)             | media-col-database (1setOf collection)           | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-col-ready (1setOf collection)              | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-color-supported (1setOf keyword|name)      | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-bottom-margin-supported (1setOf integer)   | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-left-margin-supported (1setOf integer)     | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-right-margin-supported (1setOf integer)    | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-size-supported (1setOf collection)         | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-source-supported (1setOf keyword|name)     | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-top-margin-supported (1setOf integer)      | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
|                                    | media-type-supported (1setOf keyword|name)       | [PWG 5100.7](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf) |
| output-bin (keyword)               | output-bin-supported (1setOf keyword)            | [PWG 5100.2](https://ftp.pwg.org/pub/pwg/candidates/cs-ippoutputbin10-20010207-5100.2.pdf) |
| page-ranges (rangeOfInteger)       | page-ranges-supported (boolean)                  | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| print-color-mode (keyword)         | print-color-mode-supported (1setOf keyword)      | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippnodriver20-20230301-5100.13.pdf) |
| print-quality (enum)               | print-quality-supported (1setOf enum)            | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| print-scaling (keyword)            | print-scaling-supported (1setOf keyword)         | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippnodriver20-20230301-5100.13.pdf) |
| printer-resolution (resolution)    | printer-resolution-supported (1setOf resolution) | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| sides (keyword)                    | sides-supported (1setOf keyword)                 | [RFC 8011](https://tools.ietf.org/html/rfc8011) |


### media and media-col

The "media" and "media-col" Job Template attributes specify the media for the
print job.  The "media" attribute specifies a self-describing size name such as
"na_letter_8.5x11in" or "iso_a4_210x297mm".  The name consists of a prefix -
"na" for North American sizes, "iso" for international sizes, "custom" for
custom sizes, "roll" for roll-fed sizes, and so forth - an English descriptive
name - "letter", "a4", etc. - and the width and length dimensions followed by
"in" for inches or "mm" for millimeters.

When more control over media is needed, the "media-col" attribute specifies the
color, margins, size, source, and/or type that is needed for a print job.  The
"media-col-database" and "media-col-ready" Printer attributes list the supported
or available combinations, while the corresponding "media-xxx-supported" Printer
attributes list the supported values overall.


Common Printer Attributes
-------------------------

The following table lists the common Printer attributes that are supported by
most IPP Printers.  You can query them using the Get-Printer-Attributes
operation.

> Note: The syntax uses the standard IPP data types.  A "1setOf something" is
> an array of one or more values.

| printer Attribute (Syntax)                                   | Standard                                        |
|--------------------------------------------------------------|------------------------------------------------ |
| document-format-supported (1setOf mimeMediaType)             | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| ipp-features-supported (1setOf keyword)                      | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf)  |
| ipp-versions-supported (1setOf keyword)                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| job-creation-attributes-supported (1setOf keyword)           | [PWG 5100.11](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext10-20101030-5100.11.pdf) |
| operations-supported (1setOf enum)                           | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-alert (1setOf octetString)                           | [PWG 5100.9](https://ftp.pwg.org/pub/pwg/candidates/cs-ippstate10-20090731-5100.9.pdf)
| printer-alert-description (1setOf text)                      | [PWG 5100.9](https://ftp.pwg.org/pub/pwg/candidates/cs-ippstate10-20090731-5100.9.pdf)
| printer-geo-location (uri)                                   | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-info (text)                                          | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-input-tray (1setOf octetString)                      | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-is-accepting-jobs (boolean)                          | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-location (text)                                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-make-and-model (text)                                | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-more-info (uri)                                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-name (name)                                          | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-output-tray (1setOf octetString)                     | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-state (enum)                                         | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-state-reasons (1setOf keyword)                       | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| printer-strings-languages-supported (1setOf naturalLanguage) | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-strings-uri (uri)                                    | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-supply (1setOf octetString)                          | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-supply-description (1setOf text)                     | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-supply-info-uri (uri)                                | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| printer-uri-supported (1setOf uri)                           | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| pwg-raster-document-resolution-supported (1setOf resolution) | [PWG 5102.4](https://ftp.pwg.org/pub/pwg/candidates/cs-ippraster10-20120420-5102.4.pdf) |
| pwg-raster-document-sheet-back (keyword)                     | [PWG 5102.4](https://ftp.pwg.org/pub/pwg/candidates/cs-ippraster10-20120420-5102.4.pdf) |
| pwg-raster-document-type-supported (1setOf keyword)          | [PWG 5102.4](https://ftp.pwg.org/pub/pwg/candidates/cs-ippraster10-20120420-5102.4.pdf) |
| uri-authentication-supported (1setOf keyword)                | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| uri-security-supported (1setOf keyword)                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |


Standards
---------

The [IANA IPP Registry](https://www.iana.org/assignments/ipp-registrations)
provides a list of all IPP attributes, values, operations, and status codes with
links to the corresponding standards.

These are the core Internet Printing Protocol standards:

- [IPP Everywhere (PWG 5100.14)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippeve11-20200515-5100.14.pdf)
- [Internet Printing Protocol/2.x: Fourth Edition (PWG 5100.12)](https://ftp.pwg.org/pub/pwg/standards/std-ippbase23-20241108-5100.12.pdf)
- IPP 1.1 - [Encoding and Transport (RFC 8010)](https://tools.ietf.org/html/rfc8010) - [Model and Semantics (RFC 8011)](https://tools.ietf.org/html/rfc8011)
- [IPP Implementor's Guide (PWG 5100.19)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippig20-20150821-5100.19.pdf)

These are the standards for media naming and the common file formats:

- [Media Names (PWG 5101.1)](https://ftp.pwg.org/pub/pwg/candidates/cs-pwgmsn21-20230915-5101.1.pdf)
- [Portable Document Format](https://pdfa.org/resource/pdf-specification-archive/)
- [PWG Raster Format (PWG 5102.4)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippraster10-20120420-5102.4.pdf)

These are the Internet Printing Protocol standards that define how to support
specific Printer features:

- [Alerts (PWG 5100.9)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippstate10-20090731-5100.9.pdf)
- [Cloud Printing (PWG 5100.18)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippinfra10-20150619-5100.18.pdf)
- [Driver Replacement Extensions (PWG 5100.13)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippnodriver20-20230301-5100.13.pdf)
- [Enterprise Printing Extensions (PWG 5100.11)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippepx20-20240315-5100.11.pdf)
- [Fax Output (PWG 5100.15)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfaxout10-20140618-5100.15.pdf)
- [Job Extensions (PWG 5100.7)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobext21-20230210-5100.7.pdf)
- Notifications - [Model (RFC 3995)](https://tools.ietf.org/html/rfc3995) - [Get-Notifications Operation (RFC 3996)](https://tools.ietf.org/html/rfc3996)
- [Output Bins (PWG 5100.2)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippoutputbin10-20010207-5100.2.pdf)
- [Page Overrides (PWG 5100.6)](https://ftp.pwg.org/pub/pwg/candidates/cs-ipppageoverride10-20031031-5100.6.pdf)
- [Paid Printing (PWG 5100.16)](https://ftp.pwg.org/pub/pwg/candidates/cs-ipptrans11-20200327-5100.16.pdf)
- [Production Printing Extensions (PWG 5100.3)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippppx20-20230131-5100.3.pdf)
- [Stapling, Folding, Punching, and Other Finishings (PWG 5100.1)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings30-20220527-5100.1.pdf)
