import mysql.connector
import mysql.connector.errorcode
from termcolor import colored
import configparser


class database:
    config = configparser.ConfigParser()
    config.read('config.ini')
    dbName = config.get('mysql', 'mysql_db_name')
    dbHost = config.get('mysql', 'mysql_db_host')
    dbPort = config.get('mysql', 'mysql_db_port')
    dbUser = config.get('mysql', 'mysql_db_user')
    dbPassword = config.get('mysql', 'mysql_db_password')
    dbAuthPlugin = config.get('mysql', 'mysql_auth_plugin')

    cnx = mysql.connector.connect(user=dbUser, password=dbPassword
                                  , host=dbHost,
                                  port=dbPort,
                                  database=dbName,
                                  auth_plugin=dbAuthPlugin,

                                  # use_pure=True # this is used to include  prepared= True statement to enhance prepared statement usage
                                  )
    cursor = cnx.cursor()

    # cursor = cnx.cursor(prepared=True)

    def saveEntry(self, entry_id, entryLang):
        try:
            print("Saving Entry========\n\n\n\n", entry_id, entryLang)
            value = (entry_id[0], entryLang[0])
            query = (
                'insert into  entry (Id, Lang) values (%s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return 0

    def savePlace(self,  data):

        if len(data) > 0:
            try:
                print("Saving places", data)
                # value = (tempPos, str(entry_id))
                query = (
                    'insert into  place ( list_place_ref, place_type, place_name, place_id_no, usage_id) values (%s, %s, %s, %s,  %s);')

                self.cursor.executemany(query,data)
                self.cnx.commit()
                print(self.cursor.statement)
            except mysql.connector.Error as err:
                print(colored(err, 'red'))

            return 0


    def saveGrammarGroup(self, entry_id, pos):
        tempGram = ""
        tempPos = ""
        print(entry_id)

        if len(pos) > 0:
            tempPos = pos[0]

        try:
            print("Saving GramGroup", entry_id, pos)
            value = (tempPos, str(entry_id))
            query = (
                'insert into  grammar_group ( pos, entry_id) values (%s,  %s);')
            print(query)
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return 0

    def saveFormGrammarGroup(self, form_id, gram):
        tempGram = ""
        tempPos = ""
        print(form_id)
        if len(gram) > 0:
            tempGram = gram[0]

        try:
            print("Saving FormGramGroup", form_id, gram)
            value = (tempGram, form_id)
            query = (
                'insert into form_grammar_group (gram, form_id) values (%s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return 0

    def saveForm(self, entry_id, type, n):
        tempType = ""
        tempN = -1
        print(entry_id)
        if len(type) > 0:
            tempType = type[0]
        if len(n) > 0:
            tempN = n[0]
        cur_id = None
        try:
            print("Saving Form", entry_id, type, n)
            value = (tempType, int(tempN), entry_id)
            query = (
                "insert into  form (type,n,entry_id) values (%s, %s, %s);")
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))
        print("=====current form id ", cur_id)
        return cur_id

    def saveOrth(self, form_id, type, orth):
        tempType = ""
        tempOrth = ""
        print(form_id)
        if len(type) > 0:
            tempType = type[0]
        if len(orth) > 0:
            tempOrth = orth[0]
        cur_id = None
        try:
            print("Saving Orth", form_id, type, orth)
            value = (tempType, tempOrth, str(form_id))
            query = (
                'insert into  orth (type, orth, form_id) values (%s,  %s,  %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id

    def saveSense(self, entry_id, corresp):
        tempCorresp = ""
        print(entry_id)
        if len(corresp) > 0:
            tempCorresp = corresp[0]

        cur_id = None
        try:
            print("Saving Sense", entry_id, corresp)
            value = (tempCorresp, entry_id)
            print(value)
            query = (
                'insert into  sense (corresp, entry_id) values (%s, %s);')

            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id

    def saveSenseDefinition(self, sense_id, lang, corresp, definition):
        tempLang = ""
        tempCorresp = ""
        tempDefinition = ""
        print(sense_id)
        if len(corresp) > 0:
            tempCorresp = corresp[0]
        if len(lang) > 0:
            tempLang = lang[0]
        if len(definition) > 0:
            tempDefinition = definition[0]

        cur_id = None
        try:
            print("Saving Definition", sense_id, corresp)
            value = (tempLang, tempCorresp, tempDefinition, str(sense_id))
            query = (
                'insert into  sense_definition (sense_Def_lang, sense_Def_corresp, sense_Definition, sense_id) values (%s, %s, %s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id

    def saveCitationDefinition(self, citeId, lang, corresp, definition):
        tempLang = ""
        tempCorresp = ""
        tempDefinition = ""
        if len(corresp) > 0:
            tempCorresp = corresp[0]
        if len(lang) > 0:
            tempLang = lang[0]
        if len(definition) > 0:
            tempDefinition = definition[0]

        cur_id = None
        try:
            print("Saving Definition", citeId, corresp)
            value = (tempLang, tempCorresp, tempDefinition, str(citeId))
            query = (
                'insert into  citation_definition (citation_Def_Lang, citation_Def_Corresp, citation_Definition,'
                ' citation_id) values (%s, %s, %s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id

    def savePronunciation(self, form_id, notation, resp, change, pron):
        tempNotation = ""
        tempResp = ""
        tempChange = ""
        tempPron = ""
        print(form_id)
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
            print("Saving Pronunciation", form_id, notation)
            value = (tempNotation, tempResp, tempChange, tempPron, form_id)
            query = (
                'insert into  pronunciation (notation, resp, changes, pron,form_id) values (%s, %s, %s, %s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id

    def saveNote(self, entry_id, noteType, noteResp, noteCorresp, noteText):
        tempNoteType = ""
        tempNoteResp = ""
        tempNoteCorresp = ""
        tempNoteText = ""
        print(entry_id)
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
            print("Saving Note", entry_id,noteType, noteResp,noteCorresp,noteText)
            value = (tempNoteType, tempNoteResp, tempNoteCorresp, tempNoteText, str(entry_id))
            query = (
                'insert into  note (type, resp, corresp,note,entry_id) values (%s, %s, %s, %s, %s);')

            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id


    def saveEtym(self, entry_id, etymResp, etymCorresp, etymText):
        tempetymResp = ""
        tempEtymCorresp = ""
        tempEtymText = ""

        if len(etymResp) > 0:
            tempEtymResp = etymResp[0]
        if len(etymCorresp) > 0:
            tempEtymCorresp = etymCorresp[0]
        if len(etymText) > 0:
            tempEtymText = etymText[0]
        cur_id = None
        try:
            print("Saving Etym", entry_id, etymResp,etymCorresp,etymText)
            value = ( tempEtymResp, tempEtymCorresp, tempEtymText, str(entry_id))
            query = (
                'insert into  etymology ( resp, corresp,text,entry_id) values (%s, %s, %s, %s);')

            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id


    def saveCitation(self, entry_id, citType, citNo):
        tempCitType = ""
        tempCitNo = ""

        print(entry_id)
        if len(citType) > 0:
            tempCitType = citType[0]
        if len(citNo) > 0:
            tempCitNo = citNo[0]

        cur_id = None
        try:
            print("Saving Citation", entry_id, citType, citNo)
            value = (tempCitType, tempCitNo, str(entry_id))
            query = (
                'insert into  citation (type, n, entry_id) values (%s, %s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return cur_id

    def saveQuotation(self, entry_id, citation_id, resp, change, quote):
        tempQuote = ""
        tempResp = ""
        tempChange = ""

        print(citation_id)
        if len(quote) > 0:
            tempQuote = quote[0]
        if len(resp) > 0:
            tempResp = resp[0]
        if len(change) > 0:
            tempChange = change[0]

        cur_id = None
        try:
            print("Saving citation Quotation", citation_id, resp)
            value = (tempResp, tempChange, tempQuote, str(citation_id))
            query = (
                'insert into  citation_quote (resp, changes, quote, citation_id) values (%s,  %s,  %s,  %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))
        return cur_id

    def saveEntryUsage(self, entry_id, type,corresp, usgPlaceName, usgPlaceType):
        tempType = ""
        tempCorresp=""
        tempUsgPlaceName=""
        tempUsgPlaceType= ""
        print(entry_id)
        if len(type) > 0:
            tempType = type[0]
        if len(corresp) > 0:
            tempCorresp = corresp[0]
        if len(usgPlaceName) > 0:
            tempUsgPlaceName = usgPlaceName[0]
        if len(usgPlaceType) > 0:
            tempUsgPlaceType = usgPlaceType[0]


        cur_id = None
        try:
            print("Saving usg",entry_id, type)
            value = (tempType, tempCorresp, tempUsgPlaceName, tempUsgPlaceType, str(entry_id))
            query = (
                'insert into  entry_usage (usage_type, usage_corresp, usage_place_name, usage_place_type, entry_id) values (%s, %s, %s, %s, %s);')

            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))
        return cur_id

    def saveReference(self, entry_id, type, ref, refDate):
        tempType = ""
        tempRef = ""
        tempRefDate = ""
        print(entry_id)
        if len(type) > 0:
            tempType = type[0]
        if len(ref) > 0:
            tempRef = ref[0]
        if len(refDate) > 0:
            tempRefDate = refDate[0]
        cur_id = None
        try:
            print("Saving reference",entry_id, type)
            value = (tempType, tempRef, tempRefDate, str(entry_id))
            query = (
                'insert into  reference (type, ref, ref_Date, entry_id) values (%s, %s, %s, %s);')

            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))
        return cur_id

    def saveBibliography(self, entry_id, reference_id, refBiblType, refBibl):
        tempRefBiblType = ""
        tempRefBibl = ""

        print(entry_id)
        if len(refBiblType) > 0:
            tempRefBiblType = refBiblType[0]
        if len(refBibl) > 0:
            tempRefBibl = refBibl[0]
        cur_id = None
        try:
            print("Saving Bibliography============", entry_id, type)
            value = (tempRefBiblType, tempRefBibl, str(reference_id), str(entry_id))
            query = (
                'insert into  bibliography (type, bibl, ref_date, reference_id)  values (%s, %s, %s, %s);')

            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
            cur_id = self.cursor.lastrowid
        except mysql.connector.Error as err:
            print(colored(err, 'red'))
        return cur_id


    def saveQuestionEntry(self, entry_id, questionnaire_no, quest_no, quest):
        try:
            print("Saving Entry Quest========\n\n\n\n", entry_id, questionnaire_no, quest_no, quest)
            value = (entry_id, questionnaire_no, quest_no, quest)
            query = (
                'insert into  question_entry (entry_id, questionnaire_no, question_no, question) values (%s, %s, %s, %s);')
            self.cursor.execute(query, value)
            self.cnx.commit()
            print(self.cursor.statement)
        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return 0


    def getEntryId(self, id):
        entry_id = ""
        try:
            print("Searching Entry", id)
            value = (id)
            query = (
                "select entry_id from entry where id =%s;")

            self.cursor.execute(query, value)
            for rec in self.cursor:
                entry_id = rec[0]

        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return entry_id

    def getform_id(self, id):
        entry_id = ""
        try:
            print("Searching Entry", id)
            value = (id)
            query = (
                "select entry_id from entry where id=%s;")

            self.cursor.execute(query, value)
            for rec in self.cursor:
                entry_id = rec[0]

        except mysql.connector.Error as err:
            print(colored(err, 'red'))

        return entry_id
