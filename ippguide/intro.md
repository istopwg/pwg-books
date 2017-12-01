Introduction
============



What is IPP?/About This Book
----------------------------

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
