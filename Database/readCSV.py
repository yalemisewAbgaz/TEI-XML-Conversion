import csv

class readCSV:
    def __init__(self):
        print("This is the constructor method.")


    def read(self, fileName):
        keywordData = []
        with open(fileName, 'r')as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',', quotechar='|')
            for records in csvreader:
                keywordItem = {}
                print(records)
                if records[15] != "":
                    # print(records[0],records[1],records[15])
                    keywordItem['tag_id'] = records[0]
                    keywordItem['picture_id'] = records[1]
                    keywordItem['topo_tag'] = records[15]
                    keywordData.append(keywordItem)
        return keywordData