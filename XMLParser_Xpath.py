from lxml import etree
from TEIXMLDB.handleDB import *
import time
import os
from termcolor import colored
import configparser
import re


class Usage:
    def getPlaces(self, path, nsmap):
        print("entered here", path)
        for usgPlace in path.xpath('./xmlns:listPlace', namespaces=nsmap):
            usgPlaceNameType = usgPlace.xpath('./@type', namespaces=nsmap)
            usgListPlaceRef = usgPlace.xpath('./@ref', namespaces=nsmap)
            usgPlaceName = usgPlace.xpath('./text()', namespaces=nsmap)
            print("\t\tUsgPlace", usgPlaceNameType, " ", usgListPlaceRef, " ", usgPlaceName)

            for placeList in usgPlace.xpath('./xmlns:place', namespaces=nsmap):
                usgPlaceNameType = placeList.xpath('./@type', namespaces=nsmap)
                usgListPlaceName = placeList.xpath('./xmlns:placeName/text()', namespaces=nsmap)
                usgListPlaceId = placeList.xpath('./xmlns:idno/text()', namespaces=nsmap)
                usgListPlaceRef = placeList.xpath('./@ref', namespaces=nsmap)
                print("---\t\t\tUsgPlace", usgPlaceNameType, " ", usgListPlaceName, usgListPlaceId)
                listPlace = placeList.xpath('./xmlns:listPlace', namespace=nsmap)
                self.getPlaces(listPlace, nsmap)


