from nltk.wsd import lesk
from nltk.corpus import wordnet as wn
import mysql.connector
import mysql.connector.errorcode
from urllib.request import urlopen
import urllib
import json
import gzip
import datetime
import collections
import ast

class KeyWords:
    def readAll(self):
        counter = 0
        records = []

        try:
            cnx = mysql.connector.connect(user='root', password='ExploreAt!dbo2017'
                                          , host='127.0.0.1',
                                          database='c1Topothek')
            cursor = cnx.cursor()
            query = (
                "select keyword_id, archive_id, name from Keyword")
            # print(str(topic[0]))
            cursor.execute(query)

            for rec in cursor:
                keywordItem = {}
                # print(records[0],records[1],records[15])
                keywordItem['keyword_id'] = rec[0]
                keywordItem['archive_id'] = rec[1]
                keywordItem['originalfrage'] = rec[2]
                records.append(keywordItem)

            cursor.close()
            cnx.close
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist")
            else:
                print(err)
        else:
            cnx.close()
        return records

    def read(self, limit):
        counter = 0
        records = []

        try:
            cnx = mysql.connector.connect(user='root', password='ExploreAt!dbo2017'
                                          , host='127.0.0.1',
                                          database='c1Topothek')
            cursor = cnx.cursor()
            query = (
                "select keyword_id, archive_id, name from Keyword limit " +str(limit))
            # print(str(topic[0]))
            cursor.execute(query)

            for rec in cursor:
                keywordItem = {}
                # print(records[0],records[1],records[15])
                keywordItem['keyword_id'] = rec[0]
                keywordItem['archive_id'] = rec[1]
                keywordItem[''originalfrage''] = rec[2]
                records.append(keywordItem)

            cursor.close()
            cnx.close
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist")
            else:
                print(err)
        else:
            cnx.close()
        return records

    def readByID(self, id):
        counter = 0
        records = []

        try:
            cnx = mysql.connector.connect(user='root', password='ExploreAt!dbo2017'
                                          , host='127.0.0.1',
                                          database='c1Topothek')
            cursor = cnx.cursor()
            query = (
                "select keyword_id, archive_id, name from Keyword where keyword_id= " +str(id))
            # print(str(topic[0]))
            cursor.execute(query)

            for rec in cursor:
                keywordItem = {}
                # print(records[0],records[1],records[15])
                keywordItem['keyword_id'] = rec[0]
                keywordItem['archive_id'] = rec[1]
                keywordItem[''originalfrage''] = rec[2]
                records.append(keywordItem)

            cursor.close()
            cnx.close
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist")
            else:
                print(err)
        else:
            cnx.close()
        return records