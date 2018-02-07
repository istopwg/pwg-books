Introduction
============


What is IPP?
------------

IPP - the Internet Printing Protocol - is an application level protocol that
enables a Client to communicate with a Printer using a rich vocabulary of operations and descriptive attributes. IPP allows a Client to inquire about the Printer's attributes (name, printer UUID, make and model, security capabilities, and many others), acquire a description of the Printer's capabilities and default job settings (supported media sizes and types, two-sided printing, etc.), create Jobs to submit files for printing, inquire about and manage or cancel submitted print Jobs, and monitor the state of the Printer (paper out/jam, low ink/toner, etc.). IPP supports not only print but also fax and scan, and has extensions that support the creation of complex print system interactions.

IPP was first developed by a working group in the Internet Engineering Task
Force (IETF) in 1998. IPP continues to be developed and maintained by the
[Printer Working Group](https://www.pwg.org/ipp), a program of the IEEE
Industry Standard and Technology Organization (IEEE-ISTO), through the publication of its own standards such as [IPP/2.0](http://ftp.pwg.org/pub/pwg/standards/std-ipp20-20151030-5100.12.pdf), as well as maintaining and updating the IETF RFCs including [RFC 8010](https://tools.ietf.org/html/rfc8010), [RFC 8011](https://tools.ietf.org/html/rfc8011) and [RFC 7472](https://tools.ietf.org/html/rfc7472).

IPP is supported by almost all printers sold today. Its rich suite of semantics and descriptive capabilities allow IPP to replace all vendor-specific network printing protocols, including "PDL Datastream" (port 9100) and LPD/lpr. Several universal print ecosystems have been built around IPP, including the PWG's own [IPP Everywhere™](http://ftp.pwg.org/pub/pwg/candidates/cs-ippeve10-20130128-5100.14.pdf).

IPP is heavily influenced by the printing model first introduced in the
Document Printing Application (ISO 10175) standard.  The same model is exposed
by the SNMP Printer and Job Monitoring MIBs, the PWG Semantic Model, and
Microsoft's Web Services Print.

IPP is widely implemented, including the following open source projects:

- [CUPS](https://www.cups.org/)
- [Java IPP Client Implementation](https://code.google.com/archive/p/jspi/)
- [Javascript IPP Client Implementation](https://github.com/williamkapke/ipp)
- [Python IPP Client Implementation](http://www.pykota.com/software/pkipplib/)
- [PWG IPP Sample Code](https://istopwg.github.io/ippsample)





IPP Overview
------------

The architecture for IPP defines an abstract data Model to provide information
about the printing process and the capabilities of the Printer.  This abstract
Model is hierarchical in nature and reflects the structure of the Printer and
the Jobs and Documents processed by the Printer.  Because the semantics of IPP
are attached to the (abstract) Model, the Client does not need to know the
implementation-specific details of the Printer.

IPP defines an encoding of the data in the Model for transfer between the
Client and Printer.  Clients send a request and then read a response using a
simple binary encoding.  Each request and response message has a version
number, an operation (request) or status (response) code, a request number, and
a list of attributes.  Each attribute has a type (keyword, URI, integer, etc.),
name, and zero or more values.  IPP messages can be followed by data such as
the file to print.

IPP uses HTTP as its transport protocol.  Each IPP request is a HTTP POST with
the IPP message data (and print file, if any) in the request message body.
The corresponding IPP response is returned in the POST response message body.
HTTP connections can be unencrypted, upgraded to TLS using an HTTP OPTIONS
request, or encrypted immediately (HTTPS).  HTTP POST requests can be
authenticated using any of the standard HTTP mechanisms.


Key Concepts
------------

- URIs, operations, attributes, attribute groups.


URIs
----

- URIs are a general form of URLs used in web browsers.

- Talk about IPP (ipp:) and IPPS (ipps:) URIs being the equivalent of HTTP
  (http:) and HTTPS (https:) URLs, but on port 631 by default.

- Prefer using IPPS

- Talk about resource path (/ipp/print is now common, but not in the past)


Operations
----------

- List some common operations

- Show how client does a POST with application/ipp messages, gets a response in
  the same format.

- Operation code in request, status code in response, request ID and version in
  both.


### Requests

- Common values in request (operation code, version, request ID, printer URI,
  job ID for job requests)


### Responses

- Common values in response (status code, version, request ID)


Attributes
----------

- Name, type ("syntax"), and zero or more values.
- List of (common) syntaxes
- Examples


### Attribute Groups

- Used to group zero or more related attributes.

- Groups for operation (request/response), Printer, Job, etc.

- Special "end of attributes" group at the end of the IPP message.
