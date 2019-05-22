import xml.etree.cElementTree as ET

element=ET.parse("d175_qdb-TEI-02.xml")
root=element.getroot()

# root has a tag and an attrib elements

print(root.tag)
print(root.attrib)

# root also has a children nodes overwhich we can iterate

for child in root:
    print(child.tag, child.attrib)
    # children are nested and we can access them by index or iterating through them
    print(root[0][1])
    for r in child.iter('listPrefixDef'):
        print(r.text)


print("===========")
# print (ET.tostring(root, encoding='utf8').decode('utf8'))
# print([elem.tag for elem in root.iter()])
with open('d175_qdb-TEI-02.xml', 'r', encoding='utf-8') as utf8_file:
    xml_tree = ET.parse(utf8_file)
# element=ET.parse("test.xml")
# print(element)
element=xml_tree
# for node in element.iter():
#     print(node.tag, node.attrib)

for node in element.iter('{http://www.tei-c.org/ns/1.0}body'):
    print('entered here')
    # name=node.attrib.get('xml:id')
    print (node.text)

for node in element.findall('.'):
    print(node.attrib, node.tag)

print("==========")
# parser=ET.XMLPullParser(['start','end'])
# parser.feed('<body>')
# print(list(parser.read_events()))
# parser.feed('</body')
# print(list(parser.read_events()))
# for event, elem in parser.read_events():
#     print(event)
#     print(elem.tag,'text= ',elem.text)
