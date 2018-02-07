Printers
========


What are Printers?
--------------------

- Definition

- Parts of a printer object: status + description attributes, job(s)

- Capabilities and defaults (-supported and -default attributes corresponding to
  Job Template attributes)


Printer Description Attributes
------------------------------

- Important attributes:
  - printer-name
  - printer-uuid
  - printer-make-and-model
  - printer-more-info
  - printer-geo-location
  - printer-location
  - printer-supply-info-uri
  - printer-uri-supported
  - printer-xri-supported,
  - uri-authentication-supported
  - uri-security-supported


Printer Status Attributes
-------------------------

- Important attributes: printer-input-tray, printer-output-tray, printer-state,
  printer-state-reasons, printer-supply, printer-supply-description, others?


Printer Capability Attributes
-----------------------------

- Important attributes: copies, finishings/finishings-col, media/media-col,
  page-ranges, print-color-mode, print-quality, print-scaling,
  printer-resolution, sides


Common Tasks
------------

### Check Job and Printer Status

- Polling with Get-Printer-Attributes, Get-Jobs, Get-Job-Attributes

- ipptool examples

- CUPS API examples

- Node.js examples
