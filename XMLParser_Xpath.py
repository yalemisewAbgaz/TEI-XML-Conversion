from lxml import etree
from TEIXMLDB.handleDB import *
import time
import os
from termcolor import colored
import configparser



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
                listPlace=placeList.xpath('./xmlns:listPlace', namespace=nsmap)
                self.getPlaces(listPlace,nsmap)
class XMLParser:
    teiDb = database()

    def readDirectory(self,rootdir):
        teiFiles=[]
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

    def parseAndSaveXML(self, file):
        t0 = time.time()

        teiDb= self.teiDb
        # tree = etree.parse('d157_qdb-TEI-02.xml')
        tree = None
        try:
            tree = etree.parse(file)
        except:
            print("Error")
            return

        root=tree.getroot()
        nsmap = tree.getroot().nsmap.copy()
        # then puts the default xmlns in ti a xmlns
        nsmap['xmlns'] = nsmap.pop(None)

        mynsmap={"tei": "http://www.tei-c.org/ns/1.0"}



        for entry in tree.xpath('/xmlns:TEI/xmlns:text/xmlns:body/xmlns:entry', namespaces=nsmap):
            # Get the id and the language of the Entry and represent it as an entity
            entryId= entry.xpath('./@xml:id')
            entrylang=entry.xpath('./@xml:lang')
            print("Entry ", entryId, " ", entrylang)
            teiDb.saveEntry(entryId, entrylang)
            EntryId = teiDb.getEntryId(entryId)
            cur_formId=None
            cur_senseId=None
            for form in entry.xpath('./xmlns:form', namespaces=nsmap):
                formId=entryId[0]+'Form'
                formType=form.xpath('./@type')
                formN=form.xpath('./@n')
                # print("\tForm",formId, formType, formN)
                cur_formId=teiDb.saveForm(EntryId, formType,formN)

                # Extract the othr of the form (this is mapped as lemma
                for orth in form.xpath('./xmlns:orth', namespaces=nsmap):
                    orthType=orth.xpath('./@type')
                    orthOrth=orth.xpath('./text()')
                    # print("\t\tOrth", orthType, " ", orthOrth)
                    teiDb.saveOrth(cur_formId, orthType, orthOrth)
                # Extract the GramGrp of the form (this is mapped as lemma
                for gramgrp in form.xpath('./xmlns:gramGrp', namespaces=nsmap):
                    gram = gramgrp.xpath('./xmlns:gram/text()',namespaces=nsmap)
                    # print("\t\tGramGrp", gram)
                    teiDb.saveFormGrammarGroup(cur_formId,gram)
                for pron in form.xpath('./xmlns:pron', namespaces=nsmap):
                    pronNotation = pron.xpath('./@notation', namespaces=nsmap)
                    pronResp=pron.xpath('./@resp', namespaces=nsmap)
                    pronChange = pron.xpath('./@change', namespaces=nsmap)
                    pronunciation= pron.xpath('./text()')
                    # print("\t\tPron", pronNotation, " ", pronResp, " ", pronChange, " ", pronunciation)
                    teiDb.savePronunciation(cur_formId,pronNotation,pronResp,pronChange,pronunciation)

            for sense in entry.xpath('./xmlns:sense', namespaces=nsmap):
                senseId = entryId[0] + 'sense'
                senseCorresp = sense.xpath('./@corresp')
                # print("\tSense", senseId, " " , senseCorresp)
                cur_senseId = teiDb.saveSense(EntryId, senseCorresp)
                for defin in sense.xpath('./xmlns:def', namespaces=nsmap):
                    defLang = defin.xpath('./@xml:lang', namespaces=nsmap)
                    defCorresp = defin.xpath('./@corresp', namespaces=nsmap)
                    defin=defin.xpath('./text()', namespaces=nsmap)
                    # print("\tDef", defLang, " ", defin)
                    teiDb.saveSenseDefinition(cur_senseId, defLang, defCorresp,defin)
            for ref in entry.xpath('./xmlns:ref', namespaces=nsmap):
                refId = entryId[0] + 'Ref'
                refType=ref.xpath('./@type', namespaces=nsmap)
                # reads the first text of the ref tag, otherwise it will show many empty texts under the tag
                reference = ref.xpath('./text()[1]', namespaces=nsmap)
                refDate=""
                for refDate in ref.xpath('./xmlns:date', namespaces=nsmap):
                    refDate = refDate.xpath('./text()', namespaces=nsmap)
                    # print("--------\t\tdate", refDate)
                # print("--------\tRef", refId, " ", refType, " ", reference)
                cur_referenceId=teiDb.saveReference(EntryId, refType, reference, refDate)

                for bibl in ref.xpath('./xmlns:bibl', namespaces=nsmap):
                    refBiblType = bibl.xpath('./@type', namespaces=nsmap)
                    refBibl = bibl.xpath('./text()', namespaces=nsmap)
                    # print("---------\t\tbibl", refBiblType, " ", refBibl)
                    teiDb.saveBibliography(EntryId, cur_referenceId, refBiblType, refBibl)
            for note in entry.xpath('./xmlns:note', namespaces=nsmap):
                noteId = entryId[0] + 'note'
                noteType= note.xpath('./@type')
                noteResp=note.xpath('./@resp')
                noteCorresp=note.xpath('./@corresp')
                noteText=note.xpath('./text()', namespaces=nsmap)
                # print("\tNote", noteId, " ", noteType, " ", noteResp, " ", noteCorresp, " ", noteText)
                teiDb.saveNote(EntryId,noteType,noteResp,noteCorresp,noteText)
            for cit in entry.xpath('./xmlns:cit', namespaces=nsmap):
                citId = entryId[0] + 'cit'
                citType=cit.xpath('./@type')
                citNo=cit.xpath('./@n')
                # print("\tCit", citId, " ", citType, " ", citNo)
                cur_citationId=teiDb.saveCitation(EntryId, citType, citNo)
                for quote in cit.xpath('./xmlns:quote', namespaces=nsmap):
                    quoteResp = quote.xpath('./@resp', namespaces=nsmap)
                    quoteChange = quote.xpath('./@change', namespaces=nsmap)
                    quoteText = quote.xpath('./text()', namespaces=nsmap)
                    # print("\t\tQuote", quoteResp, " ", quoteChange, " ", quoteText)
                    teiDb.saveQuotation( EntryId, cur_citationId, quoteResp,quoteChange,quoteText, )
                for defin in cit.xpath('./xmlns:def', namespaces=nsmap):
                    defLang = defin.xpath('./@xml:lang', namespaces=nsmap)
                    defCorresp = defin.xpath('./@corresp', namespaces=nsmap)
                    defin=defin.xpath('./text()', namespaces=nsmap)
                    # print("\tDef", defLang, " ", defin)
                    teiDb.saveCitationDefinition(cur_citationId, defLang, defCorresp,defin)


            for grammarGroup in entry.xpath('./xmlns:gramGrp', namespaces=nsmap):
                gramId = entryId[0] + 'Gram'
                gramPosText=''
                gramGramText=''
                for gramPos in grammarGroup.xpath('./xmlns:pos', namespaces=nsmap):
                    gramPosText= gramPos.xpath('./text()', namespaces=nsmap)
                    teiDb.saveGrammarGroup(EntryId, gramPosText)
                # print("Gram group======",gramPosText, "\n", gramGramText)
                # print("EntryId", EntryId)


            for usg in entry.xpath('./xmlns:usg', namespaces=nsmap):
                usgId = entryId[0] + 'usg'
                usgType = usg.xpath('./@type')
                # print("\tUsg", usgId, " ", usgType)
                teiDb.saveEntryUsage(EntryId,usgType)
                # This part requires further analysis to extract the names.
                # u=Usage()
                # for usgPlace in usg.xpath('./xmlns:listPlace', namespaces=nsmap):
                #     u.getPlaces(usgPlace,nsmap)
                #
                #     usgPlaceNameType = usgPlace.xpath('./@type', namespaces=nsmap)
                #     usgListPlaceRef = usgPlace.xpath('./@ref', namespaces=nsmap)
                #     usgPlaceName = usgPlace.xpath('./text()', namespaces=nsmap)
                #     print("\t\tUsgPlace", usgPlaceNameType, " ", usgListPlaceRef, " ", usgPlaceName)

                    # for placeList in usgPlace.xpath('./xmlns:place', namespaces=nsmap):
                    #     usgPlaceNameType = placeList.xpath('./@type', namespaces=nsmap)
                    #     usgListPlaceName = placeList.xpath('./xmlns:placeName/text()', namespaces=nsmap)
                    #     usgListPlaceId = placeList.xpath('./xmlns:idno/text()', namespaces=nsmap)
                    #     usgListPlaceRef = placeList.xpath('./@ref', namespaces=nsmap)
                    #     print("---\t\t\tUsgPlace", usgPlaceNameType, " ", usgListPlaceName, usgListPlaceId)



        t1 = time.time()
        print(t1, t0, (t1-t0))

t0 = time.time()
config = configparser.ConfigParser()
config.read('config.ini')
dir = config.get('app', 'input_folder')

directory= os.fsencode(dir)
xmlParse= XMLParser()
print(dir)
teiFiles=xmlParse.readDirectory(dir)
print("here")
for filename in teiFiles:
    print(colored(("Saving File ", filename), 'blue'))
    xmlParse.parseAndSaveXML(filename)
# parseAndSaveXML('SampleXml.xml')