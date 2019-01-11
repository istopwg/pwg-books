Preface
=======

What is IPP?
------------

The Internet Printing Protocol ("IPP") is a secure application level protocol
used for network printing.  IPP defines high-level Printer, Job, and Document
objects, allowing Clients to ask a Printer about capabilities and defaults
(supported media sizes, two-sided printing, etc.), the state of the Printer
(paper out/jam, low ink/toner, etc.) and any Print Jobs and their Documents.
The Client can also submit document files for printing and subsequently cancel
them. IPP is supported by all modern network Printers and supercedes all legacy
network protocols including port 9100 printing and LPD/lpr.

IPP is widely implemented in software as well, including the following open
source projects:

- C-based: [CUPS](https://www.cups.org/) and
  [PWG IPP Sample Code](https://istopwg.github.io/ippsample)
- Java: [Java IPP Client Implementation](https://code.google.com/archive/p/jspi/)
  and
  [Core parser for a Java implementation of IPP](https://github.com/HPInc/jipp)
- [Javascript IPP Client Implementation](https://github.com/williamkapke/ipp)
- [Python IPP Client Implementation](http://www.pykota.com/software/pkipplib/)

While IPP spans over 40 specifications and almost 2000 pages, the core protocol
needed to support most printing needs is small enough to run on any hardware.


Terms Used in this Document
---------------------------

A *Client* is the Client device (computer, phone, tablet, etc.) that initiates
connections and sends requests to Printers.

A *Printer* is an instance of an IPP Printer object and represents a real or
visual Printer or print queue.  Printers listen for connections from Clients
and maintain a list of Jobs for processing.

A *Job* is an instance of an IPP job object and represents work for a Printer to
do.  Jobs are associated with a single Printer and contain Documents to process.

A *Document* is an instance of an IPP document object that represents a file or
URI.  Documents are associated with a single Job.


Organization of this Guide
--------------------------

This guide is organized into three chapters and an appendix:

- Chapter 1, [Overview of IPP](#chapter-1-overview-of-ipp), provides an
  overview of the Internet Printing Protocol;
- Chapter 2, [Printers](#chapter-2-printers), describes the IPP Printer object,
  its operations, and its attributes;
- Chapter 3, [Jobs and Documents](#chapter-3-jobs-and-documents), describes the
  IPP job and document objects and their operations and attributes; and
- Appendix A, [Quick Reference](#appendix-a-quick-reference), provides a summary
  of IPP operations, attributes, and values with links to the corresponding
  specifications.
