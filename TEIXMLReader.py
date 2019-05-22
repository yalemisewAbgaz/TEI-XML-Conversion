import xml.etree.ElementTree as ET

class TagReader:
    def __init__(self,fileName):
        # registers the namespace to avoid generating the namespace during conversion
        ET.register_namespace('','http://www.tei-c.org/ns/1.0')
        self.element = ET.parse(fileName)
        self.root = self.element.getroot()
        # This is a second option which should not be used with the above one. registers the namespace to avoid generating the namespace during conversion
        # self.root.set("xmlns", 'http://www.tei-c.org/ns/1.0')
        self.ns={'tei':'http://www.tei-c.org/ns/1.0'}
    def getAllTags(self):
        tags=set()
        for ele in self.element.iter():
            tags.add(ele.tag)
        return tags

    def getAllTagsWithAtributes(self):
        tags_attrib={}
        for ele in self.element.iter():
            tags_attrib[ele.tag]=ele.attrib
        return tags_attrib

    def getAllAttributeValues(self):
        attValues=set()
        for ele in self.element.iter():
            att=ele.attrib
            for a in att:
                # print(ele.tag, a, att[a])
                st=ele.tag+"\t"+a+"\t"+att[a]
                # print(st)
                attValues.add(st)

        return attValues
    def showAllItemTags(self):

        print("root", self.root.tag)
        # attaching the namespace helps finding the tag, otherwise the tag will not be found
        for ele in self.root.iter('{http://www.tei-c.org/ns/1.0}item'):
            for e in ele.findall('./{http://www.tei-c.org/ns/1.0}interpGrp/{http://www.tei-c.org/ns/1.0}interp'):
                print(ele.tag, e.tag)
            # print(ele.attrib)

    def AddNewNode(self):

        print("root", self.root.tag)
        # attaching the namespace helps finding the tag, otherwise the tag will not be found
        for ele in self.root.iter('{http://www.tei-c.org/ns/1.0}item'):
            print('entered here')
            print(ele.attrib)
            child=ET.Element("interpGrp")
            grandChild=ET.Element("interp", corresp="n-test", inst="id-test")
            child.append(grandChild)

            ele.append(child)

            # print(ele.tag, child.tag, grandChild.tag)
            # print(ele.attrib)
        self.element.write("testUpdated.xml")
# tr=TagReader("frage-fragebogen-full-tgd01.xml")
# # tr= TagReader("test.xml")
# tr.AddNewNode()
tr=TagReader("SampleXml")
tr.showAllItemTags()
tags=tr.getAllTags()
print("Number of unique tags: ", len(tags))
for tag in tags:
    print(tag)

attributes=tr.getAllTagsWithAtributes()

print("Number of attributes: ", len(attributes))
for ent in attributes:
    print(ent)
    print(ent, attributes[ent])
print("=========")
for st in tr.getAllAttributeValues():
    print(st)

