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

| Job Attribute (syntax)             | Printer Attribute (Syntax)                       | Standard                                        |
|------------------------------------|--------------------------------------------------|-------------------------------------------------|
| copies (integer)                   | copies-supported (integer)                       | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| finishings (1setOf enum)           | finishings-ready (1setOf enum)                   | [PWG 5100.1](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings21-20170217-5100.1.pdf) |
| finishings-col (1setOf collection) | finishings-col-ready (1setOf collection)         | [PWG 5100.1](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings21-20170217-5100.1.pdf) |
| media (keyword)                    | media-ready (1setOf keyword)                     | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| media-col (collection)             | media-col-ready (1setOf collection)              | [PWG 5100.3](https://ftp.pwg.org/pub/pwg/candidates/cs-ippprodprint10-20010212-5100.3.pdf) |
| output-bin (keyword)               | output-bin-supported (1setOf keyword)            | [PWG 5100.2](https://ftp.pwg.org/pub/pwg/candidates/cs-ippoutputbin10-20010207-5100.2.pdf) |
| page-ranges (rangeOfInteger)       | page-ranges-supported (boolean)                  | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| print-color-mode (keyword)         | print-color-mode-supported (1setOf keyword)      | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| print-quality (enum)               | print-quality-supported (1setOf enum)            | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| print-scaling (keyword)            | print-scaling-supported (1setOf keyword)         | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-resolution (resolution)    | Printer-resolution-supported (1setOf resolution) | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| sides (keyword)                    | sides-supported (1setOf keyword)                 | [RFC 8011](https://tools.ietf.org/html/rfc8011) |


Common Printer Attributes
-------------------------

The following table lists the common Printer attributes that are supported by
most IPP Printers.  You can query them using the Get-Printer-Attributes
operation.

> Note: The syntax uses the standard IPP data types.  A "1setOf something" is
> an array of one or more values.

| Printer Attribute (Syntax)                                   | Standard                                        |
|--------------------------------------------------------------|------------------------------------------------ |
| document-format-supported (1setOf mimeMediaType)             | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| ipp-features-supported (1setOf keyword)                      | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf)  |
| ipp-versions-supported (1setOf keyword)                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| job-creation-attributes-supported (1setOf keyword)           | [PWG 5100.11](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext10-20101030-5100.11.pdf) |
| operations-supported (1setOf enum)                           | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-alert (1setOf octetString)                           | [PWG 5100.9](https://ftp.pwg.org/pub/pwg/candidates/cs-ippstate10-20090731-5100.9.pdf)
| Printer-alert-description (1setOf text)                      | [PWG 5100.9](https://ftp.pwg.org/pub/pwg/candidates/cs-ippstate10-20090731-5100.9.pdf)
| Printer-geo-location (uri)                                   | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-info (text)                                          | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-input-tray (1setOf octetString)                      | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-is-accepting-jobs (boolean)                          | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-location (text)                                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-make-and-model (text)                                | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-more-info (uri)                                      | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-name (name)                                          | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-output-tray (1setOf octetString)                     | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-state (enum)                                         | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-state-reasons (1setOf keyword)                       | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
| Printer-strings-languages-supported (1setOf naturalLanguage) | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-strings-uri (uri)                                    | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-supply (1setOf octetString)                          | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-supply-description (1setOf text)                     | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-supply-info-uri (uri)                                | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf) |
| Printer-uri-supported (1setOf uri)                           | [RFC 8011](https://tools.ietf.org/html/rfc8011) |
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

- [IPP Everywhere (PWG 5100.14)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippeve10-20130128-5100.14.pdf)
- [IPP 2.0, 2.1, and 2.2 (PWG 5100.12)](https://ftp.pwg.org/pub/pwg/standards/std-ipp20-20151030-5100.12.pdf)
- IPP 1.1 - [Encoding and Transport (RFC 8010)](https://tools.ietf.org/html/rfc8010) - [Model and Semantics (RFC 8011)](https://tools.ietf.org/html/rfc8011)
- [IPP Implementor's Guide (PWG 5100.19)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippig20-20150821-5100.19.pdf)

These are the standards for media naming and the common file formats:

- [Media Names (PWG 5101.1)](https://ftp.pwg.org/pub/pwg/candidates/cs-pwgmsn20-20130328-5101.1.pdf)
- [Portable Document Format (ISO 32000-1)](http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/pdf/pdfs/PDF32000_2008.pdf)
- [PWG Raster Format (PWG 5102.4)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippraster10-20120420-5102.4.pdf)

These are the Internet Printing Protocol standards that define how to support
specific Printer features:

- [Alerts (PWG 5100.9)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippstate10-20090731-5100.9.pdf)
- [Cloud Printing (PWG 5100.18)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippinfra10-20150619-5100.18.pdf)
- Extended Options - [Set 2 (PWG 5100.11)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext10-20101030-5100.11.pdf) - [Set 3 (PWG 5100.13)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf)
- [Fax Output (PWG 5100.15)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfaxout10-20140618-5100.15.pdf)
- [Stapling, Folding, Punching, and Other Finishings (PWG 5100.1)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings21-20170217-5100.1.pdf)
- Notifications - [Model (RFC 3995)](https://tools.ietf.org/html/rfc3995) - [Get-Notifications Operation (RFC 3996)](https://tools.ietf.org/html/rfc3996)
- [Output Bins (PWG 5100.2)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippoutputbin10-20010207-5100.2.pdf)
- [Page Overrides (PWG 5100.6)](https://ftp.pwg.org/pub/pwg/candidates/cs-ipppageoverride10-20031031-5100.6.pdf)
- [Paid Printing (PWG 5100.16)](https://ftp.pwg.org/pub/pwg/candidates/cs-ipptrans10-20131108-5100.16.pdf)
