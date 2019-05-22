from nltk.wsd import lesk
from nltk.corpus import wordnet as wn
import mysql.connector
import mysql.connector.errorcode
import MySQLdb


class WordList:

    user = 'root'
    password = 'ExploreAt!dbo2017'
    host = '127.0.0.1'
    db = 'c1Topothek'

    def __init__(self):
        self.connection = MySQLdb.connect(self.host, self.user, self.password, self.db)
        self.cursor = self.connection.cursor()

    def insert(self, query):
        try:
            self.cursor.execute(query)
            self.connection.commit()
        except:
            self.connection.rollback()


    def wordInList(self, word):
        record=[]
        try:
            query = (
                "select token_id from token where token='"+word+"'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec)
        except mysql.connector.Error as err:
            print(err)
        return record
    def getId(self, word):
        record=[]
        try:
            query = (
                "select token_id from token where token='"+word+"'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)
        return record

    def getTaxoId(self, word):
        record = []
        try:
            query = (
                "select token_id from token where token='" + word + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)
        return record

    def getWord(self, id):
        record = []
        try:
            query = (
                "select token,keyword_id from token where token_id='" + id + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)
        return record
    def getSourceId(self, id):
        record = []
        try:
            query = (
                "select source_id from token where token_id='" + id + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)
        return record

    def addWord(self, name, tagId, source, sourceid):
        try:
            # print("adding word",word, source.sourceid)
            query = (
                "insert ignore  token (token, keyword_id,source,source_id) values ('" + name+"','" + str(tagId) +"','"+source + "','" + sourceid + "')")
            # print(query)
            self.cursor.execute(query)
            self.connection.commit()
        except mysql.connector.Error as err:
            print(err)

        return 0
    def inTaxonomy(self, wordId, path):
        record=[]
        print(wordId)
        try:
            query = (
                "select * from Taxonomy where token_id='"+ str(wordId) +"' and path = '"+str(path)+"'")
            # print(query)
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec)
        except mysql.connector.Error as err:
            print(err)
        return record

    def addTaxonomy(self, wordId, path):
        try:
            query = (
                "insert ignore  Taxonomy (token_id, path) values ('"+ wordId +"','"+str(path) +"')")
            print(query)
            self.cursor.execute(query)
            self.connection.commit()
        except mysql.connector.Error as err:
            print(err)

        return 0

    def addTaxonomy(self,candidateTax):
        values=''
        for tax in candidateTax:
            # print(tax[0],tax[1])
            values+="('"+str(tax[0])+"','"+str(tax[1])+"','"+str(tax[2])+"'),"
          # print(values)
        values=values[:-1]
        # print("values",values)
        try:
            query = (
                "insert ignore  Taxonomy (token_id, path,full_path) values"+ values+"")
            print("query" ,query)
            self.cursor.execute(query)
            self.connection.commit()
        except mysql.connector.Error as err:
            print(err)

    def AddFoundKeywords(self, keyword_id, token_id):
            try:
                query = (
                    "insert ignore  keywordsFound (keyword_id,token_id) values ('" + str(keyword_id) + "','" + str(token_id) + "')")
                # print(query)
                self.cursor.execute(query)
                self.connection.commit()
            except mysql.connector.Error as err:
                print(err)

            return 0
    # def getParent(self,childid):
    #     record = []
    #     # print("searching", childid)
    #     try:
    #         query = (
    #             "select parent from taxonomy where child='" + str(childid) + "'")
    #         self.cursor.execute(query)
    #         for rec in self.cursor:
    #             record.append(rec[0])
    #     except mysql.connector.Error as err:
    #         print(err)
    #     return record
    # def getTaxonomy(self,wordId):
    #     record = []
    #     # print("searching", wordId)
    #     try:
    #         query = (
    #             "select parent from taxonomy where wordId='" + str(wordId) + "'")
    #         self.cursor.execute(query)
    #         for rec in self.cursor:
    #             record.append(rec[0])
    #     except mysql.connector.Error as err:
    #         print(err)
    #     return record

    def getTaxonomyIds(self, word):
        record = []
        wordId = self.getId(word)[0]
        # print("searching", wordId)

        try:
            query = (
                "select path from taxonomy where token_id='" + str(wordId) + "'")
            print(query)
            self.cursor.execute(query)
            for rec in self.cursor:
                print(rec[0])
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)
        return record
    def getTaxonomyWordByWord(self,word):
        record = []
        taxonomy=[]
        wordId=self.getId(word)[0]
        # print("searching", word, wordId)
        try:
            query = (
                "select path from taxonomy where token_id='" + str(wordId) + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)

        for thesaurus in record:
            taxo=[]
            for ids in thesaurus.replace("[","").replace("]","").split(","):
                taxo.append((self.getWord(ids)[0],self.getSourceId(ids)[0]))
            taxonomy.append(taxo)

        return taxonomy
    def getTaxonomyWordById(self,wordId):
        record = []
        taxonomy=[]

        # print("searching", word, wordId)
        try:
            query = (
                "select path from taxonomy where token_id='" + str(wordId) + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                record.append(rec[0])
        except mysql.connector.Error as err:
            print(err)

        for thesaurus in record:
            taxo=[]
            for ids in thesaurus.replace("[","").replace("]","").split(","):
                taxo.append((self.getWord(ids)[0],self.getSourceId(ids)[0]))
            taxonomy.append(taxo)

        return taxonomy
    def getTaxonomySubTree(self,word):
        record = []
        taxonomyTrees=self.getTaxonomyIds(word)
        print(taxonomyTrees)
        for taxonomyTree in taxonomyTrees:
            print (taxonomyTree)
            searchedTree=str(taxonomyTree)
            searchedTree=searchedTree.replace('[',", ")
            print(searchedTree)
            try:
                query = (
                    "select token_id from taxonomy where path like \"%"+searchedTree+"\"" )
                self.cursor.execute(query)
                for rec in self.cursor:
                    record.append(self.getTaxonomyWordById(rec[0]))
            except mysql.connector.Error as err:
                print(err)
        return record

    def populateWithWord(self, wordId):
        record = []
        taxonomy = []

        # print("searching", word, wordId)
        try:
            query = (
                "select Taxonomy_id, path from taxonomy where Taxonomy_id='" + str(wordId) + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                taxonomyWordChain=""
                id= rec[0]
                path=str(rec[1]).replace('[','').replace(']','')
                for wordId in path.split(","):
                    taxonomyWordChain+=self.getWord(wordId)[0]+":"
                taxonomyWordChain=taxonomyWordChain[0:-1]
                queryUpdate=("update taxonomy set full_path=\'"+ taxonomyWordChain+"\' where Taxonomy_id ="+ str(id))
                # print(queryUpdate)
                self.cursor.execute(queryUpdate)
                self.connection.commit()
        except mysql.connector.Error as err:
            print(err)

        return taxonomy

    def explodeTaxonomy(self, wordId):
        record = []
        taxonomy = []

        # print("searching", word, wordId)
        try:
            query = (
                "select Taxonomy_id,token_id, full_path from taxonomy where Taxonomy_id='" + str(wordId) + "'")
            self.cursor.execute(query)
            for rec in self.cursor:
                taxonomyWordChain=""
                taxoId= rec[0]
                taxoWordId=rec[1]

                fullPath=rec[2]
                i=0
                for word in fullPath.split(":"):
                    queryUpdate=("insert  ignore into taxonomyExploded values (\'"+str(taxoId)+"\',\'"+str(taxoWordId)+"\',\'"+ word+"\',\'"+ str(i)+"\')")
                    i+=1
                    print(queryUpdate)
                    self.cursor.execute(queryUpdate)
                    self.connection.commit()
        except mysql.connector.Error as err:
            print(err)

        return taxonomy