files_opds
----------

The OPDS catalog app enables Nextcloud/Owncloud (*-cloud for the rest of this text) users to publish a sub-tree of their personal filesystem as an OPDS feed. Since *-cloud currently has limited to no support for metadata, these are for now stored in a separate table. As of v0.3 OPDS catalog can extract all relevant metadata from EPUB and PDF documents. v0.5 introduced ISBN-based metadata retrieval, while Calibre-generated metadata.opf files are parsed since v0.6. FictionBook 2 (.fb2) metadata is supported from v0.8.0.

#### ISBN
If an ISBN is found in either existing metadata or in the first 10 pages of the publication, metadata is retrieved from ISBNdb (key required, http://isbndb.com/account/logincreate, max. 500 queries/day) and Google Books (no key required). 

#### Calibre
If the directory in which the file is found contains a valid metadata.opf file, this file is parsed and all relevant Dublin Core metadata is applied to all files in the directory. If a cover is specified in this file, and the relevant file is found in the directory, this cover is used as preview and thumbnail for all files in the directory. If the metadata is invalid (ie. one or more of title, author and language are not defined) the files themselves are parsed for metadata in the 'normal' way.

Documents for which no metadata is found will appear with sparse entries for now: only title (as in 'filename'), file size, cover image (where available), modification time and content links are provided. The first visit to a new (or updated) directory will take a bit longer while OPDS catalog scans for metadata, subsequent visits will be faster due to the use of cached metadata.

#### Personal bookshelf
The OPDS root feed links to a hierarchical navigation feed mirroring the directory structure as well as a 'personal bookshelf' containing links to all downloaded books (most recent download listed first). This 'personal bookshelf' will be empty (0 books) at first. Use the 'Browse catalog' link to download a book and it'll appear on the 'personal bookshelf'. Download another, and it will appear above the one you previously downloaded. This makes it possible to get at books you are in the process of reading from different devices, or to easily re-visit a book you downloaded earlier.

The feed is in compliance with the OPDS 1.1 specification according to the online OPDS validator (http://opds-validator.appspot.com/).

In the personal settings page there are options to enable/disable the feed (it is disabled by default), set the feed title, set the feed root directory (the default is /Library), enter a comma-delimited list of extensions to which the feed should be limited (by default this field is empty so it publishes all files descending from the feed root), enter a comma-delimited list of filenames to skip (default is 'metadata.opf,cover.jpg'), schedule a rescan of all metadata and clear the personal bookshelf.

The admin settings page contains options to set the feed subtitle, change file preview preferences (which should probably be in core or in a separate app as this changes a system-wide setting ('enabledPreviewProviders')) and change the cover image and thumbnail dimensions.

The OPDS feed is disabled when the app is installed, enable it in the personal settings page under the header 'OPDS'. Every user has his/her own feed, which feed you get depends on which credentials you enter.

To connect to the OPDS feed, point your OPDS client at the app URL:

     https://example.com/path/to/owncloud/index.php/apps/files_opds/

If all goes well, the client should ask for a username and password - enter your *-cloud credentials here (and make sure you use HTTPS!).

The feed has been tested on these clients:

 - FBReader on Android: OK
 - Aldiko on Android: OK
 - CoolReader on Android: buggy (CoolReader browser adds an extraneous '/' to the URL, probably related to this bug: http://sourceforge.net/p/crengine/bugs/267/)
 - KyBook on iOS: OK
 - Marvin on iOS: OK
 - eBook Search on iOS: browsing works, downloading does not (401 error, 'Unauthorised')
 - Gecko-based browsers: OK, feed can be browsed and books can be downloaded without additional software.
