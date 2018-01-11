Introduction
============



What is IPP?/About This Book
----------------------------

IPP is an application level protocol used for distributed printing that leverages existing and emerging Internet technologies.  The protocol allows a client to inquire about capabilities and defaults of a printer, to submit print jobs and to inquire about and cancel print jobs.  The protocol also allows a client to inquire about the state of the printer and, with appropriate permissions, modify the printer state.

The architecture for IPP defines an abstract data Model to provide information about the printing process and the capabilities of the Printer.  The abstract Model is heavily influenced by the printing model introduced in the Document Printing Application [ISO10175] standard. This abstract Model is hierarchical in nature.  It reflects the structure of the Printer and the Jobs and Documents processed by the Printer.  The semantics of IPP are attached to the (abstract) Model. Therefore, the application/server is not dependent on the encoding of the Model data, and it is possible to consider alternative mechanisms and formats by which the data could be transmitted from a client to a server.

The Printer Working Group maintains a Semantic Model that is defined independently of any encoding of the Model data both to support the likely uses of IPP and to be robust with respect to the possibility of alternate encoding.  An example of a different encoding and transmission mechanism is Microsoft&#39;s WS-Print [[WS\_PRINT](https://docs.microsoft.com/en-us/windows-hardware/drivers/print/ws-print-v1-1)].  Having an abstract Model also allows the Model data to be aligned with the (abstract) model used in the Printer [[RFC3805](https://tools.ietf.org/html/rfc3805)], Job[[RFC2707](https://tools.ietf.org/html/rfc2707)] and Host Resources[[RFC2790](https://tools.ietf.org/html/rfc2790)]  MIBs. This provides consistency in interpretation of the data obtained independently of how the data is accessed, whether via IPP or via the Simple Network Management Protocol (SNMP) and the Printer/Job MIBs.

IPP defines an encoding of the data in the model for transfer between the client and server.  This transfer of data may be either a request or the response to a request.  A fully encoded request/response has a version number, an operation (for a request) or a status and optionally a status message (for a response), associated parameters and attributes from the Model and, optionally (for a request), print data following a print request.

To make it simpler to develop embedded printers, a very simple binary encoding has been chosen.  An XML encoding was considered.  But at the time the XML datatypes were not standardized and could not be used in the IPP standard.  The very simple binary encoding is adequate to represent the kinds of data that occur within the Model. It has a simple structure consisting of sequences of attributes. Each attribute has a name, prefixed by a name length, and a value. The names are strings constrained to characters from a subset of ASCII.  The values are either scalars or a sequence of scalars. Each scalar value has a length specification and a value tag which indicates the type of the value. The value type has two parts: a major class part, such as integer or string, and a minor class part which distinguishes the usage of the major class, such as dateTime string.  Tagging of the values with type information allows for introducing new value types at some future time.

The chosen network transport for IPP is an HTTP Post (and associated response). No modifications to HTTP are proposed or required.  The primary reasons for selecting HTTP are:

- HTTP is widely deployed
- HTTP allows persistent connections that make a multi-message protocol be more efficient
- Chunking allows the transmission of large print files without having to pre-scan the file to determine the file length.
- The accept headers allow the client&#39;s protocol and localization desires to be transmitted with the IPP operations and data.
- Most network Printers will be implementing HTTP servers for reasons other than IPP.
- HTTP based solution fits well with the Internet security mechanisms that are currently deployed or being deployed.
- HTTP provides an extensibility model that a new protocol would have to develop independently. In particular, the headers, intent-types (via Internet Media Types) and error codes have wide acceptance and a useful set of definitions and methods for extension.

- Scope: (enterprise) application developers wanting to print reports, billing, logs, etc. and/or monitoring printers

- High level capabilities, security features

- Supported by 98+% of all printers sold today (outliers are mainly industrial
  printers)

- Brief history (when, who, talk about port 9100 and LPD that preceded it)

- Resources - ippsample project (ipptool, ippfind, ippserver), Node.js IPP
  support, etc.


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


References
----------

[RFC2567] F.D. Wright, &quot; Design Goals for an Internet Printing Protocol &quot;, RFC 2567, April 1999, [https://tools.ietf.org/html/rfc2567](https://tools.ietf.org/html/rfc2567)

[RFC2568] S. Zilles, &quot;Rationale for the Structure of the Model and Protocol for the Internet Printing Protocol&quot;, RFC 2568, April 1999, [https://tools.ietf.org/html/rfc2568](https://tools.ietf.org/html/rfc2568)

[RFC2569] R. Herriot, N. Jacobs, T. Hastings, J. Martin, &quot;Mapping between LPD and IPP Protocols&quot;, RFC 2569, April 1999, [https://tools.ietf.org/html/rfc2569](https://tools.ietf.org/html/rfc2569)

[RFC2707] R. Bergman, T. Hastings, S. Isaacson, H. Lewis, &quot;Job Monitoring MIB v1&quot;, RFC 2707, November 1999, [https://tools.ietf.org/html/rfc2707](https://tools.ietf.org/html/rfc2707)

[RFC2790] S. Waldbusser, P. Grillo, &quot;Host Resources MIB&quot;, RFC 2790, March 2000, [https://tools.ietf.org/html/rfc2790](https://tools.ietf.org/html/rfc2790)

[RFC3805] R. Bergman, H. Lewis, I. McDonald, &quot;Printer MIB v2&quot;, RFC 3805, June 2004, [https://tools.ietf.org/html/rfc3805](https://tools.ietf.org/html/rfc3805)

 [ISO10175] ISO/IEC 10175, Document Printing Application, June 1996.

[WS-PRINT] WS-Print, Print Service Definition Version 1.2, July 2013, [https://docs.microsoft.com/en-us/windows-hardware/drivers/print/ws-print-v1-1](https://docs.microsoft.com/en-us/windows-hardware/drivers/print/ws-print-v1-1)