class XMLParser:
    teiDb = database()
    places = []

    def readDirectory(self, rootdir):
        teiFiles = []
        for subdir, dirs, files in os.walk(rootdir):
            # if dirs in ('bel_d-tei-02','bel_m-tei-02','bel_e-tei-02','bel_k-tei-02','bel_g-tei-02'):
            #     continue
            for file in files:
                # print os.path.join(subdir, file)
                filepath = subdir + os.sep + file

                if filepath.endswith("TEI-02.xml"):
                    print(filepath)
                    teiFiles.append(filepath)
        return teiFiles

    def getListPlace(self, xml, ref, cur_usage_id, nsmap):
        xml = xml.xpath('./xmlns:place', namespaces=nsmap)
        while xml:
            placeType = ""
            placeName = ""
            placeId = ""

            xml = xml[0]
            usgPlaceNameType = xml.xpath('./@type', namespaces=nsmap)
            usgListPlaceName = xml.xpath('./xmlns:placeName/text()', namespaces=nsmap)
            usgListPlaceId = xml.xpath('./xmlns:idno/text()', namespaces=nsmap)
            # usgListPlaceRef = xml.xpath('./@ref', namespaces=nsmap)
            if len(usgPlaceNameType) > 0:
                placeType = usgPlaceNameType[0]
            if len(usgListPlaceName) > 0:
                placeName = usgListPlaceName[0]
            if len(usgListPlaceId) > 0:
                placeId = usgListPlaceId[0]

            self.places.append((ref, placeType, placeName, placeId, cur_usage_id))

            xml = xml.xpath('./xmlns:listPlace', namespaces=nsmap)

            if xml is not None and len(xml) > 0:
                xml = xml[0]
                self.getListPlace(xml, ref, cur_usage_id, nsmap)
    def split_question_number(self, question):
        items =[]
        match = re.match(r"([\d]{1,3})([a-z|A-Z]+[0-9]+[a-z|A-Z]*)|(\d]{3})([a-z|A-Z]+[0-9]+)", question, re.I)

        if match:
            items = match.groups()
        return items

    def parseAndSaveXML(self, file):
        t0 = time.time()
        teiDb = self.teiDb

        try:
            tree = etree.parse(file)
        except:
            print("Error")
            return


        nsmap = tree.getroot().nsmap.copy()
        # then puts the default xmlns in ti a xmlns
        nsmap['xmlns'] = nsmap.pop(None)


        for entry in tree.xpath('/xmlns:TEI/xmlns:text/xmlns:body/xmlns:entry', namespaces=nsmap):
            # Get the id and the language of the Entry and represent it as an entity
            entryId = entry.xpath('./@xml:id')
            entrylang = entry.xpath('./@xml:lang')
            # print("Entry ", entryId, " ", entrylang)
            teiDb.saveEntry(entryId, entrylang)
            EntryId = teiDb.getEntryId(entryId)
            cur_formId = None
            orthCollection = []
            gramGrpCollection = []
            pronCollection = []
            for form in entry.xpath('./xmlns:form', namespaces=nsmap):
                formType = form.xpath('./@type')
                formN = form.xpath('./@n')
                print("\tForm", formType, formN)
                if formType[0] == 'hauptlemma' or formType[0] == 'nebenlemma':  # Here we observe that all the entries have at least one form which is hauptlemma
                    # The rest of the forms are not new forms but variants of the hauptlemma so it seems that there is no need
                    # For creating a new form
                    print("\tForm here", formType, formN)
                    cur_formId = teiDb.saveForm(EntryId, formType, formN)
                    print(cur_formId)

                # Extract the othr of the form (this is mapped as lemma

                for orth in form.xpath('./xmlns:orth', namespaces=nsmap):
                    orthType = orth.xpath('./@type')
                    orthOrth = orth.xpath('./text()')
                    orthCollection.append((orthType, orthOrth))
                    # print("\t\tOrth", orthType, " ", orthOrth)
                    # teiDb.saveOrth(cur_formId, orthType, orthOrth)
                # Extract the GramGrp of the form (this is mapped as lemma

                for gramgrp in form.xpath('./xmlns:gramGrp', namespaces=nsmap):
                    gram = gramgrp.xpath('./xmlns:gram/text()', namespaces=nsmap)
                    # print("\t\tGramGrp", gram)
                    gramGrpCollection.append(gram)
                    # teiDb.saveFormGrammarGroup(cur_formId, gram)

                for pron in form.xpath('./xmlns:pron', namespaces=nsmap):
                    pronNotation = pron.xpath('./@notation', namespaces=nsmap)
                    pronResp = pron.xpath('./@resp', namespaces=nsmap)
                    pronChange = pron.xpath('./@change', namespaces=nsmap)
                    pronunciation = pron.xpath('./text()')
                    pronCollection.append((pronNotation, pronResp, pronChange, pronunciation))
                    # print("\t\tPron", pronNotation, " ", pronResp, " ", pronChange, " ", pronunciation)
                    # teiDb.savePronunciation(cur_formId, pronNotation, pronResp, pronChange, pronunciation)
            for orthcol in orthCollection:
                print("\n\n\n\n", orthcol)
                teiDb.saveOrth(cur_formId, orthcol[0], orthcol[1])
            for gramGrpCol in gramGrpCollection:
                teiDb.saveFormGrammarGroup(cur_formId, gramGrpCol)
            for pronCol in pronCollection:
                teiDb.savePronunciation(cur_formId, pronCol[0], pronCol[1], pronCol[2], pronCol[3])

            for sense in entry.xpath('./xmlns:sense', namespaces=nsmap):
                senseCorresp = sense.xpath('./@corresp')
                # print("\tSense", senseId, " " , senseCorresp)
                cur_senseId = teiDb.saveSense(EntryId, senseCorresp)
                for defin in sense.xpath('./xmlns:def', namespaces=nsmap):
                    defLang = defin.xpath('./@xml:lang', namespaces=nsmap)
                    defCorresp = defin.xpath('./@corresp', namespaces=nsmap)
                    defin = defin.xpath('./text()', namespaces=nsmap)
                    # print("\tDef", defLang, " ", defin)
                    teiDb.saveSenseDefinition(cur_senseId, defLang, defCorresp, defin)
            for etym in entry.xpath('./xmlns:etym', namespaces=nsmap):
                etymResp = etym.xpath('./@resp')
                etymCorresp = etym.xpath('./@corresp')
                etymText = etym.xpath('./text()', namespaces=nsmap)
                print("\tEtym ", etymResp, " ", etymCorresp, " ", etymText)
                teiDb.saveEtym(EntryId, etymResp, etymCorresp, etymText)

            for grammarGroup in entry.xpath('./xmlns:gramGrp', namespaces=nsmap):
                gramPosText = ''
                gramGramText = ''
                for gramPos in grammarGroup.xpath('./xmlns:pos', namespaces=nsmap):
                    gramPosText = gramPos.xpath('./text()', namespaces=nsmap)
                    teiDb.saveGrammarGroup(EntryId, gramPosText)
                    # print("Gram group======",gramPosText, "\n", gramGramText)
                    # print("EntryId", EntryId)
            for usg in entry.xpath('./xmlns:usg', namespaces=nsmap):
                usgType = usg.xpath('./@type')
                usgPlaceName = usg.xpath('./xmlns:placeName/text()', namespaces=nsmap)
                usgCorresp = usg.xpath('./xmlns:placeName/@corresp', namespaces=nsmap)
                usgPlaceType = usg.xpath('./xmlns:placeName/@type', namespaces=nsmap)
                print("\tUsg", EntryId, usgType, usgPlaceName, usgPlaceType, )
                cur_usage_id = teiDb.saveEntryUsage(EntryId, usgType, usgCorresp, usgPlaceName, usgPlaceType)

                listPlace = usg.xpath('./xmlns:listPlace', namespaces=nsmap)
                print(listPlace)
                self.places = []

                for listP in listPlace:
                    usgPlaceRef = listP.xpath('./@ref', namespaces=nsmap)
                    if len(usgPlaceRef) > 0:
                        tempRef = usgPlaceRef[0]
                    self.getListPlace(listP, tempRef, cur_usage_id, nsmap)
                # print(self.places)
                # print(list(set(self.places)));
                teiDb.savePlace(list(set(self.places)))
            for ref in entry.xpath('./xmlns:ref', namespaces=nsmap):
                refType = ref.xpath('./@type', namespaces=nsmap)
                # reads the first text of the ref tag, otherwise it will show many empty texts under the tag
                reference = ref.xpath('./text()[1]', namespaces=nsmap)
                refDate = ""

                if refType[0] == "fragebogenNummer":
                    print("\n\n\n\nQuestion", reference)
                    questNo = reference[0].split(":")[0]

                    combined_no = self.split_question_number(questNo)
                    if len(combined_no) > 0:
                        fbno = combined_no[0]
                        fno = combined_no[1]

                        teiDb.saveQuestionEntry(EntryId, fbno, fno, reference[0])

                    print("\n\n\n\nQuestion number", questNo, reference)

                for refDate in ref.xpath('./xmlns:date', namespaces=nsmap):
                    refDate = refDate.xpath('./text()', namespaces=nsmap)
                    # print("--------\t\tdate", refDate)
                # print("--------\tRef", refId, " ", refType, " ", reference)
                cur_referenceId = teiDb.saveReference(EntryId, refType, reference, refDate)
