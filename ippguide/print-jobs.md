Print Jobs
==========


What are Print Jobs?
--------------------

- Definition

- Parts of a job object: status + description attributes, document(s)

- Job ticket (intent for printing): Job Template attributes in Job Creation
  request.


Job Description Attributes
--------------------------

- Important attributes: job-name, others?


Job Status Attributes
---------------------

- Important attributes: job-id, job-impressions[-completed],
  job-pages[-completed], job-originating-user-name, job-state, job-state-reasons


Job Template Attributes
-----------------------

- Important attributes: copies, finishings/finishings-col, media/media-col,
  page-ranges, print-color-mode, print-quality, print-scaling,
  printer-resolution, sides


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
