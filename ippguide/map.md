Appendix A: Map of IPP Standards
================================

Core Standards
--------------

These are the core Internet Printing Protocol standards:

- [IPP Everywhere (PWG 5100.14)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippeve10-20130128-5100.14.pdf)
- [IPP 2.0, 2.1, and 2.2 (PWG 5100.12)](https://ftp.pwg.org/pub/pwg/standards/std-ipp20-20151030-5100.12.pdf)
- IPP 1.1 - [Encoding and Transport (RFC 8010)](https://tools.ietf.org/html/rfc8010) - [Model and Semantics (RFC 8011)](https://tools.ietf.org/html/rfc8011)
- [IPP Implementor's Guide (PWG 5100.19)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippig20-20150821-5100.19.pdf)
- [Media Names (PWG 5101.1)](https://ftp.pwg.org/pub/pwg/candidates/cs-pwgmsn20-20130328-5101.1.pdf)

The [IANA IPP Registry](https://www.iana.org/assignments/ipp-registrations)
provides a list of all IPP attributes, values, operations, and status codes with
links to the corresponding standards.


Definitions of Core Job Template Attributes
-------------------------------------------

The following table lists the core Job Template attributes that are supported
by most IPP printers.  You can query the corresponding "xxx-supported"
attributes using the Get-Printer-Attributes operation.

> Note: The syntax column uses the standard IPP data types.  A "1setOf"
> something is an array of one or more values.

| Attribute          | Syntax            | Standard
|--------------------|-------------------|---------------------------------------------------------
| copies             | integer           | [RFC 8011](https://tools.ietf.org/html/rfc8011)
| finishings         | 1setOf enum       | [PWG 5100.1](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings21-20170217-5100.1.pdf)
| finishings-col     | 1setOf collection | [PWG 5100.1](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings21-20170217-5100.1.pdf)
| media              | keyword           | [RFC 8011](https://tools.ietf.org/html/rfc8011)
| media-col          | collection        | [PWG 5100.3](https://ftp.pwg.org/pub/pwg/candidates/cs-ippprodprint10-20010212-5100.3.pdf)
| output-bin         | keyword           | [PWG 5100.2](https://ftp.pwg.org/pub/pwg/candidates/cs-ippoutputbin10-20010207-5100.2.pdf)
| page-ranges        | rangeOfInteger    | [RFC 8011](https://tools.ietf.org/html/rfc8011)
| print-color-mode   | keyword           | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf)
| print-quality      | enum              | [RFC 8011](https://tools.ietf.org/html/rfc8011)
| print-scaling      | keyword           | [PWG 5100.13](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf)
| printer-resolution | resolution        | [RFC 8011](https://tools.ietf.org/html/rfc8011)
| sides              | keyword           | [RFC 8011](https://tools.ietf.org/html/rfc8011)


Printer-Specific Features
-------------------------

These are the Internet Printing Protocol standards that define how to support
specific printer features:

- [Cloud Printing (PWG 5100.18)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippinfra10-20150619-5100.18.pdf)
- [Extended Options (PWG 5100.13)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippjobprinterext3v10-20120727-5100.13.pdf)
- [Fax Output (PWG 5100.15)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfaxout10-20140618-5100.15.pdf)
- [Stapling, Folding, Punching, and Other Finishings (PWG 5100.1)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippfinishings21-20170217-5100.1.pdf)
- Notifications - [Model (RFC 3995)](https://tools.ietf.org/html/rfc3995) - [Get-Notifications Operation (RFC 3996)](https://tools.ietf.org/html/rfc3996)
- [Output Bins (PWG 5100.2)](https://ftp.pwg.org/pub/pwg/candidates/cs-ippoutputbin10-20010207-5100.2.pdf)
- [Page Overrides (PWG 5100.6)](https://ftp.pwg.org/pub/pwg/candidates/cs-ipppageoverride10-20031031-5100.6.pdf)
- [Paid Printing (PWG 5100.16)](https://ftp.pwg.org/pub/pwg/candidates/cs-ipptrans10-20131108-5100.16.pdf)