# ----------------------
                for bibl in ref.xpath('./xmlns:bibl', namespaces=nsmap):
                    refBiblType = bibl.xpath('./@type', namespaces=nsmap)
                    refBibl = bibl.xpath('./text()', namespaces=nsmap)
                    # print("---------\t\tbibl", refBiblType, " ", refBibl)
                    teiDb.saveBibliography(EntryId, cur_referenceId, refBiblType, refBibl)


            for note in entry.xpath('./xmlns:note', namespaces=nsmap):
                noteId = entryId[0] + 'note'
                noteType = note.xpath('./@type')
                noteResp = note.xpath('./@resp')
                noteCorresp = note.xpath('./@corresp')
                noteText = note.xpath('./text()', namespaces=nsmap)
                # print("\tNote", noteId, " ", noteType, " ", noteResp, " ", noteCorresp, " ", noteText)
                teiDb.saveNote(EntryId, noteType, noteResp, noteCorresp, noteText)
            for cit in entry.xpath('./xmlns:cit', namespaces=nsmap):
                citType = cit.xpath('./@type')
                citNo = cit.xpath('./@n')
                # print("\tCit", citId, " ", citType, " ", citNo)
                cur_citationId = teiDb.saveCitation(EntryId, citType, citNo)
                for quote in cit.xpath('./xmlns:quote', namespaces=nsmap):
                    quoteResp = quote.xpath('./@resp', namespaces=nsmap)
                    quoteChange = quote.xpath('./@change', namespaces=nsmap)
                    quoteText = quote.xpath('./text()', namespaces=nsmap)
                    # print("\t\tQuote", quoteResp, " ", quoteChange, " ", quoteText)
                    teiDb.saveQuotation(EntryId, cur_citationId, quoteResp, quoteChange, quoteText, )
                for defin in cit.xpath('./xmlns:def', namespaces=nsmap):
                    defLang = defin.xpath('./@xml:lang', namespaces=nsmap)
                    defCorresp = defin.xpath('./@corresp', namespaces=nsmap)
                    defin = defin.xpath('./text()', namespaces=nsmap)
                    # print("\tDef", defLang, " ", defin)
                    teiDb.saveCitationDefinition(cur_citationId, defLang, defCorresp, defin)

        t1 = time.time()
        print(t1, t0, (t1 - t0))


t0 = time.time()
config = configparser.ConfigParser()
config.read('config.ini')
dir = config.get('app', 'input_folder')
directory = os.fsencode(dir)

xmlParse = XMLParser()
teiFiles = xmlParse.readDirectory(dir)
teiFiles.sort()
print("\n\n=============")
for files in teiFiles:
    print(files)

for filename in teiFiles:
    print(colored(("Saving File ", filename), 'blue'))
    xmlParse.parseAndSaveXML(filename)
# parseAndSaveXML('SampleXml.xml')
