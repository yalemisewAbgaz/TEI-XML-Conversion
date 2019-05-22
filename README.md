# TEI-XML-Conversion
This repository contains all the files that are related to the TEI-XML to RDF conversion carried out at Adapt centre.

To run this application 
1. start your mysql database
Make sure you supply the credential in handleDd.py under TEIXMLDB folder
from the support files, you can import the structure of the database using TEI_XML_DB.sql
or you can run Schema.sql in mysql database. If you decide to try generating the data again, run ResetAutoIncrements.sql in mysql
It will generate a fresh table by removing all the previous content.

2.in the xmlparser_xpath.py, specify the directory where you store the xml files (190-199)

3. Run the code and the conversion will start.

Note:
The code doesn't convert extract place names,
There are a couple of attributes that are not extracted (see the code)


