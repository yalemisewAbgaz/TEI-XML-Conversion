import mysql.connector
import mysql.connector.errorcode
from termcolor import colored
import configparser



class database:
    config = configparser.ConfigParser()
    config.read('config.ini')
    dbName= config.get('mysql', 'mysql_db_name')
    dbHost= config.get('mysql', 'mysql_db_host')
    dbUser = config.get('mysql', 'mysql_db_user')
    dbPassword = config.get('mysql', 'mysql_db_password')
    dbAuthPlugin = config.get('mysql', 'mysql_auth_plugin')


    cnx = mysql.connector.connect(user=dbUser, password=dbPassword
                                  , host= dbHost,
                                  database=dbName,
                                  auth_plugin=dbAuthPlugin,
                                  # use_pure=True # this is used to include  prepared= True statement to enhance prepared statement usage
                                  )
    cursor = cnx.cursor()

    # cursor = cnx.cursor(prepared=True)

    def saveEntry(self, entryId, entryLang):
        try:
            # print("Saving Entry", entryId, entryLang)
            value = (entryId[0], entryLang[0])
            query = (
                'insert ignore  entry (Id, Lang) values (%s, %s);')
            # print(query)
            self.cursor.execute(query,value)
            self.cnx.commit()
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return 0

    def getEntryId(self, id):
        EntryId=""
        try:
            # print("Searching Entry", id)
            value =(id)
            query = (
                "select EntryId from Entry where id =%s;")
            # print(query)
            self.cursor.execute(query, value)
            for rec in self.cursor:
                EntryId=rec[0]

        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return EntryId
    def getFormId(self, id):
        EntryId=""
        try:
            # print("Searching Entry", id)
            value =(id)
            query = (
                "select EntryId from Entry where id=%s;")
            # print(query)
            self.cursor.execute(query, value)
            for rec in self.cursor:
                EntryId=rec[0]

        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return EntryId



    def saveGrammarGroup(self, entryId, pos):
        tempGram=""
        tempPos=""
        print(entryId)

        if len(pos)>0:
            tempPos=pos[0]

        try:
            # print("Saving GramGroup", entryId, pos)
            value = (tempPos, str(entryId))
            query = (
                'insert ignore  Grammargroup ( pos, entry_entryid) values (%s,  %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return 0
    def saveFormGrammarGroup(self, formId, gram):
        tempGram=""
        tempPos=""
        # print(formId)
        if len(gram)>0:
            tempGram = gram[0]

        try:
            # print("Saving FormGramGroup", formId, gram)
            value =(tempGram,formId)
            query = (
                'insert ignore FormGrammarGroup (gram, Form_formId) values (%s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return 0

    def saveForm(self, entryId, type, n):
        tempType = ""
        tempN = ""
        # print(entryId)
        if len(type) > 0:
            tempType = type[0]
        if len(n) > 0:
            tempN = n[0]
        cur_id=None
        try:
            # print("Saving Form", entryId, type, n)
            value = (tempType,tempN,str(entryId))
            query = (
                "insert ignore  Form (type,n,entry_entryid) values (%s, %s, %s);")
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id=self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id

    def saveOrth(self, formId, type, orth):
        tempType = ""
        tempOrth = ""
        # print(formId)
        if len(type) > 0:
            tempType = type[0]
        if len(orth) > 0:
            tempOrth = orth[0]
        cur_id=None
        try:
            # print("Saving Orth", formId, type, orth)
            value =(tempType,tempOrth,str(formId))
            query = (
                'insert ignore  orth (type,orth,Form_formid) values (%s,  %s,  %s);')

            # print("orth",query,value)

            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id

    def saveSense(self, entryId,corresp):
        tempCorresp = ""
        # print(entryId)
        if len(corresp) > 0:
            tempCorresp = corresp[0]

        cur_id = None
        try:
            # print("Saving Sense", entryId, corresp)
            value = (tempCorresp, entryId)
            query = (
                'insert ignore  Sense (corresp, entry_entryid) values (%s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id
    def saveSenseDefinition(self, senseId, lang, corresp, definition):
        tempLang = ""
        tempCorresp = ""
        tempDefinition=""
        # print(senseId)
        if len(corresp) > 0:
            tempCorresp = corresp[0]
        if len(lang) > 0:
            tempLang = lang[0]
        if len(definition) > 0:
            tempDefinition = definition[0]

        cur_id = None
        try:
            # print("Saving Definition", senseId, corresp)
            value = (tempLang,tempCorresp,tempDefinition,str(senseId))
            query = (
               'insert ignore  SenseDefinition (senseDeflang, senseDefcorresp, senseDefinition, sense_senseid) values (%s, %s, %s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id
    def saveCitationDefinition(self, citeId, lang, corresp, definition):
        tempLang = ""
        tempCorresp = ""
        tempDefinition=""
        # print(quoteId)
        if len(corresp) > 0:
            tempCorresp = corresp[0]
        if len(lang) > 0:
            tempLang = lang[0]
        if len(definition) > 0:
            tempDefinition = definition[0]

        cur_id = None
        try:
            # print("Saving Definition", quoteId, corresp)
            value =(tempLang, tempCorresp, tempDefinition, str(citeId))
            query = (
               'insert ignore  CitationDefinition (citationDefLang, citationDefCorresp, citationDefinition, Citation_citationId) values (%s, %s, %s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id
    def savePronunciation(self, formId, notation, resp, change, pron ):
        tempNotation = ""
        tempResp = ""
        tempChange=""
        tempPron = ""
        # print(formId)
        if len(notation) > 0:
            tempNotation = notation[0]
        if len(resp) > 0:
            tempResp = resp[0]
        if len(change) > 0:
            tempChange = change[0]
        if len(pron) > 0:
            tempPron = pron[0]
        cur_id = None
        try:
            # print("Saving Pronunciation", formId, notation)
            value =(tempNotation,tempResp,tempChange,tempPron,formId)
            query = (
               'insert ignore  Pronunciation (notation, resp, changes, pron,Form_formId) values (%s, %s, %s, %s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id
    def saveNote(self, entryId, noteType, noteResp, noteCorresp, noteText):
        tempNoteType = ""
        tempNoteResp = ""
        tempNoteCorresp = ""
        tempNoteText= ""
        # print(entryId)
        if len(noteType) > 0:
            tempNoteType = noteType[0]
        if len(noteResp) > 0:
            tempNoteResp = noteResp[0]
        if len(noteCorresp) > 0:
            tempNoteCorresp = noteCorresp[0]
        if len(noteText) > 0:
            tempNoteText = noteText[0]
        cur_id = None
        try:
            # print("Saving Note", entryId,noteType, noteResp,noteCorresp,noteText)
            value =(tempNoteType, tempNoteResp, tempNoteCorresp, tempNoteText, str(entryId))
            query = (
                'insert ignore  Note (type, resp, corresp,note,entry_entryid) values (%s, %s, %s, %s, %s);')
                
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id
    def saveCitation(self, entryId, citType, citNo):
        tempCitType = ""
        tempCitNo = ""

        # print(entryId)
        if len(citType) > 0:
            tempCitType = citType[0]
        if len(citNo) > 0:
            tempCitNo = citNo[0]

        cur_id = None
        try:
            # print("Saving Citation", entryId, citType, citNo)
            value = (tempCitType,tempCitNo, str(entryId))
            query = (
                'insert ignore  citation (type, n,entry_entryid) values (%s, %s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))

        return cur_id
    def saveQuotation(self, entryId, citationId,resp, change, quote ):
        tempQuote = ""
        tempResp = ""
        tempChange=""

        # print(citationId)
        if len(quote) > 0:
            tempQuote = quote[0]
        if len(resp) > 0:
            tempResp = resp[0]
        if len(change) > 0:
            tempChange = change[0]

        cur_id = None
        try:
            # print("Saving citation Quotation", citationId, resp)
            value = (tempResp, tempChange,tempQuote, str(citationId), str(entryId))
            query = (
               'insert ignore  Quote (resp, changes, quote, citation_citationId, Citation_Entry_entryId) values (%s,  %s,  %s,  %s,  %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))
        return cur_id
    def saveEntryUsage(self, entryId, type):
        tempType = ""
        print(entryId)
        if len(type) > 0:
            tempType = type[0]
        cur_id = None
        try:
            # print("Saving usg",entryId, type)
            value = (tempType,str(entryId))
            query = (
                'insert ignore  EntryUsage (usagetype,Entry_entryId) values (%s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))
        return cur_id

    def saveReference(self, entryId, type, ref, refDate):
        tempType = ""
        tempRef=""
        tempRefDate=""
        # print(entryId)
        if len(type) > 0:
            tempType = type[0]
        if len(ref) > 0:
            tempRef = ref[0]
        if len(refDate) > 0:
            tempRefDate = refDate[0]
        cur_id = None
        try:
            # print("Saving usg",entryId, type)
            value = (tempType, tempRef, tempRefDate,str(entryId))
            query = (
                'insert ignore  reference (type,ref, refDate, Entry_entryId) values (%s, %s, %s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))
        return cur_id

    def saveBibliography(self, entryId, referenceId, refBiblType, refBibl):
        tempRefBiblType = ""
        tempRefBibl = ""

        # print(entryId)
        if len(refBiblType) > 0:
            tempRefBiblType = refBiblType[0]
        if len(refBibl) > 0:
            tempRefBibl = refBibl[0]
        cur_id = None
        try:
            # print("Saving Bibliography", entryId, type)
            value = (tempRefBiblType,tempRefBibl,str(referenceId), str(entryId))
            query = (
                'insert ignore  bibliography (type, bibl, reference_referenceId, Reference_Entry_entryId)  values (%s, %s, %s, %s);')
            # print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
           print(colored(err,'red'))
        return cur_id